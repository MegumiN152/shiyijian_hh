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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>阿米娅的行李箱</title>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
</head>
<frameset cols="*,1980,*" frameborder="no" border="0" framespacing="0">
    <frame src="about:blank"></frame>
<frameset rows="48px,*" border="0" framespacing="0">
	<frame src="<%=basePath%>/jsp/banner.jsp"  />
	<frameset cols="140px,*" border="0" framespacing="0">
		<frame src="<%=basePath%>/jsp/nav.jsp" />
		<frame name="workspace" src="<%=basePath%>/jsp/openHello.jsp" />
 	</frameset>	
 </frameset>
 <frame src="about:blank"></frame>
</frameset>
</html>