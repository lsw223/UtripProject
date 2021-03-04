<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="lib/jquery-3.5.1.min .js"></script>
<script src="lib/jquery-ui.js"></script>
<link rel="stylesheet" href="css/qna_faq_view.css">
<title>자주 묻는 질문 :: UTrip</title>
<style>
#container {
	margin: 0 auto;
	width: 80%;
	min-width: 1100px;
	min-height: 500px;
	padding-top: 100px;
}

#top {
	height: 100px;
	box-sizing: border-box;
}

#p_1 {
	position: absolute;
	left: 170px;
	width: 400px;
	box-sizing: border-box;
}

#sp_1 {
	width: 160px;
	font-size: 70px;
	box-sizing: border-box;
	text-align: center;
}

#sp_2 {
	position: absolute;
	width: 140px;
	font-size: 20px;
	color: #969696;
	font-weight: bold;
	box-sizing: border-box;
	text-align: center;
	top: 55px;
}

.h_1 {
	border: 0;
	height: 5px;
	background: #1E3269;
	margin-bottom: 60px;
}

#faq {
	margin-bottom: 200px;
}

.accordion {
	background-color: #eee;
	color: #444;
	cursor: pointer;
	padding: 18px;
	width: 100%;
	text-align: left;
	border: none;
	outline: none;
	transition: 0.4s;
}

.active, .accordion:hover {
	background-color: #ccc;
}

.panel {
	padding: 0 18px;
	background-color: white;
	display: none;
	overflow: hidden;
	height: 50px;
	padding-top: 23px;
	border: 1px solid #dcdcdc;
}
</style>
</head>
<c:choose>
	<c:when test="${sessionScope.user.role == 'ADMIN' }">
		<%@include file="../template/header_admin.jsp"%>
	</c:when>
	<c:otherwise>
		<%@include file="../template/header.jsp"%>
	</c:otherwise>
</c:choose>
<body>
	<div id="container">
		<div id="top">
			<p id="p_1">
				<img id="img_1" src="img/qna_img.png" width="90" height="90"><span
					id="sp_1" style="display: inline-block; height: 90px;">FAQ</span><span
					id="sp_2">자주 묻는 질문</span>
			</p>
		</div>
		<hr class="h_1">
		<div id="faq">
			<button class="accordion">
				<strong>Q.</strong> Mbti 설정을 변경하고 싶어요.
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> '정보 변경'에서 변경하실 수 있습니다.
				</p>
			</div>
			<button class="accordion">
				<strong>Q.</strong> 계정을 탈퇴하고 싶어요.
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> '정보 변경'에서 변경하실 수 있습니다.
				</p>
			</div>
			<button class="accordion">
				<strong>Q.</strong> 문의 등록은 못하나요?
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> 회원가입 후 로그인 하시면 메뉴 QnA에서 문의 하실 수 있습니다.
				</p>
			</div>
			<button class="accordion">
				<strong>Q.</strong> 호텔 제휴신청 승인기간은 얼마나 걸리나요?
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> 18:00~ 이후 신청시 다음날 18:00시 내에 승인됩니다.
				</p>
			</div>
			<button class="accordion">
				<strong>Q.</strong> QnA 답변은 얼마나 걸릴까요?
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> 최소 1~2일 정도 소요됩니다.
				</p>
			</div>
		</div>
	</div>
</body>
<%@include file="../template/footer.jsp"%>
<script>
	var acc = document.getElementsByClassName("accordion");
	var i;
	for (i = 0; i < acc.length; i++) {
		acc[i].addEventListener("click", function() {
			this.classList.toggle("active");
			var panel = this.nextElementSibling;
			if (panel.style.display === "block") {
				panel.style.display = "none";
			} else {
				panel.style.display = "block";
			}
		});
	}
</script>
</html>

