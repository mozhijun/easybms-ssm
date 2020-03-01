<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>菜单权限树</title>
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/zTree/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="${ctx}/resources/zTree/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/zTree/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="${ctx}/resources/zTree/js/jquery.ztree.excheck.js"></script>
</head>
<body class="childrenBody">
<div class="layui-container">
    <ul id="treeRolePermission" class="ztree"></ul>
    <div style="text-align: center;margin-top: 10px;">
        <a class="layui-btn layui-btn-xs layui-btn-green" onclick="savePermissions()">确认分配</a>
        <%--<a class="layui-btn layui-btn-normal layui-btn-xs" onclick="cancelSelect()">取消</a>--%>
    </div>
</div>
</body>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    var layer;
    layui.use('layer', function () {
        layer = parent.layer === undefined ? layui.layer : parent.layer;
    });

    var setting = {
        //设置zTree复选框
        check: {
            enable: true,
            chkStyle: 'checkbox'
        },
        //是否展示连接线
        view: {
            showLine: true
        }

        /**
         * 1.zTree简单模式的Json 需要使用 id / pId 表示节点的父子包含关系
         * var nodes = [
         *       {id:1, pId:0, name: "父节点1"},
         *       {id:11, pId:1, name: "子节点1"},
         *       {id:12, pId:1, name: "子节点2"}
         * ];
         *
         * 2.zTree 标准的 JSON 数据需要嵌套表示节点的父子包含关系
         * var nodes = [
         *       {name: "父节点1", children: [
         *           {name: "子节点1"},
         *           {name: "子节点2"}
         *       ]}
         *   ];
         */

        //简单数据类型,设置:
        // ,data: {
        //     simpleData: {
        //         enable: true
        //     }
        // }
    };
    //页面加载的时候加载树
    $(document).ready(function () {
        initTree();
    });

    /**
     * 加载菜单树,这里采用zTree标准的数据结构来
     */
    function initTree() {
        $.post("${ctx}/role/loadRolePermission.json",
            {"id": ${roleId}},
            function (zNodes) {
                $.fn.zTree.init($("#treeRolePermission"), setting, zNodes);
            });
    }

    /**
     * 确定分配： 获取选中的权限集合ID，查看zTree 官方api
     */
    function savePermissions() {
        layer.load(0, {time: false, shade: 0.2});
        var treeObj = $.fn.zTree.getZTreeObj("treeRolePermission");
        var nodes = treeObj.getCheckedNodes(true);
        var ids = new Array();
        //遍历选中的节点，获取pId 集合
        for (var i = 0; i < nodes.length; i++) {
            ids[i] = nodes[i].id;
        }
        /**
         * 发送 ajax 请求，保存选中的权限点
         */
        // if (ids.length > 0) { //判断是否有选中权限 todo:这里在后台做了处理
        $.post(
            '${ctx}/role/saveRolePermissions.json',
            {'ids': ids + "", "id": ${roleId}},
            function (result) {
                if (result.code == 0) {
                    layer.msg(result.msg, {icon: 1, time: 1500});
                    //关闭弹窗
                    var index = layer.getFrameIndex(window.name);
                    layer.close(index);
                    layer.closeAll('loading');
                } else {
                    layer.msg(result.msg, {icon: 7, time: 2000});
                    //关闭弹窗
                    var index = layer.getFrameIndex(window.name);
                    layer.close(index);
                    layer.closeAll('loading');
                }
            }
        );
        // }
        // else {
        //     layer.msg("请先选择要分配的权限", {icon: 7, time: 2000});
        // }
    }

    /**
     * 取消分配: 关闭窗口
     */
    function cancelSelect() {
        //关闭弹窗
        var index = layer.getFrameIndex(window.name);
        layer.close(index);
    }
</script>
</html>