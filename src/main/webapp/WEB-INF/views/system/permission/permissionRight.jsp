<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>权限管理--权限点列表</title>
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
<!-- 查询条件开始 -->
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
    <legend>查询条件</legend>
</fieldset>
<form class="layui-form" id="searchFrm">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">权限名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" id="name" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">权限编码</label>
            <div class="layui-input-inline">
                <input type="text" name="percode" id="percode" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <div class="layui-input-inline">
                <shiro:hasPermission name="permission:view">
                    <a href="javascript:void(0)" class="search_btn layui-btn">查询</a>
                    <button type="reset" class="layui-btn layui-btn-warm">重置</button>
                </shiro:hasPermission>
            </div>
        </div>
    </div>
</form>
<!-- 查询条件结束-->

<!-- 数据表格开始-->
<table id="permissionList" lay-filter="permissionList"></table>

<!--表格头工具条-->
<script type="text/html" id="tableToolBar">
    <shiro:hasPermission name="permission:create">
        <a class="layui-btn" lay-event="add">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="permission:batchdelete">
        <a class="layui-btn layui-btn-danger" lay-event="batchDel">批量删除</a>
    </shiro:hasPermission>
</script>
<!-- 表格数据工具条 templet -->
<script type="text/html" id="permissionListBar">
    <shiro:hasPermission name="permission:update">
        <a class="layui-btn layui-btn-xs" lay-event="update">修改</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="permission:delete">
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
    </shiro:hasPermission>
</script>
<!-- 数据表格结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript">
    var tableIns;

    /**
     * 查询：根据菜单 ID 名称 查询 当前菜单下的权限点
     * 点击左边的菜单树加载右边的权限点列表
     *  todo:这里的id是从iframe left 传过来的
     */
    function reloadTable(id) {
        tableIns.reload({
            where: {
                name: $("#name").val(),
                percode: $("#percode").val(),
                id: id
            }
            //当前页码
            , page: {
                curr: 1
            }
        });
    }

    /**
     * 表单渲染
     */
    layui.use(['form', 'layer', 'laydate', 'table', 'laytpl'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : parent.layer,
            $ = layui.jquery,
            laydate = layui.laydate,
            laytpl = layui.laytpl,
            table = layui.table;
        //菜单列表
        tableIns = table.render({
            elem: '#permissionList',
            url: '${ctx}/permission/loadAllPermission.json',
            method: 'post',
            cellMinWidth: 95,
            toolbar: '#tableToolBar',
            page: true,
            height: "full-180",
            limit: 10,
            limits: [10, 15, 20, 25],
            // defaultToolbar: ['filter','print','exports'],
            id: "permissionListTable",
            cols: [[
                {type: "checkbox", fixed: "left", width: 50},
                {field: 'id', title: 'ID', width: 100, align: "center"},
                {field: 'pid', title: '父级权限ID', width: 120, align: "center"},
                {field: 'name', title: '权限名称', width: 200, align: "center"},
                {field: 'percode', title: '权限编码', width: 200, align: "center"},
                {
                    field: 'available', title: '是否可用', align: 'center',
                    templet: function (data) {
                        return data.available == 1 ? "<font color=blue>可用</font>" : "<font color=red>不可用</font>"
                    }
                },
                {field: 'ordernum', title: '排序码', align: "center", width: 100},
                {title: '操作', width: 150, templet: '#permissionListBar', fixed: "right", align: "center"}
            ]]
        });
        //点击搜索按钮
        $(".search_btn").on("click", function () {
            /**
             * 这里不传ID，只传入查询的菜单名称或菜单编码
             */
            reloadTable(null);
        });

        /**
         * 监听表头工具栏，批量删除和添加
         */
        table.on('toolbar(permissionList)', function (obj) {
            switch (obj.event) {
                case 'add':
                    toAddPermission();
                    break;
                case 'batchDel':
                    //menuListTable table的id
                    var checkStatus = table.checkStatus('permissionListTable'),
                        //获取选中的数据
                        data = checkStatus.data;
                    // layer.alert(JSON.stringify(data));
                    // var ids = "?a=1";
                    var ids = new Array();
                    if (data.length > 0) {
                        for (var i in data) {
                            // ids += "&ids=" + data[i].id;
                            ids[i] = data[i].id;
                        }

                        // layer.alert(JSON.stringify(ids));
                        console.log(ids);
                        layer.confirm('确定要删除选中的权限吗？', {icon: 3, title: '提示信息'}, function (index) {
                            $.post("${ctx}/permission/batchDeletePermission.json",
                                {"ids": ids + ""},
                                function (data) {
                                    if (data.code == 0) {
                                        layer.msg(data.msg, {icon: 1, time: 2000}, function () {
                                            //重新刷新表格
                                            tableIns.reload();
                                            //关闭提示窗口
                                            layer.close(index);
                                        });
                                    } else {
                                        layer.msg(data.msg, {icon: 2, time: 3000});
                                    }
                                });
                        });
                    } else {
                        layer.msg("请选中需要删除的权限", {icon: 5, time: 3000});
                    }
                    break;
            }
            ;
        });

        /**
         * 添加权限
         */
        function toAddPermission() {
            //打开弹出层
            var index = layui.layer.open({
                title: "添加权限",
                type: 2,
                area: ['700px', '380px'],
                content: "${ctx}/permission/toAddPermission.page",
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', index);
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回权限列表', '.layui-layer-setwin .layui-layer-close', {
                            tips: [3, '#FFB800'],
                            time: 2000
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
         * 表格行工具条监听，删除和修改
         */
        table.on('tool(permissionList)', function (obj) {
            //获取事件类型，由工具条中的 lay-event="..."定义
            var layEvent = obj.event,
                //当前行的所有数据
                data = obj.data;
            if (layEvent === 'update') {
                toUpdate(data.id);//取出权限ID
            } else if (layEvent === 'del') { //删除
                layer.confirm('确定删除[' + data.name + ']权限吗？', {icon: 3, title: '提示信息'}, function (index) {
                    $.post(
                        "${ctx}/permission/deletePermission.json", //url
                        {"id": data.id}, //需要删除的菜单ID
                        function (data) {
                            if (data.code == 0) {
                                //成功提示
                                layer.msg(data.msg, {icon: 1, time: 2000}, function () {
                                    //刷新table
                                    tableIns.reload();
                                    //关闭confirm
                                    layer.close(index);
                                });
                            } else {
                                //失败
                                layer.msg(data.msg, {icon: 2, time: 3000});
                            }
                        }
                    );
                });
            }
        });

        /**
         * 弹出修改权限信息的iframe层
         */
        function toUpdate(id) {
            //打开弹出层
            var index = layui.layer.open({
                title: "修改权限",
                type: 2,
                area: ['700px', '380px'],
                //这里的content 是 url
                content: "${ctx}/permission/toUpdatePermission.page?id=" + id,
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', index);

                    //tip提示：如何关闭iframe层
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回权限列表', '.layui-layer-setwin .layui-layer-close', {
                            tips: [3, '#FFB800'],
                            time: 2000
                        });
                    }, 500)
                }
            })
            //默认最大化窗口
            //layui.layer.full(index);
            //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
            $(window).on("resize", function () {
                layui.layer.full(index);
            })
        }
    });
</script>
</body>
</html>