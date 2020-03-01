<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>角色管理</title>
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
            <label class="layui-form-label">角色名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" id="name" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">角色备注</label>
            <div class="layui-input-inline">
                <input type="text" name="remark" id="remark" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <shiro:hasPermission name="role:view">
                <a href="javascript:void(0)" class="search_btn layui-btn">查询</a>
                <button type="reset" class="layui-btn layui-btn-warm">重置</button>
            </shiro:hasPermission>
        </div>
    </div>
</form>
<!-- 查询条件结束-->

<!-- 数据表格开始-->
<table id="roleList" lay-filter="roleList"></table>

<!--表格头工具条-->
<script type="text/html" id="tableToolBar">
    <shiro:hasPermission name="role:create">
        <a class="layui-btn layui-btn" lay-event="add">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="role:batchdelete">
        <a class="layui-btn layui-btn-danger" lay-event="batchDel">批量删除</a>
    </shiro:hasPermission>
</script>
<!-- 表格数据工具条 -->
<script type="text/html" id="roleListBar">
    <shiro:hasPermission name="role:update">
        <a class="layui-btn layui-btn-xs" lay-event="update">修改</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="role:delete">
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="role:assignpermission">
        <a class="layui-btn layui-btn-xs layui-btn-green" lay-event="assignPermission">权限分配</a>
    </shiro:hasPermission>
</script>
<!-- 数据表格结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript">
    var tableIns;

    /**
     * 查询角色重载表格
     */
    function reloadTable() {
        tableIns.reload({
            where: {
                name: $("#name").val(),
                remark: $("#remark").val()
            }
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
        //角色列表
        tableIns = table.render({
            elem: '#roleList',
            url: '${ctx}/role/loadAllRole.json',
            cellMinWidth: 95,
            toolbar: '#tableToolBar',
            page: true,
            height: "full-180",
            limit: 5,
            limits: [10, 15, 20, 25],
            // defaultToolbar: ['filter','print','exports'],
            id: "roleListTable",
            cols: [[
                {type: "checkbox", fixed: "left", width: 50},
                {field: 'id', title: '角色ID', width: 180, align: "center"},
                {field: 'name', title: '角色名称', width: 220, align: "center"},
                {field: 'remark', title: '角色备注', width: 220, align: "center"},
                {
                    field: 'available', title: '是否可用', align: 'center', templet: function (data) {
                        return data.available == 1 ? "<font color=blue>可用</font>" : "<font color=red>不可用</font>"
                    }
                },
                {title: '操作', width: 250, templet: '#roleListBar', fixed: "right", align: "center"}
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
                    table.reload("roleListTable", { // 刷新表格到上一页
                        page: {
                            curr: currPage - 1
                        }
                    });
                }
            }
        });

        /**
         * 点击查询按钮
         */
        $(".search_btn").on("click", function () {
            reloadTable();
        });

        /**
         * 监听表头工具栏，批量删除和添加
         */
        table.on('toolbar(roleList)', function (obj) {
            switch (obj.event) {
                case 'add':
                    toAddRole();
                    break;
                case 'batchDel':
                    //roleListTable table的id
                    var checkStatus = table.checkStatus('roleListTable'),
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
                        layer.confirm('确定要删除选中的角色吗？', {icon: 3, title: '提示信息'}, function (index) {
                            $.post("${ctx}/role/batchDeleteRole.json",
                                {"ids": ids + ""},
                                function (data) {
                                    if (data.code == 0) {
                                        layer.msg(data.msg, {icon: 1, time: 2000}, function () {
                                            //重新刷新表格
                                            tableIns.reload();
                                            //重新加载左边的角色树
                                            parent.left.initTree();
                                            //关闭提示窗口
                                            layer.close(index);
                                        });
                                    } else {
                                        layer.msg(data.msg, {icon: 2, time: 3000});
                                    }
                                });
                        });
                    } else {
                        layer.msg("请选择需要删除的角色", {icon: 5, time: 3000});
                    }
                    break;
            }
            ;
        });

        /**
         * 添加角色
         */
        function toAddRole() {
            //打开弹出层
            var index = layui.layer.open({
                title: "添加角色",
                type: 2,
                area: ['550px', '350px'],
                content: "${ctx}/role/toAddRole.page",
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', index);
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回角色列表', '.layui-layer-setwin .layui-layer-close', {
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
         * 表格行工具条监听，删除和修改
         */
        table.on('tool(roleList)', function (obj) {
            //获取事件类型，由工具条中的 lay-event="..."定义
            var layEvent = obj.event,
                //当前行的所有数据
                data = obj.data;
            if (layEvent === 'update') {
                toUpdate(data.id);//取出角色ID
            } else if (layEvent === 'del') { //删除
                layer.confirm('确定删除[' + data.name + ']角色吗？', {icon: 3, title: '提示信息'}, function (index) {
                    $.post(
                        "${ctx}/role/deleteRole.json", //url
                        {"id": data.id}, //需要删除的角色ID
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
            } else if (layEvent === 'assignPermission') {
                assignPermission(data.id);
            }
        });

        /**
         * 给角色分配权限
         */
        function assignPermission(roleId) {
            //打开弹出层
            var index = layui.layer.open({
                title: "分配权限",
                type: 2,
                area: ['300px', '370px'],
                //这里的content 是 url
                content: "${ctx}/role/toAssignPermission.page?id=" + roleId,
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', index);
                    //tip提示：如何关闭iframe层
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回角色列表', '.layui-layer-setwin .layui-layer-close', {
                            tips: [3, '#FFB800'],
                            time: 2000
                        });
                    }, 500)
                }
            });
            //默认最大化窗口
            //layui.layer.full(index);
            //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
            $(window).on("resize", function () {
                layui.layer.full(index);
            });
        }

        /**
         * 弹出修改角色信息的iframe层
         */
        function toUpdate(id) {
            //打开弹出层
            var index = layui.layer.open({
                title: "修改角色",
                type: 2,
                area: ['580px', '350px'],
                //这里的content 是 url
                content: "${ctx}/role/toUpdateRole.page?id=" + id,
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', index);
                    //tip提示：如何关闭iframe层
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回角色列表', '.layui-layer-setwin .layui-layer-close', {
                            tips: [3, '#FFB800'],
                            time: 2000
                        });
                    }, 500)
                }
            });
            //默认最大化窗口
            //layui.layer.full(index);
            //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
            $(window).on("resize", function () {
                layui.layer.full(index);
            });
        }
    });
</script>
</body>
</html>