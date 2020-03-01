package com.xmlvhy.easybms.system.entity.server;

/**
 * @ClassName SystemInfo
 * @Description TODO:系统信息
 * @Author 小莫
 * @Date 2019/07/25 14:21
 * @Version 1.0
 **/
public class SystemInfo {

    /**
     * 服务器名称
     */
    private String serverName;
    /**
     * 服务器IP
     */
    private String serverIp;
    /**
     * 项目路径
     */
    private String projectDir;
    /**
     * 操作系统名称
     */
    private String osName;
    /**
     * 系统架构
     */
    private String osArch;

    public String getServerName() {
        return serverName;
    }

    public void setServerName(String serverName) {
        this.serverName = serverName;
    }

    public String getServerIp() {
        return serverIp;
    }

    public void setServerIp(String serverIp) {
        this.serverIp = serverIp;
    }

    public String getProjectDir() {
        return projectDir;
    }

    public void setProjectDir(String projectDir) {
        this.projectDir = projectDir;
    }

    public String getOsName() {
        return osName;
    }

    public void setOsName(String osName) {
        this.osName = osName;
    }

    public String getOsArch() {
        return osArch;
    }

    public void setOsArch(String osArch) {
        this.osArch = osArch;
    }
}
