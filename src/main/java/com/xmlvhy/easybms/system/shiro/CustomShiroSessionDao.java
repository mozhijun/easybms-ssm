package com.xmlvhy.easybms.system.shiro;

import com.xmlvhy.easybms.system.shiro.session.ShiroSessionRepository;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;

import java.io.Serializable;
import java.util.Collection;

/**
 * @Author: 小莫
 * @Date: 2019-07-27 20:29
 * @Description TODO：session 操作接口
 */
@Slf4j
public class CustomShiroSessionDao extends AbstractSessionDAO {

    private ShiroSessionRepository shiroSessionRepository;

    /**
     * 获取ShiroSessionRepository对象实例
     */
    public ShiroSessionRepository getShiroSessionRepository() {
        return shiroSessionRepository;
    }

    /**
     * 注入ShiroSessionRepository对象实例
     */
    public void setShiroSessionRepository(
            ShiroSessionRepository shiroSessionRepository) {
        this.shiroSessionRepository = shiroSessionRepository;
    }

    /**
     * 功能描述: 更新session
     *
     * @param session
     * @return void
     * @Author 小莫
     * @Date 20:35 2019/07/27
     */
    @Override
    public void update(Session session) throws UnknownSessionException {
        getShiroSessionRepository().saveSession(session);
    }

    /**
     * 功能描述: 删除session
     *
     * @param session
     * @return void
     * @Author 小莫
     * @Date 20:33 2019/07/27
     */
    @Override
    public void delete(Session session) {
        if (session == null) {
            log.error("Session不能为null");
            return;
        }
        Serializable id = session.getId();
        if (id != null)
            getShiroSessionRepository().deleteSession(id);
    }

    /**
     * 功能描述: 获取所有session
     *
     * @param
     * @return java.util.Collection<org.apache.shiro.session.Session>
     * @Author 小莫
     * @Date 20:34 2019/07/27
     */
    @Override
    public Collection<Session> getActiveSessions() {
        return getShiroSessionRepository().getAllSessions();
    }

    /**
     * 功能描述: 创建一个 session
     *
     * @param session
     * @return java.io.Serializable
     * @Author 小莫
     * @Date 20:34 2019/07/27
     */
    @Override
    protected Serializable doCreate(Session session) {
        Serializable sessionId = this.generateSessionId(session);
        this.assignSessionId(session, sessionId);
        getShiroSessionRepository().saveSession(session);
        return sessionId;
    }

    /**
     * 功能描述: 获取一个session
     *
     * @param sessionId
     * @return org.apache.shiro.session.Session
     * @Author 小莫
     * @Date 20:34 2019/07/27
     */
    @Override
    protected Session doReadSession(Serializable sessionId) {
        return getShiroSessionRepository().getSession(sessionId);
    }
}
