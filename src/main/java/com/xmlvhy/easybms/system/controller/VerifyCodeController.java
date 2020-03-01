package com.xmlvhy.easybms.system.controller;

import com.xmlvhy.easybms.system.utils.verifyCode.Captcha;
import com.xmlvhy.easybms.system.utils.verifyCode.GifCaptcha;
import com.xmlvhy.easybms.system.utils.verifyCode.SpecCaptcha;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @ClassName VerifyCodeController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/28 14:45
 * @Version 1.0
 **/
@RequestMapping("/verify")
@Controller
@Api(tags = "生成验证码")
@Slf4j
public class VerifyCodeController {

    /**
     * 功能描述: 获取验证码（gif版本）
     *
     * @param response
     * @param request
     * @return void
     * @Author 小莫
     * @Date 14:47 2019/07/28
     */
    @RequestMapping(value = "getGifCode", method = RequestMethod.GET)
    public void getGifCode(HttpServletResponse response, HttpServletRequest request) {
        try {
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setContentType("image/gif");
            /**
             * gif格式动画验证码
             * 宽，高，位数。
             */
            Captcha captcha = new GifCaptcha(146, 42, 4);
            //输出
            ServletOutputStream out = response.getOutputStream();
            captcha.out(out);
            out.flush();
            System.out.println();
            String verifyCode = captcha.text().toLowerCase();
            log.info("gif verifyCode: {}", verifyCode);
            request.getSession().setAttribute("verifyCode", verifyCode);
        } catch (Exception e) {
            log.error("获取gif验证码异常,e: {}", e);
        }
    }

    /**
     * 获取验证码（jpg版本）
     *
     * @param response
     */
    @RequestMapping(value = "getJpgCode", method = RequestMethod.GET)
    public void getJPGCode(HttpServletResponse response, HttpServletRequest request) {
        try {
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            response.setContentType("image/jpg");
            /**
             * jgp格式验证码
             * 宽，高，位数。
             */
            Captcha captcha = new SpecCaptcha(146, 33, 4);
            //输出
            captcha.out(response.getOutputStream());

            HttpSession session = request.getSession(true);
            String verifyCode = captcha.text().toLowerCase();
            log.info("jpg verifyCode: {}", verifyCode);

            //存入Session
            session.setAttribute("verifyCode", verifyCode);
        } catch (Exception e) {
            log.info("获取jpg验证码异常, e: {}", e);
        }
    }
}
