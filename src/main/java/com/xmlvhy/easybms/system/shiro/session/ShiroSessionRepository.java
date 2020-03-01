package com.xmlvhy.easybms.system.shiro.session;

import org.apache.shiro.session.Session;

import java.io.Serializable;
import java.util.Collection;

/**
 * @Author: 小莫
 * @Date: 2019-07-27 19:26
 * @Description TODO: session 操作接口
 */
public interface ShiroSessionRepository {
    /**
     * 存储Session
     * @param session
     */
    void saveSession(Session session);
    /**
     * 删除session
     * @param sessionId
     */
    void deleteSession(Serializable sessionId);
    /**
     * 获取session
     * @param sessionId
     * @return
     */
    Session getSession(Serializable sessionId);
    /**
     * 获取所有sessoin
     * @return
     */
    Collection<Session> getAllSessions();
}
