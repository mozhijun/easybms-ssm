<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-xs12 layui-col-sm-12 layui-col-lg12 layui-col-md12">
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
                                <tr>
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
                </div>
            </div>
        </div>
        <div class="layui-col-md4">
            <!--cpu信息-->
            <div class="layui-card">
                <div class="layui-card-header">CPU信息</div>
                <div class="layui-card-body layui-text">
                    <table class="layui-table">
                        <colgroup>
                            <col width="300">
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
    layui.use(['form', 'element', 'layer', 'jquery'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            element = layui.element;
        $ = layui.jquery;
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
