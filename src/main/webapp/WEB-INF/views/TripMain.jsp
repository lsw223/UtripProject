<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>당신의 여행 스타일 UTrip</title>
</head>
<c:choose>
	<c:when test="${sessionScope.user.role == 'ADMIN' }">
		<%@include file="template/header_admin.jsp" %>
	</c:when>
	<c:otherwise>
		<%@include file="template/header.jsp" %>
	</c:otherwise>
</c:choose>
<body>
<div id="container">
	<p id="top" >
		<span>어디로 떠나시겠습니까?</span>
	</p>
		<div class="card" id="KR" >
			<p class="area">대한민국</p>
			<a href="tripView.do">
				<img src="img/main/KR.jpg">
			</a>
		</div>
		<div class="card" id="SU" >
			<p class="area">서울</p>
			<a href="areaView.do?area=SU">
				<img src="img/main/SU.jpg">
			</a>
		</div>
		<div class="card" id="GG">
			<p class="area">경기</p>
			<a href="areaView.do?area=GG">
				<img src="img/main/GG.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">부산</p>
			<a href="areaView.do?area=BS">
				<img src="img/main/BS.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">인천</p>
			<a href="areaView.do?area=IC">
				<img src="img/main/IC.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">제주</p>
			<a href="areaView.do?area=JJ">
				<img src="img/main/JJ.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">대구</p>
			<a href="areaView.do?area=DG">
				<img src="img/main/DG.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">대전</p>
			<a href="areaView.do?area=DJ">
				<img src="img/main/DJ.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">울산</p>
			<a href="areaView.do?area=YS">
				<img src="img/main/YS.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">강원</p>
			<a href="areaView.do?area=KW">
				<img src="img/main/KW.png">
			</a>
		</div>
		<div class="card">
			<p class="area">충남</p>
			<a href="areaView.do?area=CN">
				<img src="img/main/CN.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">경북</p>
			<a href="areaView.do?area=KB">
				<img src="img/main/KB.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">경남</p>
			<a href="areaView.do?area=KN">
				<img src="img/main/KN.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">전북</p>
			<a href="areaView.do?area=JB">
				<img src="img/main/JB.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">전남</p>
			<a href="areaView.do?area=JN">
				<img src="img/main/JN.jpg">
			</a>
		</div>
		<div class="card">
			<p class="area">광주</p>
			<a href="areaView.do?area=GJ">
				<img src="img/main/GJ.jpg">
			</a>
		</div>
</div>


</body>
<%@ include file="template/footer.jsp" %>
<link rel="stylesheet" href="css/main.css">
</html>