<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加用户</title>
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
<form class="layui-form" id="userFrm">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">所在部门</label>
            <div class="layui-input-inline">
                <%--使用selectTree 插件渲染用户层级下拉选择--%>
                <div class="layui-form-select select-tree" id="deptid" name="deptid"></div>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">排序码</label>
            <div class="layui-input-inline">
                <input type="text" name="ordernum" placeholder="排序码" lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">领导部门</label>
            <div class="layui-input-inline">
                <%--使用selectTree 插件渲染用户层级下拉选择--%>
                <div class="layui-form-select select-tree" id="leaderDeptId" name="leaderDeptId"></div>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">选择领导</label>
            <div class="layui-input-inline">
                <select id="mgr" name="mgr">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">用户姓名</label>
            <div class="layui-input-inline">
                <input type="text" name="name" id="name" placeholder="用户姓名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">登录名</label>
            <div class="layui-input-inline">
                <input type="text" name="loginname" id="loginname" placeholder="登录名" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户地址</label>
        <div class="layui-input-block">
            <input type="text" name="address" placeholder="公司地址" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户备注</label>
        <div class="layui-input-block">
            <textarea type="text" name="remark" placeholder="请输入用户备注信息" autocomplete="off"
                      class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">用户性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" autocomplete="off" title="男" value="1" checked class="layui-input">
                <input type="radio" name="sex" autocomplete="off" title="女" value="0" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">是否可用</label>
            <div class="layui-input-block">
                <input type="radio" name="available" autocomplete="off" title="是" value="1" checked class="layui-input">
                <input type="radio" name="available" autocomplete="off" title="否" value="0" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">入职时间</label>
            <div class="layui-input-inline">
                <input type="text" name="hiredate" id="hiredate" readonly="readonly" placeholder="入职时间"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center;">
        <button class="layui-btn" lay-submit="" lay-filter="addUser">提交</button>
        <button class="layui-btn layui-btn-warm" type="reset">重置</button>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript" src="${ctx}/resources/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/zTree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/js/selectTree.js"></script>
<script type="text/javascript">
    var form;
    var layer;
    layui.use(['form', 'layer', 'jquery', 'laydate'], function () {
        form = layui.form;
        var laydate = layui.laydate;
        var $ = layui.jquery;
        //如果父页面有layer就是用父页面的，没有就导入
        layer = parent.layer === undefined ? layui.layer : parent.layer;

        //绑定时间选择器
        laydate.render({
            elem: '#hiredate'
        });

        //监听提交，使用layui form submit事件
        form.on('submit(addUser)', function () {
            //form获取数据
            var data = $('#userFrm').serialize();
            $.post(
                '${ctx}/user/addUser.json',
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
                    } else {
                        layer.msg(data.msg, {icon: 2, time: 3000});
                    }
                }
            );
            return false;
        });

        /**
         * 监听用户姓名失去焦点事件，请求后台自动生成对应的全拼拼音
         */
        $('#name').on('blur', function () {
            //拿到用户姓名
            var name = $(this).val();
            $.post(
                '${ctx}/user/autoGenerateLoginName.json',
                {"name": name},
                function (result) {
                    $('#loginname').val(result.loginName);
                }
            );
        });
    });
    /**
     * 页面加载的时候也初始化部门树
     */
    $(function () {
        initDeptTree();
    });

    /**
     * 加载可用的部门树
     */
    function initDeptTree() {
        $.post(
            '${ctx}/dept/deptTree.json',
            {"available": 1},
            function (zNodes) {
                /**
                 * 所在部门，渲染
                 */
                initSelectTree('deptid', zNodes, false);
                /**
                 * 领导部门，渲染
                 */
                initSelectTree('leaderDeptId', zNodes, false);
                $(".layui-nav-item a").bind("click", function () {
                    if (!$(this).parent().hasClass("layui-nav-itemed") && !$(this).parent().parent().hasClass("layui-nav-child")) {
                        $(".layui-nav-tree").find(".layui-nav-itemed").removeClass("layui-nav-itemed")
                    }
                });
            }
        );
    }

    /**
     * 获取点击领导部门下拉树，部门ID
     */
    function initMgr(deptid) {
        // layer.alert(deptid);
        /**
         * 请求后台，查询出对应领导部门下所有的用户
         */
        $.post(
            '${ctx}/user/loadUserByDeptId.json',
            {"deptid": deptid},
            function (data) {
                var html = '';
                for (var i = 0; i < data.length; i++) {
                    html += "<option value=" + data[i].id + ">" + data[i].name + "</option>"
                }
                //动态添加 option
                $('#mgr').html(html);
                //form重新渲染
                form.render('select');
            }
        );
    }
</script>
</body>
</html>
