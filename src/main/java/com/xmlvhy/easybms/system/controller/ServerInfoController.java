package com.xmlvhy.easybms.system.controller;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.entity.server.ServerInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @ClassName ServerInfoController
 * @Description TODO:或去服务器相关信息：jvm 内存 磁盘 等
 * @Author 小莫
 * @Date 2019/07/25 14:57
 * @Version 1.0
 **/
@Controller
@RequestMapping("/server")
@Api(tags = "获取服务器相关信息")
public class ServerInfoController {
    /**
     * 功能描述: 获取服务器信息
     *
     * @param
     * @return com.xmlvhy.easybms.system.common.JsonData
     * @Author 小莫
     * @Date 22:59 2019/07/25
     */
    @RequestMapping(value = "getServerInfo.json", method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "获取服务器相关信息")
    public JsonData getServerInfo() {
        ServerInfo info = new ServerInfo();
        try {
            info.serverInfoAdapt();
            return JsonData.success("获取信息成功", info);
        } catch (Exception e) {
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 跳转服务监控页面
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 22:59 2019/07/25
     */
    @RequestMapping(value = "monitor.page", method = RequestMethod.GET)
    @ApiOperation(value = "服务监控页面")
    public String monitorPage() {
        return "system/monitor/server";
    }

    /**
     * 功能描述: 在线用户页面
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 8:52 2019/07/27
     */
    @RequestMapping(value = "toOnlineUser.page", method = RequestMethod.GET)
    @ApiOperation(value = "在线用户页面")
    public String onlineUserPage() {
        return "system/monitor/online";
    }

    //
    //@RequestMapping("getOnlineUsers.json")
    //@ResponseBody
    //@ApiOperation(value = "获取所有在线用户",notes = "通过shiro session管理器获取在线用户")
    //public JsonData getOnlineUsers() {
    //    List<OnlineUser> onlineUsers = customSessionManager.getAllUser();
    //    return JsonData.success("成功获取在线用户信息", onlineUsers);
    //}
}
