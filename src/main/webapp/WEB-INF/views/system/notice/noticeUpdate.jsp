<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改公告</title>
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
<form class="layui-form" id="noticeFrm">
    <div class="layui-form-item">
        <label class="layui-form-label">公告标题</label>
        <div class="layui-input-block">
            <input type="hidden" name="noticeId" value="${notice.noticeId}">
            <input type="text" name="noticeTitle" id="noticeTitle" value="${notice.noticeTitle}" placeholder="公告标题"
                   lay-verify="required"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">公告内容</label>
        <div class="layui-input-block">
            <textarea type="text" name="noticeContent" id="noticeContent" placeholder="公告内容" lay-verify="required"
                      autocomplete="off"
                      class="layui-textarea">${notice.noticeContent}</textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea type="text" name="remark" id="remark" placeholder="备注" autocomplete="off"
                      class="layui-textarea">${notice.remark}</textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">公告类型</label>
        <div class="layui-input-block">
            <input type="radio" name="noticeType" autocomplete="off" title="通知" value="1"
            ${notice.noticeType == 1 ? 'checked' : ''}>
            <input type="radio" name="noticeType" autocomplete="off" title="公告" value="2"
            ${notice.noticeType == 2 ? 'checked' : ''}>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">公告状态</label>
        <div class="layui-input-block">
            <input type="checkbox" name="status" autocomplete="off" lay-skin="switch" title="否" lay-text="启用|禁用"
                   lay-filter="status" ${notice.status == 1 ? 'checked' : ''}>
        </div>
    </div>

    <div class="layui-form-item" style="text-align: center;">
        <button class="layui-btn" lay-submit="" lay-filter="modifyNotice">提交</button>
        <button class="layui-btn layui-btn-warm" type="reset">重置</button>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer', 'jquery', 'layedit'], function () {
        var form = layui.form;
        var $ = layui.jquery;
        var layedit = layui.layedit;
        //如果父页面有layer就是用父页面的，没有就导入
        var layer = parent.layer === undefined ? layui.layer : parent.layer;

        /**
         * 初始化公告编辑富文本
         */
        var editIndex = layedit.build('noticeContent', {
            tool: [
                'strong' //加粗
                , 'italic' //斜体
                , 'underline' //下划线
                , 'del' //删除线
                , '|' //分割线
                , 'left' //左对齐
                , 'center' //居中对齐
                , 'right' //右对齐
                , 'link' //超链接
                , 'unlink' //清除链接
                , 'face' //表情
                , 'image' //插入图片
                // , 'help' //帮助
            ]
            , uploadImage: {
                url: "${ctx}/file/upload.json"
            }
        });

        //监听提交，使用layui form submit事件
        form.on('submit(modifyNotice)', function (data) {
            layer.load(2, {
                shade: [0.2, '#000'] //0.2透明度的白色背景
            });
            //用于同步编辑器内容到textarea（一般用于异步提交）
            layedit.sync(editIndex);
            //noticeContent
            data.field.noticeContent = layedit.getContent(editIndex);
            //status
            if (null == data.field.status || undefined === data.field.status || "" === data.field.status) {
                data.field.status = 0;
            } else {
                data.field.status = 1;
            }
            $.post(
                '${ctx}/notice/modifyNotice.json',
                data.field,
                function (data) {
                    layer.closeAll('loading');
                    if (data.code == 0) {
                        //弹出成功的提示
                        layer.msg(data.msg, {icon: 1, time: 2000}, function () {
                            //关闭窗口
                            var index = parent.layer.getFrameIndex(window.name);
                            layer.close(index);
                            //重载表格
                            window.parent.tableIns.reload();
                        });
                    } else {
                        layer.closeAll('loading');
                        layer.msg(data.msg, {icon: 2, time: 3000});
                    }
                }
            );
            return false;
        });
    });
</script>
</body>
</html>
