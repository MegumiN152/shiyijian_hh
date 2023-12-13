<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":"
			+ request.getServerPort() + path; %>
<html lang="zh-CN">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/commen.css">
		<link rel="stylesheet" href="<%=basePath%>/css/suits.css">
		<title>suits</title>
	</head>
	
	<body>
	<section class="suitBlock" id="template" style="display: none">
		<h3 class="Title">服饰类别</h3>
		<label>
			<span>编号：</span>
			<input type="text" name="code">
		</label>
		<label>
			<span>名称：</span>
			<input type="text" name="name">
		</label>
		<span class="control">
			<button class="save">保存</button>
			<button class="delete">删除</button>
		</span>
	</section>
	<main id="suits">
	</main>
	</body>
<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/main.js"></script>
<script>
	function isAdmin() {
		return '${user.isAdmin}' === 'true';
	}
	$(document).ready(function () {
		if ( !isAdmin()){
			alert("您没有权限");
			return;
		} else {
			request("POST", "<%=basePath%>/suit/typeList", {}, initSuits, serverError, true);
		}
	});

	function changeSuccess(data) {
		showMessage(data);
		request("POST", "<%=basePath%>/suit/typeList", {}, initSuits, serverError, true);
	}

	function initSuits(data) {
		const template = $("#template");
		const suits = $("#suits");
		suits.empty();

		// 添加新的服饰类别
		const suitBlock = template.clone();
		suitBlock.removeAttr("id");
		suitBlock.find(".control .delete").remove();
		suitBlock.find(".control .save").remove();

		suitBlock.find(".control").append('<button class="add">添加</button>');
		suitBlock.find(".add").click(function () {
			if ( !isAdmin()){
				alert("您没有权限");
				return;
			}
			const code = suitBlock.find("input[name='code']").val().trim();
			const name = suitBlock.find("input[name='name']").val().trim();
			if (code === "" || name === "") {
				alert("请输入完整信息");
				return;
			}
			request("POST", "<%=basePath%>/suit/addType", {
				code: code,
				name: name
			}, changeSuccess, serverError, true);
		});
		suitBlock.show();
		suits.append(suitBlock);

		// 显示服饰类别
		const suitList = data.data;
		for (let i = 0; i < suitList.length; i++) {
			const suit = suitList[i];
			const suitBlock = template.clone();
			suitBlock.attr("id", suit.id);
			suitBlock.find("input[name='code']").val(suit.code);
			suitBlock.find("input[name='name']").val(suit.name);
			suitBlock.find(".save").click(function () {
				if ( !isAdmin()){
					alert("您没有权限");
					return;
				}
				const id = suitBlock.attr("id");
				const code = suitBlock.find("input[name='code']").val();
				const name = suitBlock.find("input[name='name']").val();
				request("POST", "<%=basePath%>/suit/updateType", {
					id: id,
					code: code,
					name: name
				},changeSuccess, serverError, true);
			});
			suitBlock.find(".delete").click(function () {
				if ( !isAdmin()){
					alert("您没有权限");
					return;
				}
				const id = suitBlock.attr("id");
				const code = suitBlock.find("input[name='code']").val();
				const name = suitBlock.find("input[name='name']").val();
				if (confirm('确认要删除 ' + name + ' 吗？') === false) {
					return;
				}
				request("POST", "<%=basePath%>/suit/deleteType", {
					id: id,
					code: code,
					name: name
				}, changeSuccess, serverError, true);
			});
			suitBlock.show();
			suits.append(suitBlock);
		}
	}
</script>
</html>