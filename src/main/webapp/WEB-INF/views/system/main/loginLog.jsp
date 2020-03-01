<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>日志管理</title>
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
                            <input type="text" name="loginName" id="loginName" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">开始时间</label>
                        <div class="layui-input-inline">
                            <input type="text" name="startTime" id="startTime" placeholder="yyyy-MM-dd HH:mm:ss"
                                   autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">结束时间</label>
                        <div class="layui-input-inline">
                            <input type="text" name="endTime" id="endTime" placeholder="yyyy-MM-dd HH:mm:ss"
                                   autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <shiro:hasPermission name="loginLog:view">
                            <a href="javascript:void(0)" class="search_btn layui-btn">查询</a>
                            <button type="reset" class="layui-btn layui-btn-warm">重置</button>
                        </shiro:hasPermission>
                    </div>
                </div>
            </form>
            <%--查询条件结束--%>

            <!-- 数据表格开始-->
            <table id="logInfoList" lay-filter="logInfoList"></table>
        </div>
    </div>
</div>
<!--表格工具条-->
<script type="text/html" id="tableToolBar">
    <shiro:hasPermission name="loginLog:batchDelete">
        <a class="layui-btn layui-btn layui-btn-danger" lay-event="batchDel">批量删除</a>
    </shiro:hasPermission>
</script>
<!-- 表格数据工条 -->
<script type="text/html" id="logInfoListBar">
    <shiro:hasPermission name="loginLog:delete">
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
    </shiro:hasPermission>
</script>
<!-- 数据表格结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">

    layui.use(['layer', 'jquery', 'form', 'element', 'table', 'laydate', 'laytpl'], function () {
        var layer = layui.layer,
            form = layui.form,
            element = layui.element,
            table = layui.table,
            laytpl = layui.laytpl,
            $ = layui.jquery,
            laydate = layui.laydate;

        /**
         * 开始时间
         */
        laydate.render({
            elem: '#startTime',
            type: 'datetime'
        });
        /**
         * 结束时间
         */
        laydate.render({
            elem: '#endTime',
            type: 'datetime'
        });

        /**
         * 日志列表
         */
        var tableIns = table.render({
            elem: '#logInfoList',
            url: '${ctx}/log/loadAllLogInfo.json',
            cellMinWidth: 95,
            toolbar: '#tableToolBar',
            page: true,
            method: 'post',
            height: "full-180",
            limit: 10,
            limits: [10, 15, 20, 25],
            defaultToolbar: ['filter', 'print', 'exports'],
            id: "logInfoListTable",
            cols: [[
                {type: "checkbox", fixed: "left", width: 80},
                {field: 'id', title: 'ID', width: 80, align: "center"},
                {field: 'loginName', title: '登录账号', align: "center", width: 120},
                {field: 'name', title: '用户名', align: "center", width: 120},
                {field: 'loginIp', title: 'IP', align: 'center'},
                {field: 'device', title: '设备', align: 'center'},
                {field: 'osName', title: '操作系统', align: 'center'},
                {field: 'browserType', title: '浏览器', width: 100, align: 'center'},
                {field: 'loginTime', title: '登陆时间', align: 'center'},
                {title: '操作', width: 100, templet: '#logInfoListBar', fixed: "right", align: "center"}
            ]]
        });

        /**
         * 搜索重载表格数据
         */
        $('.search_btn').click(function () {
            table.reload('logInfoListTable', {
                //从第一页开始
                page: {
                    curr: 1
                },
                where: {
                    loginName: $('#loginName').val(),
                    startTime: $('#startTime').val(),
                    endTime: $('#endTime').val()
                }
            });
        });

        /**
         * 监听表格删除
         */
        table.on('tool(logInfoList)', function (obj) {
            var layEvent = obj.event,
                data = obj.data;
            if (layEvent === 'del') { //删除
                layer.confirm('确定删除此日志？', {icon: 3, title: '提示信息'}, function (index) {
                        $.post(
                            "${ctx}/log/deleteLogInfo.json",
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

        /**
         * 监听表头工具栏,批量删除
         */
        table.on('toolbar(logInfoList)', function (obj) {
            switch (obj.event) {
                case 'batchDel':
                    var checkStatus = table.checkStatus('logInfoListTable'),
                        data = checkStatus.data;
                    var ids = new Array();
                    if (data.length > 0) {
                        for (var i in data) {
                            ids[i] = data[i].id;
                        }
                        console.log(ids);
                        layer.confirm('确定删除选中的日志？', {icon: 3, title: '提示信息'},
                            function (index) {
                                $.post("${ctx}/log/batchDeleteLogInfo.json",
                                    {"ids": ids + ""}, function (result) {
                                        if (result.code == 0) {
                                            layer.msg(result.msg, {icon: 1, time: 2000}, function () {
                                                tableIns.reload();
                                                layer.close(index);
                                            });
                                        }
                                    });
                            });
                    } else {
                        layer.msg("请选择需要删除的日志", {icon: 7, time: 2000});
                    }
                    break;
            }
            ;
        });
    })
    ;
</script>
</body>
</html>