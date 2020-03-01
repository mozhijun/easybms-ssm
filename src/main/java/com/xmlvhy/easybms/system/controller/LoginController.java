package com.xmlvhy.easybms.system.controller;

import com.xmlvhy.easybms.system.constant.SysConstant;
import com.xmlvhy.easybms.system.entity.LogLogin;
import com.xmlvhy.easybms.system.entity.User;
import com.xmlvhy.easybms.system.service.LoginLogService;
import com.xmlvhy.easybms.system.service.PermissionService;
import com.xmlvhy.easybms.system.utils.ActiveUser;
import com.xmlvhy.easybms.system.utils.IpUtil;
import com.xmlvhy.easybms.system.utils.TreeNode;
import com.xmlvhy.easybms.system.utils.UserAgentUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName LoginController
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/04 16:33
 * @Version 1.0
 **/
@Controller
@RequestMapping("/login")
@Slf4j
@Api(tags = "用户登录模块", description = "用户登录相关接口")
public class LoginController {

    @Autowired
    private PermissionService permissionService;

    @Autowired
    private LoginLogService loginLogService;

    /**
     * 功能描述: 跳转登录页面
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 11:29 2019/07/19
     */
    @RequestMapping(value = "toLogin.page", method = RequestMethod.GET)
    @ApiOperation(value = "登录页面", notes = "跳转到登录页面")
    public String toLogin() {
        return "system/main/login";
    }

    /**
     * 功能描述: 用户登录
     *
     * @param request
     * @param session
     * @return java.lang.String
     * @Author 小莫
     * @Date 11:29 2019/07/19
     */
    @RequestMapping(value = "login.json", method = RequestMethod.POST)
    @ApiOperation(value = "登录", notes = "用户登录，通过登录名和登录密码验证")
    @ResponseBody
    public Map<String, Object> login(HttpServletRequest request, HttpSession session) {

        String loginname = request.getParameter("loginname");
        String pwd = request.getParameter("pwd");
        String verifyCode = request.getParameter("verifyCode");

        Map<String, Object> ret = new HashMap<>();

        /**
         * 判断验证码是否相等
         */
        String codeInServer = (String) session.getAttribute("verifyCode");
        if (!(verifyCode != null && verifyCode.equalsIgnoreCase(codeInServer))) {
            ret.put("code", 4);
            ret.put("msg", "验证码不正确");
            return ret;
        }

        if (StringUtils.isBlank(loginname) || StringUtils.isBlank(pwd)) {
            ret.put("code", 3);
            ret.put("msg", "用户名或密码不能为空");
            return ret;
        }

        /**
         * 1.创建UserNamePasswordToken
         */
        UsernamePasswordToken token = new UsernamePasswordToken(loginname, pwd);
        /**
         * 2.得到Subject
         */
        Subject subject = SecurityUtils.getSubject();
        try {
            subject.login(token);
            log.info("当前用户：{}，认证成功", loginname);
            /**
             * 获取ActiveUser
             */
            ActiveUser activeUser = (ActiveUser) subject.getPrincipal();
            session.setAttribute("user", activeUser.getCurrentUser());

            /**
             * 保存登录日志
             */
            String userAgent = UserAgentUtil.getUserAgent(request);

            LogLogin logLogin = new LogLogin();
            //用户名
            logLogin.setName(activeUser.getCurrentUser().getName());
            //登录名
            logLogin.setLoginName(loginname);
            //设备名称
            logLogin.setDevice(UserAgentUtil.getOs(request));
            //操作系统名称
            logLogin.setOsName(UserAgentUtil.getOsName(request));
            //浏览器类型
            logLogin.setBrowserType(UserAgentUtil.getBorderName(request));
            //登录IP
            logLogin.setLoginIp(IpUtil.getRealClientIp(request));
            //登录时间
            logLogin.setLoginTime(new Date());
            loginLogService.saveLoginLog(logLogin);
            log.info("logLogin: {}",logLogin.toString());

            ret.put("code", 0);
            ret.put("msg", "登录成功");
            return ret;
        } catch (IncorrectCredentialsException e) {
            log.error("登录密码不正确, e: {}", e.getMessage());

            ret.put("code", 1);
            ret.put("msg", "密码不正确");
            return ret;
        } catch (UnknownAccountException e) {
            log.error("用户不存在，e: {}", e.getMessage());

            ret.put("code", 2);
            ret.put("msg", "用户不存在");
            return ret;
        }
    }

    /**
     * 功能描述: 跳转到首页
     *
     * @param
     * @return java.lang.String
     * @Author 小莫
     * @Date 13:38 2019/07/20
     */
    @RequestMapping(value = "main.page", method = RequestMethod.GET)
    @ApiOperation(value = "跳转到首页", notes = "用户登录成功，跳转到首页")
    public String toIndexPage() {
        return "system/main/index";
    }

    /**
     * 功能描述: 加载系统左侧导航菜单
     *
     * @param session
     * @return java.util.List<com.xmlvhy.easybms.system.utils.TreeNode>
     * @Author 小莫
     * @Date 11:32 2019/07/19
     */
    @RequestMapping(value = "loadIndexTreeMenus.json", method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(value = "左侧导航菜单菜单树", notes = "加载左侧导航栏菜单树")
    public List<TreeNode> loadIndexTreeMenus(HttpSession session) {
        /**
         * TODO:
         * 这里获取登录用户，然后根据用户类型以及用户找到对应拥有的菜单
         * 用户类型：超级管理员，系统隐藏的用户将拥有系统全部的菜单
         * 普通用户：根据登录用户，从session中取到用户信息，根据用户ID找到对应用户拥有的菜单
         * 导航菜单由于只有两层：这里设置RootID = 1
         */
        User user = (User) session.getAttribute("user");
        return permissionService.getNavTreeMenus(user, SysConstant.TREE_ROOT_ID_ONE);
    }
}
