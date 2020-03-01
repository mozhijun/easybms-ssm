package com.xmlvhy.easybms.system.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @ClassName SiteManagerController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/22 15:48
 * @Version 1.0
 **/
@RequestMapping("/site")
@Controller
@Api(tags = "站点管理")
public class SiteManagerController {

    /**
     * 功能描述: 跳转到站点管理界面
     * @Author 小莫
     * @Date 10:17 2019/07/27
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toSite.page",method = RequestMethod.GET)
    @ApiOperation(value = "站点管理页面")
    public String toSitePage(){
        return "system/site/siteManager";
    }

    /**
     * 功能描述: 系统参数：邮件，站点等基本信息设置页面
     * @Author 小莫
     * @Date 10:19 2019/07/27
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toSystemParams.page",method = RequestMethod.GET)
    @ApiOperation(value = "跳转系统参数设置页面")
    public String toSystemParamsPage(){
        return "system/site/systemParams";
    }
}
