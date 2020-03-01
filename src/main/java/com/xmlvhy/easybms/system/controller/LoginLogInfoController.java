package com.xmlvhy.easybms.system.controller;

import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.service.LoginLogService;
import com.xmlvhy.easybms.system.vo.LogLoginVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @ClassName LoginLogInfoController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/20 21:50
 * @Version 1.0
 **/
@RequestMapping("/log")
@Controller
@Api(tags = "登录日志")
public class LoginLogInfoController {

    @Autowired
    private LoginLogService loginLogService;

    /**
     * 功能描述: 跳转到登录日志页面
     * @Author 小莫
     * @Date 9:09 2019/07/21
     * @param
     * @return java.lang.String
     */
    @RequestMapping(value = "toLoginLog.page",method = RequestMethod.GET)
    @ApiOperation(value = "登录日志界面",notes = "跳转登录日志界面")
    public String toLoginLogPage(){
        return "system/main/loginLog";
    }

    /**
     * 功能描述: 获取登录日志列表
     * @Author 小莫
     * @Date 11:35 2019/07/21
     * @param logLoginVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "loadAllLogInfo.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "加载日志数据",notes = "加载登录日志数据列表")
    public JsonData loadAllLogInfo(LogLoginVo logLoginVo){
        return loginLogService.getLoginLogByPage(logLoginVo);
    }

    /**
     * 功能描述: 删除登录日志
     * @Author 小莫
     * @Date 19:20 2019/07/21
     * @param
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "deleteLogInfo.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "删除登录日志",notes = "根据登录日志ID删除一条日志")
    public JsonData deleteLogInfo(LogLoginVo logLoginVo){
        try {
            loginLogService.removeOneLoginLogById(logLoginVo.getId());
            return JsonData.success("日志删除成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }

    /**
     * 功能描述: 批量删除日志
     * @Author 小莫
     * @Date 19:50 2019/07/21
     * @param logLoginVo
     * @return com.xmlvhy.easybms.system.common.JsonData
     */
    @RequestMapping(value = "batchDeleteLogInfo.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "批量删除登录日志",notes = "批量删除登录日志")
    public JsonData batchDeleteLogInfo(LogLoginVo logLoginVo){
        try {
            loginLogService.batchDeleteLogInfo(logLoginVo);
            return JsonData.success("日志删除成功");
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }
}
