<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<html lang="zh-CN">
<head>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/commen.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/openHello.css">
	<title>阿米娅的行李箱</title>
</head>
<body>
	<main id="openHello">
		<h1>Hi,${user.username}</h1>
		<h1>欢迎来到阿米娅的行李箱！</h1>
	</main>
</body>

<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
</html>