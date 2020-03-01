<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>权限管理--左边的菜单树</title>
    <link rel="stylesheet" href="${ctx}/resources/zTree/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="${ctx}/resources/zTree/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/zTree/js/jquery.ztree.core.js"></script>
</head>
<body class="childrenBody">
<ul id="treeMenu" class="ztree"></ul>
</body>
<script type="text/javascript">
    function zTreeOnClick(event, treeId, treeNode) {
        // alert(treeNode.tId + ", " + treeNode.name);
        //调用permissionRight页面的reloadTable  把treeNode.id传过去，给右边的权限点列表iframe用
        window.parent.right.reloadTable(treeNode.id); //right是permissionManager里面的frame的name值
    };
    var setting = {
        // check: {
        //     enable: true,
        //     chkStyle: 'checkbox'
        // },
        //是否展示连接线
        view: {
            showLine: true
        },
        //简单数据类型（array）需要遵循zTree json格式（必要字段属性必须包括）
        data: {
            simpleData: {
                enable: true
            }
        },
        //回调的方法
        callback: {
            onClick: zTreeOnClick
        }
    };
    //页面加载的时候加载树
    $(document).ready(function () {
        initTree();
    });

    /**
     * 加载菜单树
     */
    function initTree() {
        $.post("${ctx}/menu/menuTree.json",
            // {"available": 1},
            function (zNodes) {
                $.fn.zTree.init($("#treeMenu"), setting, zNodes);
            });
    }
</script>
</html>