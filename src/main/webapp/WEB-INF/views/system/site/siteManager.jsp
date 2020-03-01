<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>系统基本参数</title>
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
<form class="layui-form">
    <table class="layui-table mag0">
        <colgroup>
            <col width="25%">
            <col width="45%">
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>参数说明</th>
            <th>参数值</th>
            <th pc>变量名</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>网站名称</td>
            <td><input type="text" class="layui-input cmsName" lay-verify="required" placeholder="请输入模版名称"></td>
            <td pc>cmsName</td>
        </tr>
        <tr>
            <td>当前版本</td>
            <td><input type="text" class="layui-input version" placeholder="请输入当前模版版本"></td>
            <td pc>version</td>
        </tr>
        <tr>
            <td>开发作者</td>
            <td><input type="text" class="layui-input author" placeholder="请输入开发作者"></td>
            <td pc>author</td>
        </tr>
        <tr>
            <td>网站首页</td>
            <td><input type="text" class="layui-input homePage" placeholder="请输入网站首页"></td>
            <td pc>homePage</td>
        </tr>
        <tr>
            <td>是否打开验证码</td>
            <td>
                <input type="checkbox" name="openCode" lay-skin="switch" checked="" lay-text="打开|关闭">
            </td>
            <td>openCode</td>
        </tr>
        <tr>
            <td>服务器环境</td>
            <td><input type="text" value="Windows" disabled class="layui-input server" placeholder="请输入服务器环境"></td>
            <td pc>server</td>
        </tr>
        <tr>
            <td>数据库版本</td>
            <td><input type="text" value="Mysql 5.7+" disabled class="layui-input dataBase" placeholder="请输入数据库版本"></td>
            <td pc>dataBase</td>
        </tr>
        <tr>
            <td>文件上传方式</td>
            <td>
                <input type="radio" name="fileUploadType" value="0" title="本地上传" checked>
                <input type="radio" name="fileUploadType" value="1" title="七牛云存储" lay-filter="qiniuUpload">
                <input type="radio" name="fileUploadType" value="2" title="阿里云存储" lay-filter="ossUpload">
            </td>
            <td>fileUploadType</td>
        </tr>
        <tr>
            <td>最大上传限制</td>
            <td><input type="number" lay-verify="number" class="layui-input maxUpload" placeholder="请输入最大上传限制"></td>
            <td pc>maxUpload</td>
        </tr>
        <tr>
            <td>用户权限</td>
            <td><input type="text" class="layui-input userRights" placeholder="请输入当前用户权限"></td>
            <td pc>userRights</td>
        </tr>
        <tr>
            <td>默认关键字</td>
            <td><input type="text" class="layui-input keywords" placeholder="请输入默认关键字"></td>
            <td pc>keywords</td>
        </tr>
        <tr>
            <td>版权信息</td>
            <td><input type="text" class="layui-input powerby" placeholder="请输入网站版权信息"></td>
            <td pc>powerby</td>
        </tr>
        <tr>
            <td>网站LOGO</td>
            <td>
                <div class="layui-upload">
                    <input type="hidden" name="logo" id="logo">
                    <button type="button" class="layui-btn" id="test1">上传LOGO</button>
                    <div class="layui-upload-list" style="width: 50%;float: right;">
                        <img class="layui-upload-img" id="demo1">
                        <p id="demoText"></p>
                    </div>
                </div>
            </td>
            <td>logo</td>
        </tr>
        <tr>
            <td>网站备案号</td>
            <td><input type="text" class="layui-input record" placeholder="请输入网站备案号"></td>
            <td pc>record</td>
        </tr>
        <tr>
            <td>网站描述</td>
            <td><textarea placeholder="请输入网站描述" class="layui-textarea description"></textarea></td>
            <td pc>description</td>
        </tr>
        </tbody>
    </table>
    <div class="magt10 layui-right">
        <div class="layui-input-block" align="center">
            <button class="layui-btn" lay-submit="" lay-filter="systemParameter">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer', 'jquery', 'upload'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : parent.layer,
            laypage = layui.laypage,
            upload = layui.upload,
            $ = layui.jquery;

        //TODO:所有功能待实现

        //加载默认数据
        if (window.sessionStorage.getItem("systemParameter")) {
            var data = JSON.parse(window.sessionStorage.getItem("systemParameter"));
            fillData(data);
        } else {
            $.ajax({
                url: "${ctx}/resources/json/systemParameter.json",
                type: "get",
                dataType: "json",
                success: function (data) {
                    fillData(data);
                }
            })
        }

        //填充数据方法
        function fillData(data) {
            $(".version").val(data.version);      //当前版本
            $(".author").val(data.author);        //开发作者
            $(".homePage").val(data.homePage);    //网站首页
            $(".server").val(data.server);        //服务器环境
            $(".dataBase").val(data.dataBase);    //数据库版本
            $(".maxUpload").val(data.maxUpload);  //最大上传限制
            $(".userRights").val(data.userRights);//当前用户权限
            $(".cmsName").val(data.cmsName);      //模版名称
            $(".description").val(data.description);//站点描述
            $(".powerby").val(data.powerby);      //版权信息
            $(".record").val(data.record);      //网站备案号
            $(".keywords").val(data.keywords);    //默认关键字
        }

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1',
            url: '${ctx}/file/upload.json',
            accept: 'images',
            // exts:'ico',
            field: 'file',
            before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            },
            done: function (res) {
                if (res.code == 0) {
                    console.log('res', res);
                    return layer.msg("上传成功");
                } else {
                    return layer.msg("上传失败");
                }
                $("#logo").val(res.data.src);
            },
            error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });

        form.on('radio(qiniuUpload)', function(data){
            layer.open({
                title : "七牛云信息",
                type : 2,
                content : "${ctx}/resource/toQiniuInfo.page",
                area: ['550px','490px'],
                cancel:function (index, layero) {
                    console.log(layero);
                }
            });
        });

        form.on('radio(ossUpload)', function(data){
            layer.open({
                title : "阿里云信息",
                type : 2,
                content : "${ctx}/resource/toOssInfo.page",
                area: ['550px','500px']
            });
        });

    });
</script>
</body>
</html>
