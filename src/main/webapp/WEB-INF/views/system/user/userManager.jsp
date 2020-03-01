<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户管理</title>
</head>
<!-- 必须去掉body -->
<frameset cols="243,*" border="1" frameborder="yes">
    <frame name="left" src="${ctx}/user/toUserLeft.page">
    <frame name="right" src="${ctx}/user/toUserRight.page">
</frameset>
</html>