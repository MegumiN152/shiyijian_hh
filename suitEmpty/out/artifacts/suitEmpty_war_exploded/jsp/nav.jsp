<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path; %>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/commen.css">
        <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/nav.css">
        <title>nav</title>
    </head>
    <body>
        <main id="nav">
                <a id="bt1"><img class="bt" src="<%=basePath%>/images/ui/userInfo.png" alt="个人信息"></a>
                <a id="bt2"><img class="bt" src="<%=basePath%>/images/ui/userManage.png" alt="管理用户"></a>
                <a id="bt3"><img class="bt" src="<%=basePath%>/images/ui/suits.png" alt="服装类别"></a>
                <a id="bt4"><img class="bt" src="<%=basePath%>/images/ui/clothManage.png" alt="管理衣物"></a>
                <a id="bt5"><img class="bt" src="<%=basePath%>/images/ui/mySuits.png" alt="选购衣物"></a>
                <a id="bt6"><img class="bt" src="<%=basePath%>/images/ui/exit.png" alt="退出登陆"></a>
        </main>
    </body>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>/js/main.js"></script>

    <script>
        const bts = [
            {"code": "#bt1", "url": "<%=basePath%>/jsp/userInfo.jsp"},
            {"code": "#bt2", "url": "<%=basePath%>/jsp/userManage.jsp"},
            {"code": "#bt3", "url": "<%=basePath%>/jsp/suits.jsp"},
            {"code": "#bt4", "url": "<%=basePath%>/jsp/clothManage.jsp"},
            {"code": "#bt5", "url": "<%=basePath%>/jsp/mySuits.jsp"}
        ];

        $(document).ready(function () {
            for(let i = 0; i < 5; i++) {
                let code = bts[i].code;
                let url = bts[i].url;
                $(code).click(function () {
                    $(code).attr('target', "workspace");
                    $(code).attr('href', url);
                    $('.bt').removeClass('active');
                    $(code).children().addClass('active');
                });
            }
        });

        $("#bt6").click(function () {
            request("POST","<%=basePath%>/suit/exit",{},exitSuccess,serverError,true);
        });

        function exitSuccess() {
            window.open("./login.jsp", "_parent");
        }
    </script>
</html>