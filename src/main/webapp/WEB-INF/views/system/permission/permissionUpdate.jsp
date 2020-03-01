<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改权限</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/zTree/css/metroStyle/metroStyle.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/plugin/css/index.css">
</head>
<body class="childrenBody">
<form class="layui-form" id="permissionFrm">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">选择菜单</label>
            <div class="layui-input-inline">
                <%--使用selectTree 插件渲染部门层级下拉选择--%>
                <div class="layui-form-select select-tree" id="pid" name="pid"></div>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">排序码</label>
            <div class="layui-input-inline">
                <%--隐藏域存放id，提交表单数据时候一同提交--%>
                <input type="hidden" name="id" value="${permission.id}">
                <input type="hidden" name="parent" value="${permission.parent}">
                <input type="hidden" name="open" value="${permission.open}">
                <input type="hidden" name="type" value="${permission.type}">
                <input type="text" name="ordernum" value="${permission.ordernum}" placeholder="排序码"
                       lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">权限名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" value="${permission.name}" placeholder="权限名称" lay-verify="required"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">权限编码</label>
            <div class="layui-input-inline">
                <input type="text" name="percode" value="${permission.percode}" placeholder="权限编码" lay-verify="required"
                       autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">是否可用</label>
        <div class="layui-input-block">
            <input type="radio" name="available" autocomplete="off" title="是" value="1"
            ${permission.available == 1 ? 'checked' : ''} class="layui-input">
            <input type="radio" name="available" autocomplete="off" title="否" value="0"
            ${permission.available == 0 ? 'checked' : ''} class="layui-input">
        </div>
    </div>

    <div class="layui-form-item" style="text-align: center;">
        <button class="layui-btn" lay-submit="" lay-filter="updatePermission">提交</button>
        <button class="layui-btn layui-btn-warm" type="reset">重置</button>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/js/selectTree.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer', 'jquery'], function () {
        var form = layui.form;
        var $ = layui.jquery;
        //如果父页面有layer就是用父页面的，没有就导入
        var layer = parent.layer === undefined ? layui.layer : parent.layer;

        //监听提交，使用layui form submit事件
        form.on('submit(updatePermission)', function () {
            //form获取数据
            var data = $('#permissionFrm').serialize();
            $.post(
                '${ctx}/permission/updatePermission.json',
                data,
                function (data) {
                    console.log(data);
                    if (data.code == 0) {
                        //弹出成功的提示
                        layer.msg(data.msg, {icon: 1, time: 2000});
                        //重载表格
                        parent.tableIns.reload();
                        //关闭窗口
                        var index = layer.getFrameIndex(window.name);
                        layer.close(index);
                    }else {
                        //弹出失败的提示
                        layer.msg(data.msg, {icon: 2, time: 3000});
                    }
                }
            );
            return false;
        });
    });
    /**
     * 页面加载的时候也初始化下拉菜单树
     */
    $(function () {
        initMenuTree();
    });

    /**
     * 加载可用的下拉菜单树
     */
    function initMenuTree() {
        $.post(
            '${ctx}/menu/menuTree.json',
            {"available": 1},
            function (zNodes) {
                //渲染下拉树
                initSelectTree('pid', zNodes, false);
                //渲染当前部门父节点，通过pid选中对应名称
                /**
                 * 注意：这里的zTree 的id，下拉树有做过特殊处理，id修改为：id(dom设置的id) + Tree组合成下拉树的id
                 */
                var zTreeObj = $.fn.zTree.getZTreeObj('pidTree');
                var pid = ${permission.pid};
                var node = zTreeObj.getNodeByParam('id',pid);
                zTreeObj.selectNode(node);
                //渲染,就相当于我点击了这个node节点，实现初始化下拉树数据
                onClick(event,'pidTree',node);

                $(".layui-nav-item a").bind("click", function () {
                    if (!$(this).parent().hasClass("layui-nav-itemed") && !$(this).parent().parent().hasClass("layui-nav-child")) {
                        $(".layui-nav-tree").find(".layui-nav-itemed").removeClass("layui-nav-itemed")
                    }
                });
            }
        );
    }
</script>
</body>
</html>
