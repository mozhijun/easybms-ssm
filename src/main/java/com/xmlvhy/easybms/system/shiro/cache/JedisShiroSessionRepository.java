package com.xmlvhy.easybms.system.shiro.cache;

import com.xmlvhy.easybms.system.shiro.session.CustomSessionManager;
import com.xmlvhy.easybms.system.shiro.session.SessionStatus;
import com.xmlvhy.easybms.system.shiro.session.ShiroSessionRepository;
import com.xmlvhy.easybms.system.utils.SerializeUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.session.Session;

import java.io.Serializable;
import java.util.Collection;

/**
 * @Author: 小莫
 * @Date: 2019-07-27 19:29
 * @Description TODO: session 管理
 */
@Slf4j
public class JedisShiroSessionRepository implements ShiroSessionRepository {

    public static final String REDIS_SHIRO_SESSION = "xiaomo-shiro-demo-session:";
    //这里有个小BUG，因为Redis使用序列化后，Key反序列化回来发现前面有一段乱码，解决的办法是存储缓存不序列化
    public static final String REDIS_SHIRO_ALL = "*xiaomo-shiro-demo-session:*";
    private static final int SESSION_VAL_TIME_SPAN = 18000;
    private static final int DB_INDEX = 1;

    private JedisManager jedisManager;

    /**
     * 功能描述: 保存session
     * @Author 小莫
     * @Date 20:19 2019/07/27
     * @param session
     * @return void
     */
    @Override
    public void saveSession(Session session) {
        if (session == null || session.getId() == null)
            throw new NullPointerException("session is empty");
        try {
            byte[] key = SerializeUtil.serialize(buildRedisSessionKey(session.getId()));
            //不存在才添加。
            if (null == session.getAttribute(CustomSessionManager.SESSION_STATUS)) {
                //Session 踢出自存存储。
                SessionStatus sessionStatus = new SessionStatus();
                session.setAttribute(CustomSessionManager.SESSION_STATUS, sessionStatus);
            }
            byte[] value = SerializeUtil.serialize(session);
            /**这里是我犯下的一个严重问题，但是也不会是致命，
             * 我计算了下，之前上面不小心给我加了0，也就是 18000 / 3600 = 5 个小时
             * 另外，session设置的是30分钟的话，并且加了一个(5 * 60)，一起算下来，session的失效时间是 5:35 的概念才会失效
             * 我原来是存储session的有效期会比session的有效期会长，而且最终session的有效期是在这里【SESSION_VAL_TIME_SPAN】设置的。
             *
             * 这里没有走【shiro-config.properties】配置文件，需要注意的是【spring-shiro.xml】 也是直接配置的值，没有走【shiro-config.properties】
             *
             * PS  : 注意： 这里我们配置 redis的TTL单位是秒，而【spring-shiro.xml】配置的是需要加3个0（毫秒）。
             long sessionTimeOut = session.getTimeout() / 1000;
             Long expireTime = sessionTimeOut + SESSION_VAL_TIME_SPAN + (5 * 60);
             */


            /*
            直接使用 (int) (session.getTimeout() / 1000) 的话，session失效和redis的TTL 同时生效
             */
            getJedisManager().saveValueByKey(DB_INDEX, key, value, (int) (session.getTimeout() / 1000));
        } catch (Exception e) {
            log.error("保存session出错，e: {}, id: {}",e,session.getId());
        }
    }

    /**
     * 功能描述: 删除session
     * @Author 小莫
     * @Date 20:19 2019/07/27
     * @param id
     * @return void
     */
    @Override
    public void deleteSession(Serializable id) {
        if (id == null) {
            throw new NullPointerException("session id is empty");
        }
        try {
            getJedisManager().deleteByKey(DB_INDEX,
                    SerializeUtil.serialize(buildRedisSessionKey(id)));
        } catch (Exception e) {
            log.error("删除session出现异常，e: {}, id: {}",e,id);
        }
    }

    /**
     * 功能描述: 获取 session
     * @Author 小莫
     * @Date 20:18 2019/07/27
     * @param id
     * @return org.apache.shiro.session.Session
     */
    @Override
    public Session getSession(Serializable id) {
        if (id == null)
            throw new NullPointerException("session id is empty");
        Session session = null;
        try {
            byte[] value = getJedisManager().getValueByKey(DB_INDEX, SerializeUtil
                    .serialize(buildRedisSessionKey(id)));
            session = SerializeUtil.deserialize(value, Session.class);
        } catch (Exception e) {
            log.error("获取session异常，e: {}, id: {}",e,id);
        }
        return session;
    }

    /**
     * 功能描述: 获取所有session
     * @Author 小莫
     * @Date 20:19 2019/07/27
     * @param
     * @return java.util.Collection<org.apache.shiro.session.Session>
     */
    @Override
    public Collection<Session> getAllSessions() {
        Collection<Session> sessions = null;
        try {
            sessions = getJedisManager().AllSession(DB_INDEX, REDIS_SHIRO_SESSION);
        } catch (Exception e) {
            log.error("获取全部session异常，e: {}, id: {}",e);
        }
        return sessions;
    }

    /**
     * 功能描述: 生成一个session id
     * @Author 小莫
     * @Date 20:20 2019/07/27
     * @param sessionId
     * @return java.lang.String
     */
    private String buildRedisSessionKey(Serializable sessionId) {
        return REDIS_SHIRO_SESSION + sessionId;
    }

    public JedisManager getJedisManager() {
        return jedisManager;
    }

    public void setJedisManager(JedisManager jedisManager) {
        this.jedisManager = jedisManager;
    }
}
