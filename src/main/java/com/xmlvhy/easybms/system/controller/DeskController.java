package com.xmlvhy.easybms.system.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @ClassName DeskController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/06 9:00
 * @Version 1.0
 **/
@Controller
@RequestMapping("/desk")
@Api(tags = "工作台模块接口")
public class DeskController {

    /**
     * 功能描述: 跳转到工作台页面
     * @Author 小莫
     * @Date 9:01 2019/07/06
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toDeskManager.page",method = RequestMethod.GET)
    @ApiOperation(value = "工作台页面",notes = "跳转到工作台页面")
    public String toDeskManager(){
        return "system/main/deskManager";
    }

}
