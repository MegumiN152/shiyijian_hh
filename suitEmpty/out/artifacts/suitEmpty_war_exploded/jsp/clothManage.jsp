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
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/clothManage.css" />
	<script src="<%=basePath%>/js/jquery.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>/js/vendor/jquery.ui.widget.js"></script>
	<script src="<%=basePath%>/js/jquery.iframe-transport.js" type="text/javascript"></script>
	<script src="<%=basePath%>/js/jquery.fileupload.js" type="text/javascript"></script>
	<script src="<%=basePath%>/js/main.js" type="text/javascript"></script>
	<link href="<%=basePath%>/css/main.css" rel="stylesheet" type="text/css">
	<link href="<%=basePath%>/css/jquery.fileupload.css" rel="stylesheet" type="text/css">
	<link href="<%=basePath%>/css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css">
	<title>clothManage</title>
	</head>
	<body>
	<main id="suitManage">
		<nav id="query">
			<label>
				<span>性别：</span>
				<select name="sex" id="sex">
					<option>请选择</option>
					<option value="male">男</option>
					<option value="female">女</option>
				</select>
			</label>
			<label>
				<span>服饰类别：</span>
				<select name="type" id="type">
					<option>请选择</option>
				</select>
			</label>
			<button onclick="query()">查询</button>
		</nav>

		<main id="mainInfo">
			<section id="addSuit">
				<h3>服饰细目</h3>
				<div id="addSuitList">
					<label>
						<span>编号：</span>
						<input type="text" required name="code">
					</label>
					<label>
						<span>名称：</span>
						<input type="text" required name="name">
					</label>
					<label>
						<span>价格：</span>
						<input type="text" required name="price">
					</label>
					<label>
						<span>性别：</span>
						<select name="sex">
							<option value="male">男</option>
							<option value="female">女</option>
						</select>
					</label>
					<label>
						<span>分类：</span>
						<select name="type">
						</select>
					</label>
				</div>

				<div class="btnControl">
					<button class="add" onclick="addSuit()">添加</button>
				</div>
			</section>
		</main>
		<section class="suitDetailed" id="template" style="display: none">
			<h3>图片细目</h3>
			<div class="suitInfo">
				<div class="suitText">
					<label>
						<span>编号：</span>
						<input type="text" name="code">
					</label>
					<label>
						<span>名称：</span>
						<input type="text" name="name">
					</label>
					<label>
						<span>价格：</span>
						<input type="text" name="price">
					</label>
					<label>
						<span>性别：</span>
						<select name="sex">
							<option value="male">男</option>
							<option value="female">女</option>
						</select>
					</label>
					<label>
						<span>分类：</span>
						<select name="type">
						</select>
					</label>
				</div>
				<label class="suitImg" id="uploaderContainer">
					<span>点击上传图片</span>
					<input type="file" name="files[]" multiple data-url="<%=basePath%>/suit/uploadImg">
					<img src="" alt="衣服" id="suitImage">
				</label>
			</div>
			<div class="btnControl">
				<button class="save">保存</button>
				<button class="delete">删除</button>
			</div>
		</section>
	</main>
	</body>
<script type="text/javascript">
	function isAdmin() {
		return '${user.isAdmin}' === 'true';
	}
	$(document).ready(function () {
		if ( !isAdmin()){
			alert("您没有权限");
		}else {
			request("POST", "<%=basePath%>/suit/typeList", {}, typeInit, serverError, true);
		}
	});

	// 服饰类别初始化
	function typeInit(data) {
		isAdmin();
		const types = data.data;

		types.forEach((item) => {
			$('#type').append('<option value="' + item.code + '">' + item.name + '</option>');
			$('#addSuit select[name="type"]').append('<option value="' + item.code + '">' + item.name + '</option>');
			$('.suitDetailed select[name="type"]').append('<option value="' + item.code + '">' + item.name + '</option>');
		});
	}

	// 查询
	function query() {
		if ( !isAdmin()){
			alert("您没有权限");
			return;
		}
		const sex = $('#query select[name="sex"]').val();
		const type = $('#query select[name="type"]').val();

		if (sex === '请选择' && type === '请选择') {
			alert('请选择查询条件');
			return;
		}

		const suit = {
			sex: sex === "male",
			type: type
		};
		if (sex === '请选择') {
			request("POST", "<%=basePath%>/suit/suitListByType", suit, suitBlockInit, serverError, true);
		} else if (type === '请选择') {
			request("POST", "<%=basePath%>/suit/suitListBySex", suit, suitBlockInit, serverError, true);
		} else {
			request("POST", "<%=basePath%>/suit/suitList", suit, suitBlockInit, serverError, true);
		}
	}

	// 服饰块初始化
	function suitBlockInit(data) {
		if ( !isAdmin()){
			alert("您没有权限");
			return;
		}
		const template = $('#template');
		const mainInfo = $('#mainInfo');

		mainInfo.find('.suitDetailed').remove();
		const suitList = data.data;
		for (let i = 0; i < suitList.length; i++) {
			const suit = suitList[i];
			console.log(suit);
			const suitBlock = template.clone();
			suitBlock.attr('id', suit.id);
			suitBlock.find('input[name="code"]').val(suit.code);
			suitBlock.find('input[name="name"]').val(suit.name);
			suitBlock.find('input[name="price"]').val(suit.price);
			suitBlock.find('select[name="sex"]').val(suit.sex === true ? "male" : "female");
			suitBlock.find('select[name="type"]').val(suit.type);
			suitBlock.find('img').attr('src', "<%=basePath%>" + "/images/data/suits/" + suit.image);
			suitBlock.find(':file').attr('data-url', "<%=basePath%>/suit/uploadImg?suitCode=" + suit.code);

			suitBlock.find('.suitImg').click(function () {
				const urlPrefix = "<%=basePath%>" + "/images/data/suits/";
				uploadFileRequest(suitBlock, urlPrefix);
			});

			suitBlock.find('.save').click(function () {
				if ( !isAdmin()){
					alert("您没有权限");
					return;
				}
				const id = $(this).parent().parent().attr('id');
				const code = $(this).parent().parent().find('input[name="code"]').val().trim();
				const name = $(this).parent().parent().find('input[name="name"]').val().trim();
				const price = parseFloat($(this).parent().parent().find('input[name="price"]').val().trim());
				if (code === "" || name === "") {
					alert("请填写完整信息");
					return;
				}
				if (isNaN(price)) {
					alert("价格必须为数字");
					return;
				}
				const sex = $(this).parent().parent().find('select[name="sex"]').val() === "male";
				const type = $(this).parent().parent().find('select[name="type"]').val();

				const imgSrc = $(this).parent().parent().find('img').attr('src');
				const image = imgSrc.substr(imgSrc.indexOf("suits") + 6);
				const suit = {
					id: id,
					code: code,
					name: name,
					price: price,
					sex: sex,
					type: type,
					image: image
				};

				request("POST", "<%=basePath%>/suit/updateSuit", suit, query, serverError, true);

			});

			suitBlock.find('.delete').click(function () {
				if ( !isAdmin()){
					alert("您没有权限");
					return;
				}
				if (confirm("确定要删除 " + suit.name + " 吗？")) {
					request("POST", "<%=basePath%>/suit/deleteSuit", suit, (data) => {
						showMessage(data);
						// 重新查询
						request("POST", "<%=basePath%>/suit/suitList", query, serverError, true);
					}, serverError, true);
				}
			});

			suitBlock.show();
			mainInfo.append(suitBlock);
		}
	}

	// 添加服饰
	function addSuit() {
		if ( !isAdmin()){
			alert("您没有权限");
			return;
		}
		const suit = $('#mainInfo #addSuit');

		const code = suit.find('input[name="code"]').val().trim();
		const name = suit.find('input[name="name"]').val().trim();
		let price = parseFloat(suit.find('input[name="price"]').val().trim());
		if (code === "" || name === "") {
			alert("请填写完整信息");
			return;
		}
		if (isNaN(price)) {
			alert("价格必须为数字");
			return;
		}

		let sex = suit.find('select[name="sex"]').val();
		const type = suit.find('select[name="type"]').val();
		if (sex === "请选择" || type === "请选择") {
			alert("请选择性别和类别");
			return;
		}
		sex = sex === "male";

		const info = {
			code: code,
			name: name,
			price: price,
			sex: sex,
			type: type
		}
		request("POST", "<%=basePath%>/suit/addSuit", info, (data) => {
			showMessage(data);
			// 重新查询
			request("POST", "<%=basePath%>/suit/suitList", {
				sex: sex,
				type: type
			}, suitBlockInit, serverError, true);
		}, serverError, true);
	}

</script>
</html>

