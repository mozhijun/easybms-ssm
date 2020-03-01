<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户管理--左边的用户树</title>
    <link rel="stylesheet" href="${ctx}/resources/zTree/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="${ctx}/resources/zTree/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/zTree/js/jquery.ztree.core.js"></script>
</head>
<body class="childrenBody">
<ul id="treeDept" class="ztree"></ul>
</body>
<script type="text/javascript">
    function zTreeOnClick(event, treeId, treeNode) {
        //调用deptRight页面的reloadTable 将选中部门节点的id，也就是deptid传给右边用户列表展示页面
        window.parent.right.reloadTable(treeNode.id); //right是userManager里面的frame的name值
    };
    var setting = {
        //是否展示连接线
        view: {
            showLine: true
        },
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
     * 新增用户的页面，成功添加需要重新加载树
     */
    function initTree() {
        $.post("${ctx}/dept/deptTree.json",
            {"available": 1},
            function (zNodes) {
                $.fn.zTree.init($("#treeDept"), setting, zNodes);
            }
        );
    }
</script>
</html>