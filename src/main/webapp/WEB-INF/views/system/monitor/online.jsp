<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>系统监控-在线用户</title>
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
<div class="layui-fluid">
    <div class="layui-card" style="margin-top: 15px;">
        <div class="layui-card-body">
            <%--查询条件开始--%>
            <form class="layui-form tool-bar" id="searchFrm">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">登录账号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="onlineUserinName" id="onlineUserinName" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">登录地点</label>
                        <div class="layui-input-inline">
                            <input type="text" name="onlineUserinLocation" id="onlineUserinLocation" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <a href="javascript:void(0)" class="search_btn layui-btn"><i class="layui-icon">&#xe615;</i> 查询</a>
                        <button type="reset" class="layui-btn layui-btn-warm"><i class="layui-icon">&#xe666;</i> 重置
                        </button>
                    </div>
                </div>
            </form>
            <%--查询条件结束--%>

            <!-- 数据表格开始-->
            <table id="onlineUserInfoList" lay-filter="onlineUserInfoList"></table>
        </div>
    </div>
</div>

<!-- 表格数据工条 -->
<script type="text/html" id="onlineUserInfoListBar">
    <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="killOut">踢出</a>
</script>
<!-- 数据表格结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">

    layui.use(['layer', 'jquery', 'form', 'element', 'table', 'laytpl'], function () {
        var layer = layui.layer,
            form = layui.form,
            element = layui.element,
            table = layui.table,
            laytpl = layui.laytpl,
            $ = layui.jquery;

        //TODO:所有功能待实现

        /**
         * 日志列表
         */
        var tableIns = table.render({
            elem: '#onlineUserInfoList',
            <%--url: '${ctx}/server/loadAllOnlineUserInfo.json',--%>
            url: '${ctx}/resources/json/online.json',
            cellMinWidth: 95,
            toolbar: '#tableToolBar',
            page: true,
            method: 'get',
            height: "full-180",
            limit: 10,
            limits: [10, 15, 20, 25],
            defaultToolbar: ['filter', 'print', 'exports'],
            id: "onlineUserInfoListTable",
            cols: [[
                {type: "checkbox", fixed: "left", width: 80},
                {field: 'id', title: 'ID', width: 80, align: "center"},
                {field: 'sessionId', title: '会话编号', align: "center", width: 120},
                {field: 'loginName', title: '登录名称', align: "center", width: 120},
                {field: 'deptName', title: '部门名称', align: 'center', width: 120},
                {field: 'ipAddr', title: '主机IP', align: 'center', width: 120},
                {field: 'loginLocation', title: '登录地点', align: 'center', width: 120},
                {field: 'browserType', title: '浏览器', align: 'center', width: 100},
                {field: 'osName', title: '操作系统', align: 'center', width: 100},
                {
                    field: 'status', title: '会话状态', align: 'center', width: 100, templet:
                        function (data) {
                            return data.status == 1 ? '<span class="layui-badge layui-bg-green">在线</span>' : '<span class="layui-badge layui-bg-gray">离线</span>';
                        }
                },
                {field: 'onlineUserLoginTime', title: '登陆时间', align: 'center'},
                {field: 'lastAccessTime', title: '最后访问时间', align: 'center'},
                {title: '操作', width: 100, templet: '#onlineUserInfoListBar', fixed: "right", align: "center"}
            ]]
        });

        /**
         * 搜索重载表格数据
         */
        $('.search_btn').click(function () {
            table.reload('onlineUserInfoListTable', {
                //从第一页开始
                page: {
                    curr: 1
                },
                where: {
                    loginName: $('#loginName').val(),
                    loginLocation: $('#loginLocation').val()
                }
            });
        });

        /**
         * 监听表格删除
         */
        table.on('tool(onlineUserInfoList)', function (obj) {
            var layEvent = obj.event,
                data = obj.data;
            if (layEvent === 'killOut') { //删除
                layer.confirm('确定从系统中踢出此用户？', {icon: 3, title: '提示信息'}, function (index) {
                        $.post(
                            "${ctx}/server/killOutOnlineUser.json",
                            {"id": data.id},
                            function (result) {
                                if (result.code == 0) {
                                    layer.msg(result.msg, {icon: 1, time: 2000}, function () {
                                        tableIns.reload();
                                        layer.close(index);
                                    });
                                } else {
                                    layer.msg(result.msg, {icon: 2, time: 3000})
                                    layer.close(index);
                                }
                            });
                    }
                );
            }
        });
    });
</script>
</body>
</html>