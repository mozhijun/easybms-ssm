package com.xmlvhy.easybms.system.controller;

import com.google.common.collect.Lists;
import com.xmlvhy.easybms.system.common.BeanValidator;
import com.xmlvhy.easybms.system.common.JsonData;
import com.xmlvhy.easybms.system.exception.EasyBmsException;
import com.xmlvhy.easybms.system.vo.TestVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @ClassName TestController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/04 23:03
 * @Version 1.0
 **/
@Controller
@RequestMapping("/test")
@Slf4j
@Api(tags = "测试模块",description = "此模块用来编写一些测试接口")
public class TestController {

    @RequestMapping(value = "test.page",method = RequestMethod.GET)
    @ApiOperation(value = "测试页面",notes = "模拟用户请求页面出现异常的响应处理")
    public String testPage(){
        log.info("testPage");
        throw new RuntimeException("test view exception");
    }

    @RequestMapping(value = "test.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "测试json模块",notes = "模拟测试请求json接口出现异常的响应情况")
    public JsonData testJson(){
        log.info("testJson");
        //return JsonData.success("success");
        throw new EasyBmsException("test json exception");
    }

    @RequestMapping(value = "validator.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "获取json数据")
    public JsonData testValidator(){
        log.info("testValidator");
        List<String> roles = Lists.newArrayList();
        roles.add("add");
        roles.add("delete");
        roles.add("update");
        roles.add("select");
        TestVo vo = TestVo.builder().age(27).name("小莫").roles(roles).uid(666).build();
        return JsonData.success(vo);
    }

    @RequestMapping(value = "validate.json",method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(value = "测试Bean校验模块",notes = "模拟请求查看beanValidator校验是否有作用")
    public JsonData validator(@RequestBody TestVo testVo){
        log.info("validator");
        try {
            BeanValidator.check(testVo);
            return JsonData.success(testVo);
        }catch (Exception e){
            return JsonData.fail(e.getMessage());
        }
    }
}
