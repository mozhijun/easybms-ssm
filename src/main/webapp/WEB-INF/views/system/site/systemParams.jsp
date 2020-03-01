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
    <style type="text/css">
        .layui-form-item .layui-inline {
            width: 33.333%;
            float: left;
            margin-right: 0;
        }

        @media (max-width: 1240px) {
            .layui-form-item .layui-inline {
                width: 100%;
                float: none;
            }
        }

        .layui-form-item .role-box {
            position: relative;
        }

        .layui-form-item .role-box .jq-role-inline {
            height: 100%;
            overflow: auto;
        }

        .layui-form[wid100] .layui-form-label {
            width: 110px;
        }

        .layui-form[wid100] .layui-input-block {
            margin-left: 140px;
        }
    </style>
</head>
<body>
<div class="layui-fluid" style="padding: 15px;">
    <%--<div class="layui-card">--%>
    <div class="layui-tab layui-tab-brief" lay-filter="systemParams">
        <ul class="layui-tab-title">
            <li class="layui-this">站点信息</li>
            <li>邮件服务</li>
            <li>第三方登录</li>
            <li>图片存储</li>
        </ul>
        <div class="layui-tab-content">
            <%--站点信息--%>
            <div class="layui-tab-item layui-show">
                <div class="layui-row" style="margin-top: 10px;">
                    <div class="layui-col-md6 layui-col-lg-offset3">
                        <form class="layui-form layui-form-pane">
                            <div class="layui-form-item">
                                <label class="layui-form-label">站点名称</label>
                                <div class="layui-input-block">
                                    <input type="text" name="siteName" placeholder="请输入站点名称" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">域名</label>
                                <div class="layui-input-block">
                                    <input type="text" name="domainName" placeholder="请输入站点域名" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">站点关键字</label>
                                <div class="layui-input-block">
                                    <input type="text" name="domainName" placeholder="EasyBMS,后台管理系统..."
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">扩展METAS</label>
                                <div class="layui-input-block">
                                    <input type="text" name="meta" placeholder="请输入meta标签" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">Copyright</label>
                                <div class="layui-input-block">
                                    <input type="text" name="copyRight" placeholder="Copyright @ 小莫..."
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">备案号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="beiAn" placeholder="沪ICP备888888号" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">Logo</label>
                                <div class="layui-input-block">
                                    <input type="text" name="logo" placeholder="/site/images/logo.png..."
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">Favicon</label>
                                <div class="layui-input-block">
                                    <input type="text" name="favicon" placeholder="/site/images/favicon.icon..."
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item" pane="">
                                <label class="layui-form-label">验证码</label>
                                <div class="layui-input-block">
                                    <input type="checkbox" checked="" name="code" lay-skin="switch"
                                           lay-filter="codeSwitch" title="开启">
                                </div>
                            </div>
                            <div class="layui-form-item layui-form-text">
                                <label class="layui-form-label">站点描述</label>
                                <div class="layui-input-block">
                                        <textarea placeholder="一套基于Layui的后台敏捷开发脚手架,零门槛、上手快..."
                                                  class="layui-textarea"></textarea>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button class="layui-btn" lay-submit=""
                                        lay-filter="saveSiteInfo">立即提交
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%--邮件服务配置--%>
            <div class="layui-tab-item">
                <div class="layui-row" style="margin-top: 10px;">
                    <div class="layui-col-md6 layui-col-lg-offset3">
                        <form class="layui-form layui-form-pane">
                            <div class="layui-form-item">
                                <label class="layui-form-label">邮箱SMTP地址</label>
                                <div class="layui-input-block">
                                    <input type="text" name="smtpAddr" placeholder="smtp.163.com..."
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">邮箱账号</label>
                                <div class="layui-input-block">
                                    <input type="text" name="mailAcount" placeholder="test@163.com..."
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">邮箱密码</label>
                                <div class="layui-input-block">
                                    <input type="text" name="mailPwd" placeholder="123456..."
                                           autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <button class="layui-btn" lay-submit=""
                                        lay-filter="saveMailInfo">立即提交
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%--第三方登录--%>
            <div class="layui-tab-item">
                <div class="layui-col-md6 layui-col-lg-offset2" style="margin-top: 10px;">
                    <div class="layui-card">
                        <div class="layui-card-header">QQ登录</div>
                        <div class="layui-card-body">
                            <form class="layui-form layui-form-pane">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">回调地址</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="callbackUrl"
                                               placeholder="示例：http://{domain}/oauth/callback/qq"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">APP ID</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="qqAppId" placeholder="请输入平台生成的appId..."
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">APP KEY</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="qqAppKey" placeholder="请输入平台生成的appKey..."
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">APP SECRET</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="qqAppSecret" placeholder="请输入平台生成的appSecret..."
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="layui-card">
                        <div class="layui-card-header">微信登录</div>
                        <div class="layui-card-body">
                            <form class="layui-form layui-form-pane">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">回调地址</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="callbackUrl"
                                               placeholder="示例：http://{domain}/oauth/callback/qq"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">APP ID</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="wxAppId" placeholder="请输入平台生成的appId..."
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">APP KEY</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="wxAppKey" placeholder="请输入平台生成的appKey..."
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">APP SECRET</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="wxAppSecret" placeholder="请输入平台生成的appSecret..."
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div>
                        <button class="layui-btn" id="saveOauthInfo">立即提交</button>
                    </div>
                </div>
            </div>
            <%--存储方式配置--%>
            <div class="layui-tab-item">
                <div class="layui-col-md6 layui-col-lg-offset2" style="margin-top: 10px;">
                    <form class="layui-form layui-form-pane">
                        <div class="layui-form-item">
                            <div class="layui-form-label">存储方式</div>
                            <div class="layui-input-block">
                                <select name="storageType" id="storageType" lay-filter="storageType">
                                    <option value="local">本地存储</option>
                                    <option value="qiniu">七牛云存储</option>
                                    <option value="aliyun">阿里云存储</option>
                                </select>
                            </div>
                        </div>
                        <%--七牛云存储配置--%>
                        <div class="storageType" id="qiniu" data-storageType="qiniu">
                            <div class="layui-form-item">
                                <label class="layui-form-label">Bucket域名<span class="layui-badge-dot"></span></label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="qiniuBasePath" value=""
                                           lay-verify="required" placeholder="请输入七牛Bucket 域名或者自有自有域名">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">Bucket目录<span class="layui-badge-dot"></span></label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="qiniuBucketName" value=""
                                           lay-verify="required" placeholder="请输入七牛Bucket目录">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">存储目录</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="qiniuDir" value=""
                                           placeholder="请输入存储目录">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">ACCESS_KEY<span class="layui-badge-dot"></span></label>
                                <div class="layui-input-block">
                                    <input type="password" class="layui-input" name="qiniuAccessKey" value=""
                                           lay-verify="required" placeholder="请输入七牛ACCESS_KEY">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">SECRET_KEY<span class="layui-badge-dot"></span></label>
                                <div class="layui-input-block">
                                    <input type="password" class="layui-input" name="qiniuSecretKey" value=""
                                           lay-verify="required" placeholder="请输入七牛SECRET_KEY">
                                </div>
                            </div>
                        </div>
                        <%--阿里云存储配置--%>
                        <div id="aliyun" data-storageType="aliyun">
                            <div class="layui-form-item">
                                <label class="layui-form-label">Bucket域名<span class="layui-badge-dot"></span></label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="ossBasePath" value=""
                                           lay-verify="required"
                                           placeholder="请输入阿里云Bucket 域名或者自有自有域名">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">Bucket目录<span class="layui-badge-dot"></span></label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="ossBucketName" value=""
                                           lay-verify="required" placeholder="请输入阿里云Bucket目录">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">存储目录</label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="ossDir" value="" placeholder="请输入存储目录">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">KEY_ID<span class="layui-badge-dot"></span></label>
                                <div class="layui-input-block">
                                    <input type="password" class="layui-input" name="ossKeyId" value=""
                                           lay-verify="required"
                                           placeholder="请输入阿里云ACCESS_KEY_ID">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">KEY_SECRET<span class="layui-badge-dot"></span></label>
                                <div class="layui-input-block">
                                    <input type="password" class="layui-input" name="ossKeySecret" value=""
                                           lay-verify="required" placeholder="请输入阿里云ACCESS_KEY_SECRET">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">ENDPOINT<span class="layui-badge-dot"></span></label>
                                <div class="layui-input-block">
                                    <input type="text" class="layui-input" name="ossEndpoint" value=""
                                           lay-verify="required"
                                           placeholder="请输入阿里云ENDPOINT">
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="layui-form-item">
                        <button class="layui-btn" id="saveStorageInfo">立即提交</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer', 'jquery', 'element', 'upload'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : parent.layer,
            laypage = layui.laypage,
            upload = layui.upload,
            element = layui.element, //Tab的切换功能，切换事件监听等，需要依赖element模块
            $ = layui.jquery;

        //TODO:所有功能待实现

        /**
         * 页面加载时候隐藏 七牛云 和 阿里云 配置页面
         */
        $("#qiniu").hide();
        $("#aliyun").hide();
        form.render('select');

        /**
         * 选择不同的配置页面展示
         */
        form.on('select(storageType)', function (data) {
            if (data.value == "qiniu") {
                $("#qiniu").show();
                $("#aliyun").hide();
                form.render('select');
            } else if (data.value == "aliyun") {
                $("#aliyun").show();
                $("#qiniu").hide();
                form.render('select');//select是固定写法 不是选择器
            } else {
                $("#qiniu").hide();
                $("#aliyun").hide();
                form.render('select');
            }
        });

        /**
         * 点击保存站点信息按钮
         */
        form.on('submit(saveSiteInfo)', function (data) {
            console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
            console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
            console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
            var index = layer.msg('提交中，请稍候', {icon: 16, time: 2500, shade: 0.8});
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        /**
         * 保存邮件信息
         */
        form.on('submit(saveMailInfo)', function (data) {
            console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
            console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
            console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
            var index = layer.msg('提交中，请稍候', {icon: 16, time: 2500, shade: 0.8});
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        /**
         *
         */
        $('#saveOauthInfo').click(function () {
            var index = layer.msg('提交中，请稍候', {icon: 16, time: 2500, shade: 0.8});
        });
        /**
         * 保存存储配置信息
         */
        $('#saveStorageInfo').click(function () {
            var index = layer.msg('提交中，请稍候', {icon: 16, time: 2500, shade: 0.8});
        });
    });
</script>
</body>
</html>
