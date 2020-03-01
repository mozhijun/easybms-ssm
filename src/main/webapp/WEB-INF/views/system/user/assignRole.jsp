<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>分配角色</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all"/>
</head>
<body>
<div class="layui-container" style="margin-top: 25px;">
    <!-- 数据表格开始-->
    <table id="roleList" lay-filter="roleList"></table>
</div>

<!--表格头工具条-->
<script type="text/html" id="tableToolBar">
    <a class="layui-btn layui-btn-green" lay-event="saveUserRole">确认分配</a>
</script>

<!-- 数据表格结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    /**
     * 表单渲染
     */
    layui.use(['form', 'layer','table'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : parent.layer,
            $ = layui.jquery,
            table = layui.table;
        //角色列表
        tableIns = table.render({
            elem: '#roleList',
            url: '${ctx}/user/loadAllRole.json?id=' + ${userId},
            cellMinWidth: 95,
            // height: "full-150",
            toolbar: '#tableToolBar',
            // defaultToolbar: ['filter'],
            id: "roleListTable",
            cols: [[
                {type: "checkbox", fixed: "left", width: 80},
                {field: 'id', title: '角色ID', width: 150, align: "center"},
                {field: 'name', title: '角色名称', width: 250, align: "center"},
                {field: 'remark', title: '角色备注',align: "center"}
            ]]
        });

        /**
         * 监听表头工具栏，确认分配
         */
        table.on('toolbar(roleList)', function (obj) {
            /**
             * 保存用户角色关系
             */
            switch (obj.event) {
                case 'saveUserRole':
                    //roleListTable table的id
                    var checkStatus = table.checkStatus('roleListTable'),
                        //获取选中的数据
                        data = checkStatus.data;
                    var ids = new Array();
                    if (data.length > 0) {
                        for (var i in data) {
                            ids[i] = data[i].id;
                        }
                        console.log(ids);
                        layer.confirm('确定要给当前用户分配选中的角色吗？', {icon: 3, title: '提示信息'}, function (index) {
                            $.post("${ctx}/user/saveUserRole.json",
                                {"ids" : ids + "","id" : ${userId}},
                                function (data) {
                                    if (data.code == 0) {
                                        //提示内容
                                        layer.msg(data.msg, {icon: 1, time: 2000});
                                        //关闭提示窗口
                                        layer.close(index);
                                        //关闭父弹窗
                                        var pageIndex = parent.layer.getFrameIndex(window.name);
                                        layer.close(pageIndex);
                                    } else {
                                        layer.msg(data.msg, {icon: 2, time: 3000});
                                    }
                                });
                        });
                    } else {
                        layer.msg("请选择需要分配的角色", {icon: 5, time: 3000});
                    }
                    break;
            };
        });
    });
</script>
</body>
</html>