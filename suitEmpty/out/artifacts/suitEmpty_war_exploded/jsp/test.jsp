<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + 
                                      request.getServerName() + ":" +
                                      request.getServerPort() + path;
%>
<html>
<head>
	<title>test</title>
</head>
<body>

</body>

	<script src="<%=basePath%>/js/jquery.min.js" type="text/javascript"></script>

	<script>

	</script>
</html>