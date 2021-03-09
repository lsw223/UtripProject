<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/area_view.css">
<link rel="stylesheet" href="css/area_view_tab.css" media="screen and (max-width:1024px)">
<title>지역별 여행정보 :: UTrip</title>
<script src="lib/jquery-3.5.1.min .js"></script>
<script>
if(${requestScope.list.size()==0}){
	alert("해당 지역은 준비된 투어가 아직 없습니다. 죄송합니다 ( _ _ )");
	history.back();
}
</script>
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
			<h2>${requestScope.list[0].area_name} 투어</h2>
		</div>
	<!-- 슬라이더 시작 -->
		<!-- prev 버튼 -->
 		<c:if test="${requestScope.list.size() > 3}">
			<a href="#" id="arrow_prev">
				<img src="img/arrow_white_left.png">
			</a>
		</c:if>
		<!-- 슬라이더 몸체 -->	
		<div class="for_slick single-item">
		<c:if test="${requestScope.list.size()>0}">
			<c:forEach var="i"  begin="0" end="${requestScope.list.size()-1}"   step="3">
				<div class="slide">
					<c:forEach var="j" begin="${i}" end="${i+2}">
					<c:if test="${j<=requestScope.list.size()-1}">
						<a href="tripDetailView.do?trip_no=${requestScope.list[j].trip_no}" class="trip">
							<img src="../img/trip/${requestScope.list[j].trip_no}.jpg">
							<div class="info">
								<small>${requestScope.list[j].area_name}</small><br>
								<span class="title">${requestScope.list[j].title }</span> <span class="rating">${requestScope.list[j].rating}</span><br>
								<span class="content">${requestScope.list[j].content }${dto.content }</span>
							</div>
						</a>
					</c:if>
					</c:forEach>
				</div>
			</c:forEach>
			</c:if>
		</div>
		<!-- next 버튼 -->
		<c:if test="${requestScope.list.size() > 3}">
			<a href="#" id="arrow_next">
				<img src="img/arrow_white.png">
			</a>
		</c:if>
		<!-- 슬라이더 끝 -->
	</div>
</body>
<%@include file="../template/footer.jsp"%>
<!-- slick 슬라이더 library -->
<script src="lib/slick.min.js"></script>
<link rel="stylesheet" href="css/slick.css">
<script>
$(function(){
	<!-- 슬라이더 설정 -->
	$('.single-item').slick({
		dots:false,
		speed:500,
		arrows:true,
		prevArrow: $('#arrow_prev'),
		nextArrow: $('#arrow_next')
	});
})
</script>
</html>