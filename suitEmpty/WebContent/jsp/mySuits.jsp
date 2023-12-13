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
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/mySuits.css" />
		<title>mySuits</title>
	</head>

	<body>
	<main id="mySuits">
		<section id="display">

			<section id="modelDisplay">
				<img src="../images/data/model/mheadAModel.png" alt="" id="model">
			</section>

			<section id="sumPrice">
				<span>总价：</span>
				<span id="price">0</span>
			</section>
		</section>
		<nav id="addSuits">
			<label id="querySuits">
				<span>选择分类：</span>
				<select name="suitType" id="suitType" onclick="query()">
					<option>请选择</option>
				</select>
			</label>
			<section id="toBeSelectedSuits">

			</section>
		</nav>
	</main>

	<section class="selectedSuit" id="selectedTemplate" style="display: none">
		<div>
			<p>编号：</p>
			<span class="code">wA</span>
		</div>
		<div>
			<p>名称：</p>
			<span class="name">西装</span>
		</div>
		<div>
			<p>价格：</p>
			<span class="price">1000</span>
		</div>
		<div class="control">
                    <span>
                        <img src="../images/ui/zIndex.png" alt="图层">
                        <p class="zIndex">1</p>
                    </span>
			<img src="../images/ui/up.png" alt="穿上" class="up">
			<img src="../images/ui/down.png" alt="脱下" class="down">
			<img src="../images/ui/remove.png" alt="取消购买" class="delete">
		</div>
	</section>

	<section class="selectingSuit" id="selectingTemplate"style="display: none">
		<div class="addToModel">
			<div></div>
			<div></div>
		</div>
		<img src="../images/data/suits/mShirt02.png" alt="">
		<hr>
		<div>
			<p>编号：</p>
			<span class="code">wA</span>
		</div>
		<div>
			<p>名称：</p>
			<span class="name">西装</span>
		</div>
		<div>
			<p>价格：</p>
			<span class="price">1000</span>
		</div>
	</section>
	</body>
<script src="<%=basePath%>/js/jquery-3.3.1.js"></script>
<script src="<%=basePath%>/js/main.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		$('#modelDisplay #model').attr('src','../images/data/model/' + '${user.model}');
		request("POST", "<%=basePath%>/suit/typeList", {}, typeInit, serverError, true);
		request("POST", "<%=basePath%>/suit/mySuitList", {}, mySuitsInit, serverError, true);
	});

	function query() {
		const type = $('#suitType').val();
		if (type === "请选择") {
			return;
		}
		const suit = {
			sex: '${user.sex}',
			type: type
		};
		request("POST", "<%=basePath%>/suit/suitList", suit, querySuccess, serverError, true);
	}

	function querySuccess(data) {
		const suitList = data.data;
		$("#toBeSelectedSuits").empty();
		suitList.forEach(function (item) {
			const suitBlock = $("#selectingTemplate").clone();
			suitBlock.attr("id", item.code);
			suitBlock.find(".code").text(item.code);
			suitBlock.find(".name").text(item.name);
			suitBlock.find(".price").text("￥" + parseFloat(item.price).toFixed(2));
			suitBlock.find("img").attr("src", "../images/data/suits/" + item.image);
			suitBlock.find(".addToModel").click(function () {
				const suit = {
					codeSuit: item.code,
					username: '${user.username}',
					zIndex: 0
				};
				request("POST", "<%=basePath%>/suit/addMySuit", suit, (data) => {
					successCallBack(data);
					if (data.code === 10) {
						request("POST", "<%=basePath%>/suit/mySuitList", {}, mySuitsInit, serverError, true);
					}
				}, serverError, true);
			});
			suitBlock.show();
			$("#toBeSelectedSuits").append(suitBlock);
		});

	}

	function typeInit(data) {
		const typeList = data.data;
		typeList.forEach(function (item) {
			$("#suitType").append('<option value="' + item.code + '">' + item.name + '</option>');
		});
	}

	function mySuitsInit(data) {
			const mySuitList = data.data;
			$("#display").find(".selectedSuit").remove();
			$("#modelDisplay").find(".suit").remove();

			let price = 0;
			mySuitList.forEach(function (item) {
				const suitBlock = $("#selectedTemplate").clone();
				suitBlock.attr("id", item.code);
				suitBlock.find(".code").text(item.code);
				suitBlock.find(".name").text(item.name);
				suitBlock.find(".price").text("￥" + parseFloat(item.price).toFixed(2));
				price += item.price;
				setZIndex(suitBlock, item);

				suitBlock.find(".up").click(function () {
					item.zIndex++;
					request("POST", "<%=basePath%>/suit/updateMySuit", item, ()=>{
						setZIndex(suitBlock, item);
					}, serverError, true);
				});

				suitBlock.find(".down").click(function () {
					item.zIndex--;
					request("POST", "<%=basePath%>/suit/updateMySuit", item, ()=>{
						setZIndex(suitBlock, item);
					}, serverError, true);
				});

				suitBlock.find(".delete").click(function () {
					if (confirm("确定要删除 " + item.name + " 吗？")) {
						request("POST", "<%=basePath%>/suit/deleteMySuit", item, (data)=>{
							successCallBack(data);
							request("POST", "<%=basePath%>/suit/mySuitList", {}, mySuitsInit, serverError, true);
						}, serverError, true);
					}
			});
			suitBlock.show();
			$("#display").append(suitBlock);
		});
		$("#price").text("￥" + parseFloat(price).toFixed(2));
	}

	function setZIndex(suitBlock, item) {
		suitBlock.find(".zIndex").text(item.zIndex);
		const modelDisplay = $('#modelDisplay');
		if ((modelDisplay.find('.' + item.codeSuit).length) === 0) {
			modelDisplay.append('<img src="../images/data/suits/' + item.image + '" alt="" class="suit ' + item.codeSuit + '" style="z-index: ' + item.zIndex + '">');
		} else {
			modelDisplay.find('.' + item.codeSuit).css("z-index", item.zIndex);
		}
	}

	function successCallBack(data) {
		showMessage(data);
	}
</script>
</html>