package com.xmlvhy.easybms.system.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @ClassName ResourceManagerController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/22 11:13
 * @Version 1.0
 **/
@Controller
@RequestMapping("/resource")
@Api(tags = "资源管理")
public class ResourceManagerController {

    /**
     * 功能描述: 跳转图标管理页面
     * @Author 小莫
     * @Date 17:39 2019/07/22
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toIcon.page", method = RequestMethod.GET)
    @ApiOperation(value = "跳转图标管理页面")
    public String iconManager() {
        return "system/resource/icon";
    }

    /**
     * 功能描述: 跳转七牛云存储配置页面
     * @Author 小莫
     * @Date 17:41 2019/07/22
     * @param
     * @return java.lang.String
     */
    @RequestMapping("toQiniuInfo.page")
    @ApiOperation(value = "七牛云存储配置页面")
    public String qiniuInfo(){
        return "system/resource/qiniu";
    }

    /**
     * 功能描述: 跳转阿里云存储配置页面
     * @Author 小莫
     * @Date 17:42 2019/07/22
     * @param
     * @return java.lang.String
     */
    @RequestMapping("toOssInfo.page")
    @ApiOperation(value = "阿里云存储配置页面")
    public String toOssInfo(){
        return "system/resource/oss";
    }
}
