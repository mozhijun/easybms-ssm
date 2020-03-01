<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>工作台--EasyBMS 1.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/public.css" media="all"/>
</head>
<body class="childrenBody" style="background-color: #F2F2F2;">
<div class="">
    <blockquote class="layui-elem-quote layui-bg-green">
        <div id="nowTime"></div>
    </blockquote>
    <div class="layui-row layui-col-space10" style="background-color: #ffffff;">
        <%--站点基本参数--%>
        <div class="panel layui-col-xs12 layui-col-sm3 layui-col-md3 layui-col-lg3">
            <a href="javascript:;" data-url="${ctx}/site/toSite.page">
                <div class="panel_icon layui-bg-cyan">
                    <i class="layui-anim seraph layui-icon layui-icon-website"></i>
                </div>
                <div class="panel_word">
                    <span>1</span>
                    <cite>系统基本参数</cite>
                </div>
            </a>
        </div>
        <!--用户总数-->
        <div class="panel layui-col-xs12 layui-col-sm3 layui-col-md3 layui-col-lg3">
            <a href="javascript:;">
                <div class="panel_icon layui-bg-orange">
                    <i class="layui-anim seraph icon-icon10" data-icon="icon-icon10"></i>
                </div>
                <div class="panel_word">
                    <span>66</span>
                    <cite>总访问量</cite>
                </div>
            </a>
        </div>
        <!--系统图标-->
        <div class="panel layui-col-xs12 layui-col-sm3 layui-col-md3 layui-col-lg3">
            <a href="javascript:;" data-url="${ctx}/resource/toIcon.page">
                <div class="panel_icon layui-bg-cyan">
                    <i class="layui-anim layui-icon" data-icon="&#xe857;">&#xe857;</i>
                </div>
                <div class="panel_word">
                    <span>200+</span>
                    <em>菜单图标</em>
                    <cite class="layui-hide">图标管理</cite>
                </div>
            </a>
        </div>
        <!--登录时间记录-->
        <div class="panel layui-col-xs12 layui-col-sm3 layui-col-md3 layui-col-lg3">
            <a href="javascript:;">
                <div class="panel_icon layui-bg-blue">
                    <i class="layui-anim seraph icon-clock"></i>
                </div>
                <div class="panel_word">
                    <span class="loginTime"></span>
                    <cite>上次登录时间</cite>
                </div>
            </a>
        </div>
    </div>
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-xs12 layui-col-sm-12 layui-col-lg12 layui-col-md12">
                    <!--服务器信息-->
                    <div class="layui-card">
                        <div class="layui-card-header">服务器信息</div>
                        <div class="layui-card-body">
                            <table class="layui-table">
                                <colgroup>
                                    <col width="550">
                                    <col>
                                </colgroup>
                                <tbody class="serverInfo"></tbody>
                            </table>
                        </div>
                    </div>
                    <!--虚拟机信息-->
                    <div class="layui-card">
                        <div class="layui-card-header">虚拟机信息</div>
                        <div class="layui-card-body">
                            <table class="layui-table">
                                <colgroup>
                                    <col width="550">
                                    <col>
                                </colgroup>
                                <tbody class="jvmInfo"></tbody>
                            </table>
                        </div>
                    </div>
                    <!--磁盘信息-->
                    <div class="layui-card">
                        <div class="layui-card-header">磁盘状态</div>
                        <div class="layui-card-body">
                            <table class="layui-table">
                                <colgroup>
                                    <col width="150">
                                    <col width="200">
                                    <col width="130">
                                    <col width="180">
                                    <col width="180">
                                    <col width="180">
                                    <col>
                                </colgroup>
                                <thead>
                                <tr align="center">
                                    <th>磁盘路径</th>
                                    <th>文件系统</th>
                                    <th>磁盘类型</th>
                                    <th>总大小</th>
                                    <th>可用大小</th>
                                    <th>已用大小</th>
                                    <th>已用百分比</th>
                                </tr>
                                </thead>
                                <tbody class="diskInfo"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-md4">
            <!--版本信息-->
            <div class="layui-card">
                <div class="layui-card-header">版本信息</div>
                <div class="layui-card-body layui-text">
                    <table class="layui-table">
                        <colgroup>
                            <col width="200">
                            <col>
                        </colgroup>
                        <tbody>
                        <tr>
                            <td>当前版本</td>
                            <td class="version"></td>
                        </tr>
                        <tr>
                            <td>开发作者</td>
                            <td class="author"></td>
                        </tr>
                        <tr>
                            <td>基于框架</td>
                            <td class="framework"></td>
                        </tr>
                        <tr>
                            <td>主要特色</td>
                            <td class="feature"></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!--cpu信息-->
            <div class="layui-card">
                <div class="layui-card-header">CPU信息</div>
                <div class="layui-card-body layui-text">
                    <table class="layui-table">
                        <colgroup>
                            <col width="200">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>属性</th>
                            <th>值</th>
                        </tr>
                        </thead>
                        <tbody class="cpuInfo"></tbody>
                    </table>
                </div>
            </div>
            <!--内存信息-->
            <div class="layui-card">
                <div class="layui-card-header">内存信息</div>
                <div class="layui-card-body layui-text">
                    <table class="layui-table">
                        <colgroup>
                            <col width="180">
                            <col width="180">
                            <col>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>属性</th>
                            <th>内存</th>
                            <th>JVM</th>
                        </tr>
                        </thead>
                        <tbody class="memoryInfo"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    //获取系统时间
    var newDate = '';
    getLangDate();

    //值小于10时，在前面补0
    function dateFilter(date) {
        if (date < 10) {
            return "0" + date;
        }
        return date;
    }

    function getLangDate() {
        var dateObj = new Date(); //表示当前系统时间的Date对象
        var year = dateObj.getFullYear(); //当前系统时间的完整年份值
        var month = dateObj.getMonth() + 1; //当前系统时间的月份值
        var date = dateObj.getDate(); //当前系统时间的月份中的日
        var day = dateObj.getDay(); //当前系统时间中的星期值
        var weeks = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
        var week = weeks[day]; //根据星期值，从数组中获取对应的星期字符串
        var hour = dateObj.getHours(); //当前系统时间的小时值
        var minute = dateObj.getMinutes(); //当前系统时间的分钟值
        var second = dateObj.getSeconds(); //当前系统时间的秒钟值
        var timeValue = "" + ((hour >= 12) ? (hour >= 18) ? "晚上" : "下午" : "上午");    //当前时间属于上午、晚上还是下午
        newDate = dateFilter(year) + "年" + dateFilter(month) + "月" + dateFilter(date) + "日 " + " " + dateFilter(hour) + ":" + dateFilter(minute) + ":" + dateFilter(second);
        document.getElementById("nowTime").innerHTML = "亲爱的 ${user.name}，" + timeValue + "好！ 欢迎使用EasyBMS。当前时间为： " + newDate + "　" + week;
        setTimeout("getLangDate()", 1000);
    }

    layui.use(['form', 'element', 'layer', 'jquery'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            element = layui.element;
        $ = layui.jquery;
        //上次登录时间【此处应该从接口获取，实际使用中请自行更换】
        $(".loginTime").html(newDate.split("日")[0] + "日</br>" + newDate.split("日")[1]);
        //icon动画
        $(".panel a").hover(function () {
            $(this).find(".layui-anim").addClass("layui-anim-scaleSpring");
        }, function () {
            $(this).find(".layui-anim").removeClass("layui-anim-scaleSpring");
        })
        $(".panel a").click(function () {
            parent.addTab($(this));
        })
        //系统基本参数
        if (window.sessionStorage.getItem("systemParameter")) {
            var systemParameter = JSON.parse(window.sessionStorage.getItem("systemParameter"));
            fillParameter(systemParameter);
        } else {
            $.ajax({
                url: "${ctx}/resources/json/systemParameter.json",
                type: "get",
                dataType: "json",
                success: function (data) {
                    fillParameter(data);
                }
            })
        }

        //填充数据方法
        function fillParameter(data) {
            //判断字段数据是否存在
            function nullData(data) {
                if (data == '' || data == "undefined") {
                    return "未定义";
                } else {
                    return data;
                }
            }

            $(".version").text(nullData(data.version));      //当前版本
            $(".author").text(nullData(data.author));        //开发作者
            $(".framework").text(nullData(data.framework));  //基于框架
            $(".feature").text(nullData(data.feature));      //特色
        }

        /**
         * 服务器信息
         */
        $.get("${ctx}/server/getServerInfo.json", function (data) {
            var serverHtml = '';
            var jvmHtml = '';
            var jvmHtml = '';
            var diskHtml = '';
            var cpuHtml = '';
            var memoryHtml = '';

            serverHtml +=
                '<tr>'
                + '<td>' + "服务器名称" + '</td>'
                + '<td>' + data.data.systemInfo.serverName + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "服务器IP" + '</td>'
                + '<td>' + data.data.systemInfo.serverIp + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "操作系统名称" + '</td>'
                + '<td>' + data.data.systemInfo.osName + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "系统架构" + '</td>'
                + '<td>' + data.data.systemInfo.osArch + '</td>'
                + '</tr>';

            jvmHtml +=
                '<tr>'
                + '<td>' + "Java名称" + '</td>'
                + '<td>' + data.data.jvmInfo.jdkname + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "Java版本" + '</td>'
                + '<td>' + data.data.jvmInfo.jdkVersion + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "启动时间" + '</td>'
                + '<td>' + data.data.jvmInfo.startTime + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "运行时长" + '</td>'
                + '<td>' + data.data.jvmInfo.runTime + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "安装路径" + '</td>'
                + '<td>' + data.data.jvmInfo.jdkHome + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "项目路径" + '</td>'
                + '<td>' + data.data.systemInfo.projectDir + '</td>'
                + '</tr>';

            for (var i = 0; i < data.data.diskInfoList.length; i++) {
                diskHtml +=
                    '<tr>'
                    + '<td>' + data.data.diskInfoList[i].diskName + '</td>'
                    + '<td>' + data.data.diskInfoList[i].diskFileTypeName + '</td>'
                    + '<td>' + data.data.diskInfoList[i].diskTypeName + '</td>'
                    + '<td>' + data.data.diskInfoList[i].total + '</td>'
                    + '<td>' + data.data.diskInfoList[i].free + '</td>'
                    + '<td>' + data.data.diskInfoList[i].used + '</td>'
                    + '<td>' + data.data.diskInfoList[i].usage + "%" + '</td>'
                    + '</tr>';
            }

            cpuHtml +=
                '<tr>'
                + '<td>' + "核心数" + '</td>'
                + '<td>' + data.data.cpuInfo.cpuNum + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "用户使用率" + '</td>'
                + '<td>' + data.data.cpuInfo.used + "%" + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "系统使用率" + '</td>'
                + '<td>' + data.data.cpuInfo.sys + "%" + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "当前等待率" + '</td>'
                + '<td>' + data.data.cpuInfo.wait + "%" + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "当前空闲率" + '</td>'
                + '<td>' + data.data.cpuInfo.free + "%" + '</td>'
                + '</tr>';

            memoryHtml +=
                '<tr>'
                + '<td>' + "总内存" + '</td>'
                + '<td>' + data.data.memoryInfo.total + '</td>'
                + '<td>' + data.data.jvmInfo.total + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "已用内存" + '</td>'
                + '<td>' + data.data.memoryInfo.used + '</td>'
                + '<td>' + data.data.jvmInfo.used + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "剩余内存" + '</td>'
                + '<td>' + data.data.memoryInfo.free + '</td>'
                + '<td>' + data.data.jvmInfo.free + '</td>'
                + '</tr>'
                + '<tr>'
                + '<td>' + "使用率" + '</td>'
                + '<td>' + data.data.memoryInfo.usage + "%" + '</td>'
                + '<td>' + data.data.jvmInfo.usage + "%" + '</td>'
                + '</tr>';

            $(".serverInfo").html(serverHtml);
            $(".jvmInfo").html(jvmHtml);
            $(".diskInfo").html(diskHtml);
            $(".cpuInfo").html(cpuHtml);
            $(".memoryInfo").html(memoryHtml);
        });
    });
</script>
</body>
</html>
