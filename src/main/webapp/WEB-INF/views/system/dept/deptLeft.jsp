<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>部门管理--左边的部门树</title>
    <link rel="stylesheet" href="${ctx}/resources/zTree/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="${ctx}/resources/zTree/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/zTree/js/jquery.ztree.core.js"></script>
    <%--TODO:注意:excheck.js一定要放在ztree.core.js之后加载--%>
    <script type="text/javascript" src="${ctx}/resources/zTree/js/jquery.ztree.excheck.js"></script>
</head>
<body class="childrenBody">
<ul id="treeDept" class="ztree"></ul>
</body>
<script type="text/javascript">
    function zTreeOnClick(event, treeId, treeNode) {
        // alert(treeNode.tId + ", " + treeNode.name);
        //调用deptRight页面的reloadTable  把treeNode.id传过来，也就是部门id右边的部门列表iframe用
        window.parent.right.reloadTable(treeNode.id); //right是deptManager里面的frame的name值
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
     * 新增用户的页面，成功添加需要重新加载树
     */
    function initTree() {
        $.post("${ctx}/dept/deptTree.json",
            // {"available": 1},
            function (zNodes) {
                $.fn.zTree.init($("#treeDept"), setting, zNodes);
            });
    }
</script>
</html>