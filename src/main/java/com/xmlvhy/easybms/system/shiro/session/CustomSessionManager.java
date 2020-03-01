package com.xmlvhy.easybms.system.shiro.session;

import com.xmlvhy.easybms.system.entity.OnlineUser;
import com.xmlvhy.easybms.system.entity.User;
import com.xmlvhy.easybms.system.shiro.CustomShiroSessionDao;
import com.xmlvhy.easybms.system.utils.ActiveUser;
import com.xmlvhy.easybms.system.utils.StringUtils;
import com.xmlvhy.easybms.system.utils.UserAgentUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.BeanUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

import static org.apache.shiro.subject.support.DefaultSubjectContext.PRINCIPALS_SESSION_KEY;

/**
 * @ClassName CustomSessionManager
 * @Description TODO: 用户session 手动管理
 * @Author 小莫
 * @Date 2019/07/27 20:10
 * @Version 1.0
 **/
@Slf4j
public class CustomSessionManager {
    /**
     * session status
     */
    public static final String SESSION_STATUS = "xiaomo-online-status";

    ShiroSessionRepository shiroSessionRepository;

    CustomShiroSessionDao customShiroSessionDao;

    /**
     * 功能描述: 获取所有的Session用户
     *
     * @param
     * @return java.util.List<com.xmlvhy.easybms.system.entity.OnlineUser>
     * @Author 小莫
     * @Date 22:36 2019/07/27
     */
    public List<OnlineUser> getAllUser() {
        //获取所有session
        Collection<Session> sessions = customShiroSessionDao.getActiveSessions();
        List<OnlineUser> list = new ArrayList<OnlineUser>();

        for (Session session : sessions) {
            OnlineUser onlineUser = getSessionUser(session);
            if (null != onlineUser) {
                list.add(onlineUser);
            }
        }
        return list;
    }

    /**
     * 根据ID查询 SimplePrincipalCollection
     *
     * @param userIds 用户ID
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<SimplePrincipalCollection> getSimplePrincipalCollectionByUserId(Long... userIds) {
        //把userIds 转成Set，好判断
        Set<Long> idset = (Set<Long>) StringUtils.array2Set(userIds);
        //获取所有session
        Collection<Session> sessions = customShiroSessionDao.getActiveSessions();
        //定义返回
        List<SimplePrincipalCollection> list = new ArrayList<SimplePrincipalCollection>();
        for (Session session : sessions) {
            //获取SimplePrincipalCollection
            Object obj = session.getAttribute(PRINCIPALS_SESSION_KEY);
            if (null != obj && obj instanceof SimplePrincipalCollection) {
                //强转
                SimplePrincipalCollection spc = (SimplePrincipalCollection) obj;
                //判断用户，匹配用户ID。
                obj = spc.getPrimaryPrincipal();
                if (null != obj && obj instanceof ActiveUser) {
                    //UUser user = (UUser) obj;
                    /**
                     * 获取用户主体
                     */
                    ActiveUser activeUser = (ActiveUser) obj;
                    User user = activeUser.getCurrentUser();

                    //比较用户ID，符合即加入集合
                    if (null != user && idset.contains(user.getId())) {
                        list.add(spc);
                    }
                }
            }
        }
        return list;
    }


    /**
     * 获取单个Session
     *
     * @param sessionId
     * @return
     */
    public OnlineUser getSession(String sessionId) {
        Session session = shiroSessionRepository.getSession(sessionId);
        OnlineUser onlineUser = getSessionUser(session);
        return onlineUser;
    }

    /**
     * 功能描述: 获取 Session 中的用户信息
     *
     * @param session
     * @return com.xmlvhy.easybms.system.entity.OnlineUser
     * @Author 小莫
     * @Date 22:36 2019/07/27
     */
    private OnlineUser getSessionUser(Session session) {
        //获取session登录信息。
        Object obj = session.getAttribute(PRINCIPALS_SESSION_KEY);
        //Object obj = session.getAttribute("user");
        if (null == obj) {
            return null;
        }
        //确保是 SimplePrincipalCollection对象。
        if (obj instanceof SimplePrincipalCollection) {
            SimplePrincipalCollection spc = (SimplePrincipalCollection) obj;
            /**
             * 获取用户登录的，@link SampleRealm.doGetAuthenticationInfo(...)方法中
             * return new SimpleAuthenticationInfo(user,user.getPswd(), getName());的user 对象。
             */
            obj = spc.getPrimaryPrincipal();
            if (null != obj && obj instanceof ActiveUser) {

                ActiveUser activeUser = (ActiveUser) obj;

                //存储session + user 综合信息
                OnlineUser onlineUser = new OnlineUser();
                BeanUtils.copyProperties(activeUser.getCurrentUser(), onlineUser);
                //主机的ip地址
                onlineUser.setIpaAddr(session.getHost());
                //session ID
                onlineUser.setSessionId(session.getId().toString());
                //session最后一次与系统交互的时间
                onlineUser.setLastAccessTime(session.getLastAccessTime());
                //会话话到期 ttl(ms)
                onlineUser.setExpireTime(session.getTimeout());
                //登录名称
                onlineUser.setLoginName(activeUser.getCurrentUser().getLoginname());
                //部门
                onlineUser.setDeptName(activeUser.getCurrentUser().getDeptname());
                //session创建时间
                onlineUser.setStartTime(session.getStartTimestamp());
                //是否踢出
                SessionStatus sessionStatus = (SessionStatus) session.getAttribute(SESSION_STATUS);
                boolean status = Boolean.TRUE;
                if (null != sessionStatus) {
                    status = sessionStatus.getOnlineStatus();
                }
                onlineUser.setSessionStatus(status);

                /**
                 * 获取浏览器和客户端操作系统信息
                 */
                HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
                if (request != null) {
                    String browser = UserAgentUtil.getBorderName(request);
                    String osName = UserAgentUtil.getOsName(request);
                    onlineUser.setBrowser(browser);
                    onlineUser.setOsName(osName);
                }
                return onlineUser;
            }
        }
        return null;
    }

    /**
     * 改变Session状态
     *
     * @param status     {true:踢出,false:激活}
     * @param sessionIds
     * @return
     */
    public Map<String, Object> changeSessionStatus(Boolean status,
                                                   String sessionIds) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String[] sessionIdArray = null;
            if (sessionIds.indexOf(",") == -1) {
                sessionIdArray = new String[]{sessionIds};
            } else {
                sessionIdArray = sessionIds.split(",");
            }
            for (String id : sessionIdArray) {
                Session session = shiroSessionRepository.getSession(id);
                SessionStatus sessionStatus = new SessionStatus();
                sessionStatus.setOnlineStatus(status);
                session.setAttribute(SESSION_STATUS, sessionStatus);
                customShiroSessionDao.update(session);
            }
            map.put("status", 200);
            map.put("sessionStatus", status ? 1 : 0);
            map.put("sessionStatusText", status ? "踢出" : "激活");
            map.put("sessionStatusTextTd", status ? "有效" : "已踢出");
        } catch (Exception e) {
            log.error("改变Session状态错误，sessionIds: {}", sessionIds);
            map.put("status", 500);
            map.put("message", "改变失败，有可能Session不存在，请刷新再试！");
        }
        return map;
    }

    /**
     * 查询要禁用的用户是否在线。
     *
     * @param id     用户ID
     * @param status 用户状态
     */
    public void forbidUserById(Long id, Long status) {
        //获取所有在线用户
        for (OnlineUser onlineUser : getAllUser()) {
            Integer userId = onlineUser.getId();
            //匹配用户ID
            if (userId.equals(id)) {
                //获取用户Session
                Session session = shiroSessionRepository.getSession(onlineUser.getSessionId());
                //标记用户Session
                SessionStatus sessionStatus = (SessionStatus) session.getAttribute(SESSION_STATUS);
                //是否踢出 true:有效，false：踢出。
                sessionStatus.setOnlineStatus(status.intValue() == 1);
                //更新Session
                customShiroSessionDao.update(session);
            }
        }
    }

    /**
     * 注入ShiroSessionRepository 实例
     */
    public void setShiroSessionRepository(
            ShiroSessionRepository shiroSessionRepository) {
        this.shiroSessionRepository = shiroSessionRepository;
    }

    /**
     * 注入 CustomShiroSessionDao 实例
     */
    public void setCustomShiroSessionDao(CustomShiroSessionDao customShiroSessionDao) {
        this.customShiroSessionDao = customShiroSessionDao;
    }
}
