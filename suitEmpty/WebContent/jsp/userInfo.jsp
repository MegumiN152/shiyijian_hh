<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + path; %>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=basePath%>/css/commen.css">
    <link rel="stylesheet" href="<%=basePath%>/css/userInfo.css">
</head>

<body>
<main id="userInfo">
    <form class="changeInfo">
    <h1>用户信息</h1>
    <label>
        <span>用户名称</span>
        <input type="text" placeholder="用户名称" pattern="^[^\s]{3,16}$" required id="username" readonly>
    </label>
    <label>
        <span>用户实名</span>
        <input type="text" placeholder="用户实名" pattern="^[^\s]{3,16}$" required id="realName">
    </label>
    <label>
        <span>密码</span>
        <input type="password" placeholder="(不修改则留空)" pattern="^[^\s]{3,16}$" id="password">
    </label>
    <label>
        <span>密码确认</span>
        <input type="password" placeholder="(不修改则留空)" pattern="^[^\s]{3,16}$" id="passwordRepeat">
    </label>
    <div class="chooseSex">
        <p>性别：</p>
        <label>男<input type="radio" value="true" name="sex" id="male" checked></label>
        <label>女<input type="radio" value="false" name="sex" id="female"></label>
    </div>
    <div class="chooseHead">
        <div id="maleHead">
            <img src="<%=basePath%>\images\data\model\mheadA.png" id="mheadA" width="70" height="80"
                 class="headChecked">
            <img src="<%=basePath%>\images\data\model\mheadB.png" id="mheadB" width="70" height="80">
        </div>
        <div id="femaleHead" class="disappear">
            <img src="<%=basePath%>\images\data\model\wheadA.png" id="wheadA" width="70" height="80">
            <img src="<%=basePath%>\images\data\model\wheadB.png" id="wheadB" width="70" height="80">
        </div>
    </div>
    <button type="button" onclick="submitChange()">confirm change</button>
    </form>
</main>
</body>

<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
<script>

    // 选择性别
    $('#male').click(function () {
        $('#maleHead').removeClass('disappear');
        $('#femaleHead').addClass('disappear');
        $('#femaleHead img').removeClass('headChecked');
        $('#maleHead img').removeClass('headChecked').eq(0).addClass('headChecked');
    });

    $('#female').click(function () {
        $('#femaleHead').removeClass('disappear');
        $('#maleHead').addClass('disappear');
        $('#femaleHead img').removeClass('headChecked').eq(0).addClass('headChecked')
        $('#maleHead img').removeClass('headChecked');
    });

    // 选择头像
    $('#maleHead img').click(function () {
        $('#maleHead img').removeClass('headChecked');
        $('#femaleHead img').removeClass('headChecked');
        $(this).addClass('headChecked');
    });

    $('#femaleHead img').click(function () {
        $('#maleHead img').removeClass('headChecked');
        $('#femaleHead img').removeClass('headChecked');
        $(this).addClass('headChecked');
    });

    // 初始化
    $(document).ready(function () {
        if('${user.sex}' === 'true') {
            // 性别
            $('#male').attr('checked',true);

            // 头像
            $('#maleHead').removeClass('disappear');
            $('#femaleHead').addClass('disappear');
            $('#femaleHead img').removeClass('headChecked');
            if ('${user.modelHead}' === 'mheadA.png') {
                $('#maleHead img').removeClass('headChecked').eq(0).addClass('headChecked');
            } else {
                $('#maleHead img').removeClass('headChecked').eq(1).addClass('headChecked');
            }
        } else{
            // 性别
            $('#female').attr('checked',true);

            // 头像
            $('#femaleHead').removeClass('disappear');
            $('#maleHead').addClass('disappear');
            $('#maleHead img').removeClass('headChecked');
            if ('${user.modelHead}' === 'wheadA.png') {
                $('#femaleHead img').removeClass('headChecked').eq(0).addClass('headChecked');
            } else {
                $('#femaleHead img').removeClass('headChecked').eq(1).addClass('headChecked');
            }
        }
        $('#username').val('${user.username}');
        $('#realName').val('${user.realName}');
    });

    // 提交表单
    function submitChange() {
        const username = $('.changeInfo #username').val();
        const realName = $('.changeInfo #realName').val();

        if(realName.length >= 16){
            alert("用户实名的长度应小于等于16！");
            return false;
        }

        const password = $('.changeInfo #password').val();
        const passwordRepeat = $('.changeInfo #passwordRepeat').val();

        if (password !== passwordRepeat) {
            alert('两次密码不一致');
            return false;
        }

        const sex = $('.changeInfo .chooseSex input[type="radio"]:checked').val();

        const base = $('.changeInfo .headChecked').attr('id');
        const model = base + "Model.png";
        const modelHead = base + ".png";

        const newUser = {
            "id":'${user.id}',
            "username": username,
            "password": password || '${user.password}', // 如果没有修改密码，则使用原密码
            "sex": sex === "true",
            "realName":realName,
            "isAdmin": '${user.isAdmin}' === "true",
            "model": model,
            "modelHead": modelHead
        };

        request("POST","<%=basePath%>/suit/updateUserInfor",newUser,successCallBack,serverError,true);
    };

    function successCallBack(data) {
        showMessage(data);
    }
</script>

</html>