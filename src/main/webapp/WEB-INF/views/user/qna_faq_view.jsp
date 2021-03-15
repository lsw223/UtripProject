<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width">
<script src="lib/jquery-3.5.1.min .js"></script>
<script src="lib/jquery-ui.js"></script>
<link rel="stylesheet" href="css/qna_faq_view.css">
<title>자주 묻는 질문 :: UTrip</title>
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
					<strong>A.</strong> '정보 변경'에서 하실 수 있습니다.
				</p>
			</div>
			<button class="accordion">
				<strong>Q.</strong> 문의 등록은 못하나요?
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> 로그인 후 QnA에서 문의 하실 수 있습니다.
				</p>
			</div>
			<button class="accordion">
				<strong>Q.</strong> 호텔 제휴신청 승인기간은 얼마나 걸리나요?
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> 18:00시~ 이후의 신청은 다음날 18:00시 내에 승인됩니다.
				</p>
			</div>
			<button class="accordion">
				<strong>Q.</strong> QnA 답변은 얼마나 걸리나요?
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> 최소 1~2일 정도 소요됩니다.
				</p>
			</div>
			<button class="accordion">
				<strong>Q.</strong> 이메일을 변경하고 싶어요.
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> '정보 변경'에서 변경하실 수 있습니다.
				</p>
			</div>
			<button class="accordion">
				<strong>Q.</strong> 개명 했을 시에 어떻게 해야하나요? 
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> 이름의 경우에는 별도의 인증 절차가 없으며 '정보 변경'에서 제한 없이 변경하실 수 있습니다.
				</p>
			</div>
			<button class="accordion">
				<strong>Q.</strong> 활동 랭킹의 기준이 무엇인가요?
			</button>
			<div class="panel">
				<p>
					<strong>A.</strong> 게시글과 댓글의 작성을 기준으로 순위를 나타냅니다.
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

