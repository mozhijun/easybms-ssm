<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>公告管理</title>
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
                        <label class="layui-form-label">公告标题</label>
                        <div class="layui-input-inline">
                            <input type="text" name="noticeTitle" id="noticeTitle" autocomplete="off"
                                   class="layui-input" placeholder="请输入公告标题">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">创建者</label>
                        <div class="layui-input-inline">
                            <input type="text" name="createBy" id="createBy" autocomplete="off"
                                   class="layui-input" placeholder="请输入创建者名称">
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
                        <shiro:hasPermission name="notice:view">
                            <a href="javascript:void(0)" class="search_btn layui-btn">查询</a>
                            <button type="reset" class="layui-btn layui-btn-warm">重置</button>
                        </shiro:hasPermission>
                    </div>
                </div>
            </form>
            <%--查询条件结束--%>

            <!-- 数据表格开始-->
            <table id="noticeInfoList" lay-filter="noticeInfoList"></table>
        </div>
    </div>
</div>
<!--表格工具条-->
<script type="text/html" id="tableToolBar">
    <shiro:hasPermission name="notice:add">
        <a class="layui-btn layui-btn-normal" lay-event="addNotice">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="notice:bacthDelte">
        <a class="layui-btn layui-btn-danger" lay-event="batchDel">批量删除</a>
    </shiro:hasPermission>
</script>
<!-- 表格数据工条 -->
<script type="text/html" id="noticeInfoListBar">
    <shiro:hasPermission name="notice:update">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="notice:delete">
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
    </shiro:hasPermission>
</script>
<!-- 数据表格结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    var tableIns;
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
        tableIns = table.render({
            elem: '#noticeInfoList',
            url: '${ctx}/notice/loadAllNoticeInfo.json',
            cellMinWidth: 95,
            toolbar: '#tableToolBar',
            page: true,
            method: 'post',
            height: "full-180",
            limit: 10,
            limits: [10, 15, 20, 25],
            defaultToolbar: ['filter', 'print', 'exports'],
            id: "noticeInfoListTable",
            cols: [[
                {type: "checkbox", fixed: "left", width: 80},
                {field: 'noticeId', title: 'ID', width: 80, align: "center"},
                {field: 'noticeTitle', title: '公告标题', align: "center", width: 200},
                {
                    field: 'noticeType', title: '公告类型', align: "center", width: 110, templet:
                        function (data) {
                            return data.noticeType == 1 ? '<span class="layui-badge layui-bg-blue">通知</span>' :
                                '<span class="layui-badge layui-bg-orange">公告</span>';
                        }
                },
                {
                    field: 'status', title: '状态', align: 'center', width: 110, templet: function (data) {
                        return data.status == 1 ? '<span class="layui-badge layui-bg-green">启用</span>' :
                            '<span class="layui-badge">禁用</span>';
                    }
                },
                {field: 'createBy', title: '创建者', align: 'center', width: 130},
                {field: 'createTime', title: '创建时间', align: 'center', width: 170},
                {field: 'updateTime', title: '更新时间', align: 'center', width: 170},
                {field: 'remark', title: '备注', align: 'center', width: 150},
                {field: 'noticeContent', title: '公告内容', align: 'center', width: 350},
                {title: '操作', templet: '#noticeInfoListBar', fixed: "right", align: "center"}
            ]]
            /**
             * 设置当删除表格数据时候，删除最后一条跳转上一页
             * 如果是异步请求数据方式，res即为你接口返回的信息。
             * 如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
             */
            , done: function (res, curr) {
                var currPage = curr; // 获得当前页码
                var dataLength = res.data.length; // 获得当前页的记录数
                var count = res.count; // 获得总记录数

                console.log('currPage: ', curr);
                console.log('dataLength: ', dataLength);
                console.log('count: ', count);

                if (dataLength == 0 && count != 0) { //如果当前页的记录数为0并且总记录数不为0
                    table.reload("noticeInfoListTable", { // 刷新表格到上一页
                        page: {
                            curr: currPage - 1
                        }
                    });
                }
            }
        });

        /**
         * 搜索重载表格数据
         */
        $('.search_btn').click(function () {
            table.reload('noticeInfoListTable', {
                //从第一页开始
                page: {
                    curr: 1
                },
                where: {
                    noticeTitle: $('#noticeTitle').val(),
                    createBy: $('#createBy').val(),
                    startTime: $('#startTime').val(),
                    endTime: $('#endTime').val()
                }
            });
        });

        /**
         * 监听表格删除
         */
        table.on('tool(noticeInfoList)', function (obj) {
            var layEvent = obj.event,
                data = obj.data;
            var value = data.noticeType == 1 ? '通知' : '公告';
            if (layEvent === 'del') { //删除
                layer.confirm('确定删除此【' + value + '】？', {icon: 3, title: '提示信息'}, function (index) {
                        $.post(
                            "${ctx}/notice/deleteNoticeInfo.json",
                            {"noticeId": data.noticeId},
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
            } else if (layEvent == 'edit') { //编辑
                modifyNotice(data.noticeId);
            }
        });

        /**
         * 监听表头工具栏,批量删除
         */
        table.on('toolbar(noticeInfoList)', function (obj) {
            switch (obj.event) {
                case 'batchDel':
                    var checkStatus = table.checkStatus('noticeInfoListTable'),
                        data = checkStatus.data;
                    var ids = new Array();
                    if (data.length > 0) {
                        for (var i in data) {
                            ids[i] = data[i].noticeId;
                        }
                        console.log(ids);
                        layer.confirm('确定删除选中的内容？', {icon: 3, title: '提示信息'},
                            function (index) {
                                $.post("${ctx}/notice/batchDeleteNoticeInfo.json",
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
                case 'addNotice':
                    saveNotice();
                    break;
            }
            ;
        });

        /**
         * 打开添加公告页面
         */
        function saveNotice() {
            //打开弹出层
            var index = layui.layer.open({
                title: "添加公告",
                type: 2,
                area: ['800px', '750px'],
                content: "${ctx}/notice/toSaveNotice.page",
                success: function (layero, index) {
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回公告列表', '.layui-layer-setwin .layui-layer-close', {
                            tips: 3
                        });
                    }, 500);
                }
            });
            //默认所在文档中最大化窗口
            // layui.layer.full(index);
            //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
            $(window).on("resize", function () {
                layui.layer.full(index);
            });
        }

        /**
         * 修改公告
         */
        function modifyNotice(noticeId) {
            //打开弹出层
            var index = layui.layer.open({
                title: "修改公告",
                type: 2,
                area: ['800px', '750px'],
                content: "${ctx}/notice/toModifyNotice.page?noticeId=" + noticeId,
                success: function (layero, index) {
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回公告列表', '.layui-layer-setwin .layui-layer-close', {
                            tips: 3
                        });
                    }, 500);
                }
            });
            //默认所在文档中最大化窗口
            // layui.layer.full(index);
            //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
            $(window).on("resize", function () {
                layui.layer.full(index);
            });
        }
    });
</script>
</body>
</html>