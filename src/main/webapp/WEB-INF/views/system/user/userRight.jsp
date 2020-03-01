<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>用户管理--右边的用户列表</title>
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
            <label class="layui-form-label">用户姓名</label>
            <div class="layui-input-inline">
                <input type="text" name="name" id="name" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">用户地址</label>
            <div class="layui-input-inline">
                <input type="text" name="address" id="address" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <shiro:hasPermission name="user:view">
                <a href="javascript:void(0)" class="search_btn layui-btn">查询</a>
                <button type="reset" class="layui-btn layui-btn-warm">重置</button>
            </shiro:hasPermission>
        </div>
    </div>
</form>
<!-- 查询条件结束-->

<!-- 数据表格开始-->
<table id="userList" lay-filter="userList"></table>

<!--表格头工具条-->
<script type="text/html" id="tableToolBar">
    <shiro:hasPermission name="user:create">
        <a class="layui-btn layui-btn layui-btn" lay-event="add">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="user:batchdelete">
        <a class="layui-btn layui-btn layui-btn-danger" lay-event="batchDel">批量删除</a>
    </shiro:hasPermission>
</script>
<!-- 表格数据工具条 -->
<script type="text/html" id="userListBar">
    <shiro:hasPermission name="user:update">
        <a class="layui-btn layui-btn-xs" lay-event="update">修改</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="user:delete">
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="user:resetpwd">
        <a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="resetPwd">重置密码</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="user:assignrole">
        <a class="layui-btn layui-btn-xs layui-btn-green" lay-event="assignRole">角色分配</a>
    </shiro:hasPermission>
</script>
<!-- 数据表格结束-->
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript">
    var tableIns;

    /**
     * 查询：根据用户 ID 名称 地址查询 用户
     * 点击左边的部门树加载右边的用户列表
     */
    function reloadTable(deptid) {
        tableIns.reload({
            where: {
                name: $("#name").val(),
                address: $("#address").val(),
                deptid: deptid
            }
            //设置当前页面为第一页
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
        //用户列表
        tableIns = table.render({
            elem: '#userList',
            url: '${ctx}/user/loadAllUser.json',
            cellMinWidth: 95,
            toolbar: '#tableToolBar',
            page: true,
            height: "full-180",
            limit: 10,
            limits: [10, 15, 20, 25],
            // defaultToolbar: ['filter','print','exports'],
            id: "userListTable",
            cols: [[
                {type: "checkbox", fixed: "left", width: 50},
                {field: 'id', title: 'ID', width: 60, align: "center"},
                {field: 'name', title: '用户姓名', width: 120, align: "center"},
                {field: 'loginname', title: '登录名', width: 120, align: "center"},
                {field: 'deptname', title: '所在部门', width: 120, align: "center"},
                {field: 'leadername', title: '直接领导', width: 120, align: "center"},
                {field: 'address', title: '用户地址', align: "center", width: 150},
                {field: 'remark', title: '用户备注', align: "center", width: 150},
                {field: 'hiredate', title: '入职时间', align: "center", width: 150},
                {
                    field: 'sex', title: '性别', align: "center", width: 70, templet:
                        function (data) {
                            return data.sex == 1 ? "<font color=blue>男</font>" : "<font color=red>女</font>"
                        }
                },
                {
                    field: 'imgpath', title: '头像', align: "center", width: 120, templet:
                        function (data) {
                            return "<img width='30px' height=30px alt='' src='" + data.imgpath + "'>";
                        }
                },
                {
                    field: 'available', title: '是否可用', align: 'center', templet: function (data) {
                        return data.available == 1 ? "<font color=blue>是</font>" : "<font color=red>否</font>"
                    }
                },
                {
                    field: 'pwd', title: '密码', align: "center", width: 80, templet: function () {
                        return "******";
                    }
                },
                {field: 'ordernum', title: '排序码', align: "center", width: 80},
                {title: '操作', width: 300, templet: '#userListBar', fixed: "right", align: "center"}
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
                if (dataLength == 0 && count != 0) { //如果当前页的记录数为0并且总记录数不为0
                    table.reload("userListTable", { // 刷新表格到上一页
                        page: {
                            curr: currPage - 1
                        }
                    });
                }
            }
        });
        //点击搜索按钮
        $(".search_btn").on("click", function () {
            reloadTable(null);
        });

        /**
         * 监听表头工具栏，批量删除和添加
         */
        table.on('toolbar(userList)', function (obj) {
            switch (obj.event) {
                case 'add':
                    toAddUser();
                    break;
                case 'batchDel':
                    //userListTable table的id
                    var checkStatus = table.checkStatus('userListTable'),
                        //获取选中的数据
                        data = checkStatus.data;
                    var ids = new Array();
                    if (data.length > 0) {
                        for (var i in data) {
                            ids[i] = data[i].id;
                        }
                        layer.confirm('是否确定要删除选中的用户？', {icon: 3, title: '提示信息'}, function (index) {
                            $.post("${ctx}/user/batchDeleteUser.json",
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
                        layer.msg("请先选择要删除的用户", {icon: 5, time: 3000});
                    }
                    break;
            }
            ;
        });

        /**
         * 添加用户
         */
        function toAddUser() {
            //打开弹出层
            var index = layui.layer.open({
                title: "添加用户",
                type: 2,
                area: ['800px', '600px'],
                content: "${ctx}/user/toAddUser.page",
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', index);
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
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
        table.on('tool(userList)', function (obj) {
            //获取事件类型，由工具条中的 lay-event="..."定义
            var layEvent = obj.event,
                //当前行的所有数据
                data = obj.data;
            if (layEvent === 'update') {
                toUpdate(data.id);//取出用户ID
            } else if (layEvent === 'del') { //删除
                layer.confirm('确定删除[' + data.name + ']用户吗？', {icon: 3, title: '提示信息'}, function (index) {
                    $.post(
                        "${ctx}/user/deleteUser.json", //url
                        {"id": data.id}, //需要删除的用户ID
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
            } else if (layEvent === "resetPwd") {
                resetUserPwd(data);
            } else if (layEvent === "assignRole") {
                assignUserRole(data);
            }
        });

        /**
         * 重置用户密码
         */
        function resetUserPwd(data) {
            layer.confirm('确定要重置【' + data.name + '】的密码吗？', {icon: 3, title: '提示信息'}, function (index) {
                $.post(
                    "${ctx}/user/resetUserPwd.json", //url
                    {"id": data.id}, //用户ID
                    function (data) {
                        if (data.code == 0) {
                            //成功提示
                            layer.msg(data.msg, {icon: 1, time: 2000}, function () {
                                //关闭confirm
                                layer.close(index);
                            });
                        } else {
                            //失败
                            layer.msg(data.msg, {icon: 2, time: 3000}, function () {
                                //关闭confirm
                                layer.close(index);
                            });
                        }
                    }
                );
            });
        }

        /**
         * 用户分配角色
         */
        function assignUserRole(data) {
            //打开弹出层
            var index = layui.layer.open({
                title: "用户【" + data.name + "】分配角色",
                type: 2,
                area: ['750px', '400px'],
                //这里的content 是 url
                content: "${ctx}/user/assignUserRole.page?id=" + data.id,
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', index);
                    //tip提示：如何关闭iframe层
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
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
            });
        }


        /**
         * 弹出修改用户信息的iframe层
         */
        function toUpdate(id) {
            //打开弹出层
            var index = layui.layer.open({
                title: "修改用户",
                type: 2,
                area: ['800px', '600px'],
                //这里的content 是 url
                content: "${ctx}/user/toUpdateUser.page?id=" + id,
                success: function (layero, index) {
                    var body = layui.layer.getChildFrame('body', index);

                    //tip提示：如何关闭iframe层
                    setTimeout(function () {
                        layui.layer.tips('点击此处返回用户列表', '.layui-layer-setwin .layui-layer-close', {
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