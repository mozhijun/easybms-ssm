<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all"/>
    <style>
        .layui-form.model-form {
            padding: 25px 30px 0 0;
        }
    </style>
</head>
<body>
<form class="layui-form model-form changePwd" id="modifyPwdFrm" lay-filter="modifyPwdFrm">
    <div class="layui-form-item">
        <label class="layui-form-label">原始密码</label>
        <div class="layui-input-block">
            <input type="password" name="oldPwd" value="" placeholder="请输入旧密码" lay-verify="required|oldPwd"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">新密码</label>
        <div class="layui-input-block">
            <input type="hidden" name="userId" value="${user.id}">
            <input type="password" name="newPwd" id="newPwd" value="" placeholder="请输入新密码" lay-verify="required|newPwd"
                   id="oldPwd"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">确认密码</label>
        <div class="layui-input-block">
            <input type="password" value="" name="confirmPwd" placeholder="请确认密码" lay-verify="required|confirmPwd"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block" align="right">
            <button class="layui-btn layui-btn-primary" id="cancelModifyPwd">取消</button>
            <button class="layui-btn" lay-submit="" lay-filter="changePwd">保存</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery;
        //添加验证规则
        form.verify({
            oldPwd: function (value, item) {
                if (value.length == 0) {
                    return "原始密码不能为空";
                }
                //TODO:异步验证原始密码，如下方式无法实现
                // var data;
                //发送ajax请求后台校验旧密码是否一致
                <%--$.post(--%>
                    <%--'${ctx}/user/checkOldPwd.json',--%>
                    <%--{"oldPwd": value, "userId": ${user.id}},--%>
                    <%--function (result) {--%>
                        <%--console.log("result", result);--%>
                        <%--data.code = result.code;--%>
                    <%--});--%>
                <%--$.ajax({--%>
                    <%--url: '${ctx}/user/checkOldPwd.json',--%>
                    <%--contentType: "application/json",--%>
                    <%--dataType:'json',--%>
                    <%--type: "post",--%>
                    <%--async: false,--%>
                    <%--data: {"oldPwd": value, "userId": ${user.id}},--%>
                    <%--success: function(result) {--%>
                        <%--data = result.code;--%>
                    <%--},--%>
                <%--});--%>
                <%--if (data == 1) {--%>
                    <%--return "原始密码错误,请重新输入！";--%>
                <%--}--%>
            },
            newPwd: function (value, item) {
                if (value.length < 6) {
                    return "密码长度不能小于6位";
                }
            },
            confirmPwd: function (value, item) {
                if (!new RegExp($("#newPwd").val()).test(value)) {
                    return "两次输入密码不一致，请重新输入！";
                }
            }
        });

        /**
         * 提交表单
         */
        form.on("submit(changePwd)", function () {
            // layer.alert(JSON.stringify(data.field));
            var data = $('#modifyPwdFrm').serialize();
            $.post(
                '${ctx}/user/modifyPwd.json',
                data,
                function (result) {
                    if (result.code == 0) {
                        layer.msg(result.msg, {icon: 1, time: 2000},function () {
                            //关闭窗口
                            // var index = parent.layer.getFrameIndex(window.name);
                            // layer.close(index);
                            parent.location.href = '${ctx}/user/logout.page';
                        });

                    } else {
                        layer.msg(result.msg, {icon: 2, time: 2000});
                        $('#modifyPwdFrm')[0].reset();
                    }
                }
            );
            return false;
        });

        /**
         * 取消，关闭窗口
         */
        $('#cancelModifyPwd').click(function () {
            var index = parent.layer.getFrameIndex(window.name);
            layer.close(index);
        })
    });
</script>
</body>
</html>
