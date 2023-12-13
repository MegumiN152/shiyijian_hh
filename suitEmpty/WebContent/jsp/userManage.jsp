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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<%=basePath%>/css/commen.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>/css/userManage.css" type="text/css">
	<title>userManage</title>
</head>

<body>
<main id="userManage">
	<table id="table">
		<tr>
			<th style="padding:0 7px;">id</th>
			<th style="padding:0 15px;">用户名称</th>
			<th style="padding:0 15px;">用户实名</th>
			<th style="padding:0 7px;">性别</th>
			<th style="padding:0 15px;">模型选择</th>
			<th style="padding:0 15px;">是否管理员</th>
			<th style="padding:0 100px;">操作</th>
		</tr>
		<tr id="template" style="display: none">
			<td class="id"></td>
			<td class="username"></td>
			<td class="realName"></td>
			<td class="sex"></td>
			<td class="image"><img class="headImage" alt="not found"></td>
			<td class="power"></td>
			<td class="operation controlButton">
				<button class="delete">删除</button>
				<button class="change">修改</button>
			</td>
		</tr>
	</table>

	<form id="changeInfo" style="display: none">
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
				<label><input type="radio" value="mheadA" name="chooseHead" checked><img src="<%=basePath%>\images\data\model\mheadA.png" width="70" height="80"></label>
				<label><input type="radio" value="mheadB" name="chooseHead"><img src="<%=basePath%>\images\data\model\mheadB.png" width="70" height="80"></label>
			</div>
			<div id="femaleHead">
				<label><input type="radio" value="wheadA" name="chooseHead" checked><img src="<%=basePath%>\images\data\model\wheadA.png" width="70" height="80"></label>
				<label><input type="radio" value="wheadB" name="chooseHead"><img src="<%=basePath%>\images\data\model\wheadB.png" width="70" height="80"></label>
			</div>
		</div>
		<div class="isAdmin">
			<p>管理员：</p>
			<label>是<input type="radio" value="true" name="isAdmin"></label>
			<label>否<input type="radio" value="false" name="isAdmin" checked></label>
		</div>
		<div class="controlButton">
			<button type="button" onclick="submitChange()">提交</button>
			<button type="button" onclick="$('#changeInfo').hide()">取消</button>
		</div>
	</form>
</main>

</body>

<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>

<script type="text/javascript">

	// 选择性别
	$('#male').click(function () {
		$('#maleHead').show();
		$('#femaleHead').hide();
	});

	$('#female').click(function () {
		$('#femaleHead').show();
		$('#maleHead').hide();
	});

	function isAdmin() {
		return '${user.isAdmin}' === 'true';
	}

	$(document).ready(function () {

		if ( !isAdmin()){
			alert("您没有权限");
		}else {
			// 页面初始化请求数据
			request("POST","<%=basePath%>/suit/all",{},initlist,serverError,true);
		}
	});

	function successAlter(data) {
		showMessage(data);
		request("POST","<%=basePath%>/suit/all",{},initlist,serverError,true);
	}

	// 初始化表单
	function initlist(data) {

		$("#changeInfo").hide();
		$("#table .mainInfo").remove();
		if(data.code === 10){
			$(data.data).each(function (index,item) {
				const template = $("#template").clone();
				$(template).attr("id","");
				$(template).addClass("mainInfo");

				// 填充数据
				$(template).find(".id").text(item.id);
				$(template).find(".username").text(item.username);
				$(template).find(".realName").text(item.realName);
				$(template).find(".sex").text(item.sex ? '男' : '女');
				const src = "<%=basePath%>/images/data/model/"+item.modelHead;
				$(template).find(".headImage").attr("src",src).width("50px").height("60px");
				$(template).find(".power").text(item.isAdmin ? "是" : "否");

				// 为每个用户的"修改按钮"注册事件
				$(template).find(".change").click(function () {
					if ( !isAdmin()){
						alert("您没有权限");
						return;
					}
					request("POST","<%=basePath%>/suit/getOne",item,initCurUser,serverError,true);
					// 将表单显示出
					$("#changeInfo").show("fast");
				});

				// 为每个用户的"删除按钮"注册事件
				$(template).find(".delete").click(function () {
					if ( !isAdmin()){
						alert("您没有权限");
						return;
					}
					if('' + item.id === '${user.id}'){
						alert("你是该系统管理员，无法删除自己!");
						return false;
					}
					if(confirm("确定要删除吗？")){
						request("POST","<%=basePath%>/suit/del",item,delSuccess,serverError,true);
					}
				});
				template.show();
				$("#table").append(template);
			});
		} else{
			alert(data.description);
		}

		function delSuccess(data) {
			alert(data.description);
			request("POST","<%=basePath%>/suit/all",{},initlist,serverError,true);
		}
	}

	const curUser = {};

	function submitChange() {
		if ( !isAdmin()){
			alert("您没有权限");
			return;
		}
		curUser.username = $("#username").val();
		curUser.realName = $("#realName").val();

		if(curUser.realName.length > 16){
			alert("用户实名的长度应小于等于16！");
			return;
		}

		if ($("#password").val() !== "" && $("#password").val() === $("#passwordRepeat").val()) {
			curUser.password = $("#password").val();
		} else if ($("#password").val() !== "" && $("#password").val() !== $("#passwordRepeat").val()) {
			alert("两次密码不一致");
			return;
		} else if ($("#password").val() === "" && $("#passwordRepeat").val() !== "") {
			alert("请填写密码");
			return;
		}

		// 性别
		curUser.sex = $('.chooseSex input:radio[name="sex"]:checked').val() === "true";

		const base = $('.chooseHead input:radio[name="chooseHead"]:checked').val();
		curUser.model = base + "Model.png";
		curUser.modelHead = base + ".png";

		// 是否为管理员
		curUser.isAdmin = $('input:radio[name="isAdmin"]:checked').val() === "true";

		request("POST","<%=basePath%>/suit/updateUser",curUser,successAlter,serverError,true);
	}

	function initCurUser(data) {
		const user = data.data;
		console.log(user);
		$("#password").val("");
		$("#passwordRepeat").val("");
		if(user.sex) {
			$('#chooseSex #male').prop("checked",true);
			$('#maleHead').show();
			$('#femaleHead').hide();
			if(user.modelHead === "mheadA.png"){
				$('input:radio[name="chooseHead"][value="mheadA"]').prop('checked', true);
			} else {
				$('input:radio[name="chooseHead"][value="mheadB"]').prop('checked', true);
			}
		} else {
			$('.chooseSex #female').prop("checked",true);
			$('#femaleHead').show();
			$('#maleHead').hide();
			if(user.modelHead === "wheadA.png"){
				$('input:radio[name="chooseHead"][value="wheadA"]').prop('checked', true);
			} else {
				$('input:radio[name="chooseHead"][value="wheadB"]').prop('checked', true);
			}
		}
		$('#username').val(user.username);
		$('#realName').val(user.realName);
		if(user.isAdmin){
			$('input:radio[name="isAdmin"][value="true"]').prop('checked', true);
		}else{
			$('input:radio[name="isAdmin"][value="false"]').prop('checked', true);
		}
		curUser.password = user.password;
		curUser.id = user.id;
	}
</script>
</script>
</html>