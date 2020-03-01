package com.xmlvhy.easybms.system.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName OnlineUser
 * @Description TODO: 在线用户信息
 * @Author 小莫
 * @Date 2019/07/27 22:08
 * @Version 1.0
 **/
@Data
public class OnlineUser extends User implements Serializable {

    private static final long serialVersionUID = 1L;
    /**
     * 用户会话id
     */
    private String sessionId;

    /**
     * 部门名称
     */
    private String deptName;

    /**
     * 登录名称
     */
    private String loginName;

    /**
     * 登录IP地址
     */
    private String ipaAddr;

    /**
     * 登录地址
     */
    private String loginLocation;

    /**
     * 浏览器类型
     */
    private String browser;

    /**
     * 操作系统
     */
    private String osName;

    /**
     * session创建时间
     */
    private Date startTime;

    /**
     * session最后访问时间
     */
    private Date lastAccessTime;

    /**
     * 超时时间，单位为分钟
     */
    private Long expireTime;

    /**
     * session 是否踢出
     */
    private boolean sessionStatus = Boolean.TRUE;
}
