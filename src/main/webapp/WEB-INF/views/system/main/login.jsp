<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="loginHtml">
<head>
    <meta charset="utf-8">
    <title>用户登录-EaseBMS</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${ctx}/resources/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all"/>
</head>
<body class="loginBody">
<form class="layui-form" id="loginFrm">
    <div class="login_face" id="notice"><img src="${ctx}/resources/images/log.png" class="userAvatar"></div>
    <div class="layui-form-item input-item">
        <label for="loginName">用户名</label>
        <input type="text" placeholder="请输入用户名" autocomplete="off" name="loginname" id="loginName"
               class="layui-input"
               lay-verify="required">
    </div>
    <div class="layui-form-item input-item">
        <label for="password">密码</label>
        <input type="password" placeholder="请输入密码" autocomplete="off" name="pwd" id="password"
               class="layui-input"
               lay-verify="required">
    </div>
    <div class="layui-form-item input-item" id="imgCode">
        <label for="verifyCode">验证码</label>
        <input type="text" placeholder="请输入验证码" name="verifyCode" autocomplete="off" id="verifyCode"
               lay-verify="required" class="layui-input" style="width: 110px; ">
        <img src="${ctx}/verify/getGifCode">
    </div>
    <div class="layui-form-item">
        <button class="layui-btn layui-block" id="login" lay-filter="login" lay-submit>登录</button>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">

    if (top != self) {
        parent.location.href = '/login/toLogin.page';
    }

    layui.use(['form', 'layer', 'jquery'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer
        $ = layui.jquery;

        /**
         * 点击验证码加载新的验证码
         */
        $('#imgCode').on('click', 'img', function () {
            /** 动态验证码，改变地址 **/
            var i = new Image();
            i.src = '${ctx}/verify/getGifCode?' + Math.random();
            $(i).replaceAll(this);
        });

        layer.tips('演示系统账号: admin 密码: admin123', '#notice',
            {tips: [1, "#FFB800"], time: 0, closeBtn: 0, area: ['260px', '45px'],}
        );
        //登录按钮
        form.on("submit(login)", function (data) {
            $('#login').text("登录中...").attr("disabled", "disabled").addClass("layui-disabled");
            var data = $('#loginFrm').serialize();
            layer.load(0, {shade: 0.5, time: false});
            $.post(
                '${ctx}/login/login.json',
                data,
                function (result) {
                    if (result.code == 0) {
                        setTimeout(function () {
                            layer.closeAll('loading');
                            $('#login').text("登录").attr("disabled", false).removeClass("layui-disabled");
                            layer.msg(result.msg, {icon: 1, time: 1000}, function () {
                                //登录成功,跳转到首页
                                location.href = '${ctx}/login/main.page';
                            });
                        }, 1200);
                    } else {
                        if (result.code == 1) {
                            layer.closeAll('loading');
                            $('#login').text("登录").attr("disabled", false).removeClass("layui-disabled");
                            layer.tips(result.msg, '#password', {
                                tips: [2, '#ff4c4d'],
                                time: 2000
                            });
                        } else if (result.code == 2) {
                            layer.closeAll('loading');
                            $('#login').text("登录").attr("disabled", false).removeClass("layui-disabled");
                            layer.tips(result.msg, '#loginName', {
                                tips: [2, '#ff4c4d'],
                                time: 2000
                            });
                        } else if (result.code == 4) {
                            layer.closeAll('loading');
                            $('#login').text("登录").attr("disabled", false).removeClass("layui-disabled");
                            layer.tips(result.msg, '#imgCode', {
                                tips: [2, '#ff4c4d'],
                                time: 2000
                            });
                        } else {
                            layer.closeAll('loading');
                            $('#login').text("登录").attr("disabled", false).removeClass("layui-disabled");
                            layer.msg(result.msg, {icon: 5, time: 2000});
                        }
                    }
                }
            );
            return false;
        });


        //表单输入效果
        $(".loginBody .input-item").click(function (e) {
            e.stopPropagation();
            $(this).addClass("layui-input-focus").find(".layui-input").focus();
        })
        $(".loginBody .layui-form-item .layui-input").focus(function () {
            $(this).parent().addClass("layui-input-focus");
        })
        $(".loginBody .layui-form-item .layui-input").blur(function () {
            $(this).parent().removeClass("layui-input-focus");
            if ($(this).val() != '') {
                $(this).parent().addClass("layui-input-active");
            } else {
                $(this).parent().removeClass("layui-input-active");
            }
        });
    });
</script>
</body>
</html>