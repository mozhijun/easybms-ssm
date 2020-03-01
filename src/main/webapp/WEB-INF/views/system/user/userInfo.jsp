<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>个人资料</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all"/>
</head>
<body class="childrenBody">
<form class="layui-form layui-row">
    <div class="layui-col-md3 layui-col-xs12 user_right">
        <div class="layui-upload-list">
            <img src="${user.imgpath}" class="layui-upload-img layui-circle userFaceBtn userAvatar" id="userFace">
        </div>
        <button type="button" class="layui-btn layui-btn-primary userFaceBtn"><i class="layui-icon">&#xe67c;</i>更换头像
        </button>
    </div>
    <div class="layui-col-md6 layui-col-xs12">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" value="${user.name}" disabled class="layui-input layui-disabled">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用户组</label>
            <div class="layui-input-block">
                <input type="text" value="超级管理员" disabled class="layui-input layui-disabled">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">真实姓名</label>
            <div class="layui-input-block">
                <input type="text" value="${user.name}" placeholder="请输入真实姓名" lay-verify="required"
                       class="layui-input realName">
            </div>
        </div>
        <div class="layui-form-item" pane="">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block userSex">
                <input type="radio" name="sex"
                ${user.sex == 1 ? 'checked' : ''} value="1" title="男">
                <input type="radio" name="sex"
                ${user.sex == 0 ? 'checked' : ''} value="0" title="女">
                <input type="radio" name="sex"
                ${user.sex == 2 ? 'checked' : ''} value="2" title="保密">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号码</label>
            <div class="layui-input-block">
                <input type="tel" value="15879478453" placeholder="请输入手机号码" lay-verify="phone"
                       class="layui-input userPhone">
            </div>
        </div>
        <div class="layui-form-item userAddress">
            <label class="layui-form-label">家庭住址</label>
            <div class="layui-input-inline">
                <select name="province" lay-filter="province" class="province" disabled>
                    <%--<option value="">请选择市</option>--%>
                    <option value="上海">上海</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="city" lay-filter="city" disabled>
                    <%--<option value="">请选择市</option>--%>
                    <option value="上海市">上海市</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="area" lay-filter="area" disabled>
                    <%--<option value="">请选择县/区</option>--%>
                    <option value="浦东新区">浦东新区</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">个人标签</label>
            <div class="layui-input-block userHobby">
                <input type="checkbox" name="like[Javascript]" checked title="Javascript">
                <input type="checkbox" name="like[JAVA]" checked title="JAVA">
                <input type="checkbox" name="like[Mysql]" checked title="Mysql">
                <input type="checkbox" name="like[Mybatis]" checked title="Mybatis">
                <input type="checkbox" name="like[SpringBoot]" checked title="SpringBoot">
                <input type="checkbox" name="like[Layui]" checked title="Layui">
                <input type="checkbox" name="like[SpringMVC]" checked title="SpringMVC">
                <input type="checkbox" name="like[Redis]" checked title="Redis">
                <input type="checkbox" name="like[JPA]" checked title="JPA">
                <input type="checkbox" name="like[Linux]" checked title="Linux">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-block">
                <input type="text" value="1059224309@qq.com" placeholder="请输入邮箱" lay-verify="email"
                       class="layui-input userEmail">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">个人简介</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入内容" class="layui-textarea myself">${user.remark}</textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="changeUser">更新基本信息</button>
            </div>
        </div>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<%--<script type="text/javascript" src="${ctx}/resources/js/cacheUserInfo.js"></script>--%>
<script type="text/javascript">
    var form, $;
    layui.config({
        base: "${ctx}/resources/js/"
    }).extend({
        "address": "address"
    }).use(['form', 'layer', 'upload', 'laydate', "address"], function (exports) {
        form = layui.form;
        $ = layui.jquery;
        var layer = parent.layer === undefined ? layui.layer : top.layer,
            upload = layui.upload,
            laydate = layui.laydate,
            address = layui.address;

        address.provinces();
        //上传头像
        upload.render({
            elem: '.userFaceBtn',
            acceptMime: 'image/*',
            url: '${ctx}/file/upload.json',
            method: "post",
            data: {"loginname": '${user.loginname}'},
            done: function (res, index, upload) {
                if (res.code == 0) {
                    if (res.data.msg && res.data.msg != '') {
                        //上传头像成功
                        layer.msg(res.data.msg);
                        //同步更新头像显示
                        parent.$('.userAvatar').attr('src',res.data.src);
                    } else {
                        layer.msg("文件上传成功：" + res.data.src);
                    }
                }
                //更新头像显示
                $('#userFace').attr('src', res.data.src);
            }
        });
        //提交个人资料
        form.on("submit(changeUser)", function (data) {
            var index = layer.msg('提交中，请稍候', {icon: 16, time: false, shade: 0.8});
            //将填写的用户信息存到session以便下次调取
            var key, userInfoHtml = '';
            userInfoHtml = {
                'realName': $(".realName").val(),
                'sex': data.field.sex,
                'userPhone': $(".userPhone").val(),
                'province': data.field.province,
                'city': data.field.city,
                'area': data.field.area,
                'userEmail': $(".userEmail").val(),
                'myself': $(".myself").val()
            };
            for (key in data.field) {
                if (key.indexOf("like") != -1) {
                    userInfoHtml[key] = "on";
                }
            }
            // console.log(userInfoHtml);
            window.sessionStorage.setItem("userInfo", JSON.stringify(userInfoHtml));
            setTimeout(function () {
                layer.close(index);
                layer.msg("提交成功！");
            }, 2000);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });
    });
</script>
</body>
</html>
