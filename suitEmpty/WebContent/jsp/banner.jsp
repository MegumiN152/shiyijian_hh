<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() + path;
%>

<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=basePath%>/css/commen.css">
    <link rel="stylesheet" href="<%=basePath%>/css/banner.css">
	<title>banner</title>

</head>

<body>
    <div id="banner">
        <p id="userHi">Hi</p>
    </div>

</body>

<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>

<script>
    window.onload = function () {
        $("#userHi").text("当前用户：" + "${user.realName}");
    };
</script>

</html>