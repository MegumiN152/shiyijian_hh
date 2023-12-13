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
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/login.css">
	<title>login</title>
</head>

<body>
<main id="login">
	<div class="word">
		<img src="<%=basePath%>/images/ui/login1.png" alt="">
		<h4>欢迎注册阿米娅的行李箱</h4>
	</div>
	<div class="form">
		<form class="login">
			<h1>Login</h1>
			<input type="text" placeholder="用户名" pattern="^[a-z0-9_-]{3,16}$" required>
			<input type="password" placeholder="密码" pattern="^[a-z0-9_-]{3,16}$" required>
			<button type="button" onclick="login()">Login</button>
			<div class="control">
				<p>尚未注册？<a href="#register" class="toRegister">Register</a></p>
				<a href="./index.jsp">回到主页</a>
			</div>
		</form>
		<form class="register disappear">
			<h1>Register</h1>
			<input type="text" placeholder="用户名称" pattern="^[a-z0-9_-]{3,16}$" required id="username">
			<input type="text" placeholder="用户实名" pattern="^[a-z0-9_-]{3,16}$" required id="realName">
			<input type="password" placeholder="密码" pattern="^[a-z0-9_-]{3,16}$" required id="password">
			<input type="password" placeholder="密码确认" pattern="^[a-z0-9_-]{3,16}$" required id="passwordRepeat">
			<div class="chooseSex">
				<span>性别：</span>
				<label>男<input type="radio" value="true" name="sex" id="male" checked></label>
				<label>女<input type="radio" value="false" name="sex" id="female"></label>
			</div>
			<div class="chooseHead">
				<div id="maleHead">
					<img src="<%=basePath%>\images\data\model\mheadA.png" id="mheadA" width="70" height="80" class="headChecked">
					<img src="<%=basePath%>\images\data\model\mheadB.png" id="mheadB" width="70" height="80">
				</div>
				<div id="femaleHead" class="disappear">
					<img src="<%=basePath%>\images\data\model\wheadA.png" id="wheadA" width="70" height="80">
					<img src="<%=basePath%>\images\data\model\wheadB.png" id="wheadB" width="70" height="80">
				</div>
			</div>
			<button type="button" onclick="register()">Register</button>
			<div class="control">
				<p>注册过了？<a href="#login" class="toLogin">Login</a></p>
				<a href="./index.jsp">回到主页</a>
			</div>
		</form>

	</div>
	<div class="word">
		<img src="<%=basePath%>\images/ui/login2.png" alt="">
		<h4>欢迎来到阿米娅的行李箱</h4>
	</div>
</main>
</body>

<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
<script>

	// 切换登录注册
	$('.toRegister').click(function () {
		$('.login').addClass('disappear');
		$('.register').removeClass('disappear');
		$('.form').css('transform', 'rotateY(180deg)');
	});

	$('.toLogin').click(function () {
		$('.register').addClass('disappear');
		$('.login').removeClass('disappear');
		$('.form').css('transform', 'none');
	});

	// 回车键
	$('.login input[type=text]').keydown(function (e) {
		if (e.keyCode === 13) {
			if ($('.login input[type=text]').val() !== '') {
				$('.login input[type=password]').focus(); // 切换到密码字段
			}
		}
	});

	$('.login input[type=password]').keydown(function (e) {
		if (e.keyCode === 13) {
			if ($('.login input[type=password]').val() !== '') {
				login();
			} else {
				$('.login input[type=text]').focus(); // 切换到账号字段
			}
		}
	});

	// 注册选择性别
	$('#male').click(function () {
		$('#maleHead').removeClass('disappear');
		$('#femaleHead').addClass('disappear');
		$('#femaleHead img').removeClass('headChecked');
		$('#maleHead img').removeClass('headChecked').eq(0).addClass('headChecked');
	});

	$('#female').click(function () {
		$('#femaleHead').removeClass('disappear');
		$('#maleHead').addClass('disappear');
		$('#femaleHead img').removeClass('headChecked').eq(0).addClass('headChecked');
		$('#maleHead img').removeClass('headChecked');
	});

	// 注册选择头像
	$('#maleHead img').click(function () {
		$('#maleHead img').removeClass('headChecked');
		$(this).addClass('headChecked');
	});

	$('#femaleHead img').click(function () {
		$('#femaleHead img').removeClass('headChecked');
		$(this).addClass('headChecked');
	});


	/*
        code=-10: 用户名不存在或密码错误
        code=10: 登录成功
    */
	function loginSuccess(data) {
		if (data.code == 10) {
			window.open("./index.jsp", "_self");
		} else if (data.code == -10) {
			showMessage(data);
			window.reload();
		}
	}

	// 登录
	function login() {
		const username = $('.login input[type=text]').val();
		const password = $('.login input[type=password]').val();
		const user = {
			'username': username,
			'password': password
		};

		request('POST', '<%=basePath%>/suit/login', user, loginSuccess, serverError, true);
	};

	function registerSuccess(data) {
		showMessage(data);
		window.location.reload();
	}

	// 注册
	function register() {

		const username = $('.register #username').val();
		const realName = $('.register #realName').val();

		if(realName.length > 16){
			alert("用户实名的长度应小于等于16！");
			return false;
		}

		const password = $('.register #password').val();
		const passwordRepeat = $('.register #passwordRepeat').val();

		if (password !== passwordRepeat) {
			alert('两次密码不一致');
			return false;
		}

		const sex = $('.register .chooseSex input[type="radio"]:checked').val();

		const base = $('.register .headChecked').attr('id');
		const model = base + "Model.png";
		const modelHead = base + ".png";
		const user = {
			'username': username,
			'realName': realName,
			'password': password,
			'sex': sex === 'true',
			'model': model,
			'modelHead': modelHead
		}
		request('POST', '<%=basePath%>/suit/register', user, registerSuccess, serverError, true);
	};

</script>

</html>