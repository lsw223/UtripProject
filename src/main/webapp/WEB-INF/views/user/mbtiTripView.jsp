<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="lib/jquery-3.5.1.min .js"></script>
<link rel="stylesheet" href="css/tripView.css">
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
					<small>UTrip 투어</small>
					<h2>${sessionScope.user.mbti} 추천 투어</h2>
		<c:choose>
			<c:when test="${sessionScope.user.role == 'ADMIN' }">
				<button onclick="javascript:location.href='/tripInsertView.do';">여행정보
					추가</button>
			</c:when>
		</c:choose>
				<button onclick="javascript:location.href='/tripView.do';">인기 여행정보 확인</button>
			</div>
			<div class="for_slick single-item">
				<c:forEach var="list" items="${requestScope.list }">
						<div class="slide">
							<a href="tripDetailView.do?trip_no=${list.trip_no }" class="trip"> 
							<img alt="" src="/img/trip/${list.trip_no}.jpg">
							
							<div class="info">
								<small>${list.area_name}</small><br>
								<span class="title">${list.title }</span> <span class="rating">${list.rating}</span><br>
								<span class="content">${list.content}</span>
							</div>								
							</a>
						</div>
				</c:forEach>
			</div>
	</div>
</body>
<%@include file="../template/footer.jsp"%>
</html>