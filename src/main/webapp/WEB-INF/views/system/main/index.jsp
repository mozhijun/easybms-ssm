<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>EasyBMS</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${ctx}/resources/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/index.css" media="all"/>
</head>
<body class="main_body">
<div class="layui-layout layui-layout-admin">
    <!-- 顶部 -->
    <div class="layui-header header">
        <div class="layui-main mag0">
            <a href="javascript:;" class="logo">
                <img src="${ctx}/resources/images/log.png" width="30px" height="30px" alt="">
                <span>EasyBMS</span>
            </a>
            <!-- 显示/隐藏菜单 -->
            <a href="javascript:;" class="seraph hideMenu icon-caidan"></a>
            <!-- 顶部右侧菜单 -->
            <ul class="layui-nav top_menu">
                <li class="layui-nav-item lockcms" pc>
                    <a href="javascript:;"><i class="seraph icon-lock"></i><cite>锁屏</cite></a>
                </li>
                <li class="layui-nav-item" id="userInfo">
                    <a href="javascript:;"><img src="${user.imgpath}" class="layui-nav-img userAvatar" width="35"
                                                height="35"><cite class="adminName">${user.name}</cite></a>
                    <dl class="layui-nav-child">

                        <dd><a href="javascript:;" data-url="${ctx}/user/userInfo.page"><i class="seraph icon-ziliao"
                                                                                           data-icon="icon-ziliao"></i><cite>个人资料</cite></a>
                        </dd>
                        <dd><a href="javascript:;" id="modifyPwd"><i class="seraph icon-xiugai"
                                                                     data-icon="icon-xiugai"></i><cite>修改密码</cite></a>
                        </dd>
                        <!--<dd><a href="javascript:;" class="showNotice"><i class="layui-icon">&#xe645;</i><cite>系统公告</cite><span class="layui-badge-dot"></span></a></dd>-->
                        <dd><a href="javascript:;" class="signOut"><i
                                class="seraph icon-tuichu"></i><cite>退出</cite></a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <!-- 左侧导航 -->
    <div class="layui-side layui-bg-black">
        <div class="user-photo">
            <a class="img" title="我的头像"><img src="${user.imgpath}" class="userAvatar"></a>
            <p>你好！<span class="userName">${user.name}</span>, 欢迎登录</p>
        </div>
        <div class="navBar layui-side-scroll" id="navBar">
            <ul class="layui-nav layui-nav-tree">
                <li class="layui-nav-item layui-this">
                    <a href="javascript:;" data-url="${ctx}/desk/toDeskManager.page">
                        <i class="layui-icon" data-icon=""></i><cite>后台首页</cite></a>
                </li>
            </ul>
        </div>
    </div>
    <!-- 右侧内容 -->
    <div class="layui-body layui-form">
        <div class="layui-tab mag0" lay-filter="bodyTab" id="top_tabs_box">
            <ul class="layui-tab-title top_tab" id="top_tabs">
                <li class="layui-this" lay-id=""><i class="layui-icon">&#xe68e;</i> <cite>后台首页</cite></li>
            </ul>
            <ul class="layui-nav closeBox">
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon caozuo">&#xe643;</i> 页面操作</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="refresh refreshThis"><i class="layui-icon">&#x1002;</i>
                            刷新当前</a></dd>
                        <dd><a href="javascript:;" class="closePageOther"><i class="seraph icon-prohibit"></i> 关闭其他</a>
                        </dd>
                        <dd><a href="javascript:;" class="closePageAll"><i class="seraph icon-guanbi"></i> 关闭全部</a></dd>
                    </dl>
                </li>
            </ul>
            <%--中间内容部分，默认展示desk首页--%>
            <div class="layui-tab-content clildFrame">
                <div class="layui-tab-item layui-show">
                    <iframe src="${ctx}/desk/toDeskManager.page"></iframe>
                </div>
            </div>
        </div>
    </div>
    <!-- 底部 -->
    <div class="layui-footer footer">
        <p><span>copyright @2019 小莫</span>　　
    </div>
</div>
<!-- 移动导航 -->
<div class="site-tree-mobile"><i class="layui-icon">&#xe602;</i></div>
<div class="site-mobile-shade"></div>

<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    var $, tab, dataStr, layer;
    layui.config({
        base: "${ctx}/resources/js/"
    }).extend({
        "bodyTab": "bodyTab"
    }).use(['bodyTab', 'form', 'element', 'layer', 'jquery'], function () {
        var form = layui.form,
            element = layui.element;
        $ = layui.$;
        layer = parent.layer === undefined ? layui.layer : top.layer;
        tab = layui.bodyTab({
            openTabNum: "50",  //最大可打开窗口数量
            url: "${ctx}/login/loadIndexTreeMenus.json" //获取菜单json地址
        });

        //加载左侧菜单
        function getData() {
            $.getJSON(tab.tabConfig.url, function (data) {
                dataStr = data;
                //重新渲染左侧菜单
                tab.render();
            })
        }

        //隐藏左侧导航
        $(".hideMenu").click(function () {
            if ($(".topLevelMenus li.layui-this a").data("url")) {
                layer.msg("此栏目状态下左侧菜单不可展开");  //主要为了避免左侧显示的内容与顶部菜单不匹配
                return false;
            }
            $(".layui-layout-admin").toggleClass("showMenu");
            //渲染顶部窗口
            tab.tabMove();
        })

        //加载导航栏左侧菜单
        getData();

        //手机设备的简单适配
        $('.site-tree-mobile').on('click', function () {
            $('body').addClass('site-mobile');
        });
        $('.site-mobile-shade').on('click', function () {
            $('body').removeClass('site-mobile');
        });

        // 添加新窗口
        $("body").on("click", ".layui-nav .layui-nav-item a:not('.mobileTopLevelMenus .layui-nav-item a')", function () {
            //如果不存在子级
            if ($(this).siblings().length == 0) {
                addTab($(this));
                $('body').removeClass('site-mobile');  //移动端点击菜单关闭菜单层
            }
            $(this).parent("li").siblings().removeClass("layui-nav-itemed");
        });

        /**
         * 锁屏
         */
        function lockPage() {
            layer.open({
                title: false,
                type: 1,
                content: '<div class="admin-header-lock" id="lock-box">' +
                    '<div class="admin-header-lock-img"><img src="${user.imgpath}" class="userAvatar"/></div>' +
                    '<div class="admin-header-lock-name" id="lockUserName">${user.name}</div>' +
                    '<div class="input_btn">' +
                    '<input type="password" class="admin-header-lock-input layui-input" autocomplete="off" placeholder="请输入密码解锁.." name="lockPwd" id="lockPwd" />' +
                    '<button class="layui-btn" id="unlock">解锁</button>' +
                    '</div>' +
                    '<p>请输入“123456”，否则不会解锁成功哦！！！</p>' +
                    '</div>',
                closeBtn: 0,
                shade: 0.9,
                success: function () {

                }
            });
            $(".admin-header-lock-input").focus();
        }

        $(".lockcms").on("click", function () {
            window.sessionStorage.setItem("lockcms", true);
            lockPage();
        });
        // 判断是否显示锁屏
        if (window.sessionStorage.getItem("lockcms") == "true") {
            lockPage();
        }

        /**
         * 解锁,锁屏密码设置默认123456，可以根据实际调整
         */
        $("body").on("click", "#unlock", function () {
            if ($(this).siblings(".admin-header-lock-input").val() == '') {
                layer.msg("请输入解锁密码！");
                $(this).siblings(".admin-header-lock-input").focus();
            } else {
                if ($(this).siblings(".admin-header-lock-input").val() == "123456") {
                    window.sessionStorage.setItem("lockcms", false);
                    $(this).siblings(".admin-header-lock-input").val('');
                    layer.closeAll("page");
                } else {
                    layer.msg("密码错误，请重新输入！");
                    $(this).siblings(".admin-header-lock-input").val('').focus();
                }
            }
        });

        /**
         * 点击键盘回车按键，解锁
         */
        $(document).on('keydown', function (event) {
            var event = event || window.event;
            if (event.keyCode == 13) {
                $("#unlock").click();
            }
        });

        /**
         * 修改密码
         */
        $('#modifyPwd').click(function () {
            layer.open({
                type: 2,
                title: '修改密码',
                offset: '150px',
                /**
                 * layui-layer-rim
                 * layui-layer-lan
                 * layui-layer-molv
                 */
                skin: 'layui-layer-molv',
                anim: 2,
                shadeClose: true,
                area: ['400px', '320px'],
                content: '${ctx}/user/changePwd.page',
                //关闭窗口的时候回调
                <%--end: function () {--%>
                    <%--location.href = '${ctx}/user/logout.page';--%>
                <%--}--%>
            });
        });

        /**
         * 退出登录
         */
        $('.signOut').click(function () {
           layer.confirm('确认要退出系统吗？',{icon: 3,title: '提示信息',offset: '200px'},function (index) {
               location.href = '${ctx}/user/logout.page';
               layer.close(index);
           });
        });
    });

    /**
     * 打开新窗口
     */
    function addTab(_this) {
        tab.tabAdd(_this);
    }
</script>
</body>
</html>
