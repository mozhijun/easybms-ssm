package com.xmlvhy.easybms.system.common;

import com.xmlvhy.easybms.system.exception.EasyBmsException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName EasyBmsExceptionHandler
 * @Description TODO: 全局异常定义
 * @Author 小莫
 * @Date 2019/07/04 22:41
 * @Version 1.0
 **/
@Slf4j
public class EasyBmsExceptionHandler implements HandlerExceptionResolver {

    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception e) {
        //请求的url
        String url = request.getRequestURL().toString();
        ModelAndView mav;
        //默认错误消息
        String defaultMsg = "系统内部错误";
        /**
         * 1. .json  .page 请求结尾来区分是哪种请求方式，也可以通过头来区分
         * 2、 要求项目中所有请求json数据，都是用.json结尾
         */
        if (url.endsWith(".json")) {
            if (e instanceof EasyBmsException) {
                JsonData ret = JsonData.fail(e.getMessage());
                mav = new ModelAndView("jsonView", ret.toMap());
            } else {
                log.error("unknown json exception: {}, url: {}", e, url);
                JsonData ret = JsonData.fail(e.getMessage());
                mav = new ModelAndView("jsonView", ret.toMap());
            }

            /**
             * 1.如果是页面请求出现异常则返回页面
             * 2.项目中要求页面的请求都是以.page结尾
             */
        } else if (url.endsWith(".page")) {
            log.error("unknown page exception: {}, url: {}", e, url);
            JsonData ret = JsonData.fail(defaultMsg);
            mav = new ModelAndView("exception", ret.toMap());
        }else if (e instanceof HttpRequestMethodNotSupportedException){
            log.error("not support request method");
            JsonData ret = new JsonData(500);
            ret.setMsg("不支持 " + e.getMessage() + "请求");
            mav = new ModelAndView("jsonView", ret.toMap());
        }
        else {
            log.error("unknown exception: {}, url: {}", e, url);
            JsonData ret = JsonData.fail(defaultMsg);
            mav = new ModelAndView("jsonView", ret.toMap());
        }
        return mav;
    }
}
