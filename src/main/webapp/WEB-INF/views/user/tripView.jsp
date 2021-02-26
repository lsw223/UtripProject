<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="lib/jquery-3.5.1.min .js"></script>
<script src="lib/jquery-ui.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css">
<!-- <link rel="stylesheet" href="css/populTrip.css">
<style type="text/css">
	#container {
	padding-top:100px;
	height: 100%;
	/* background-color: lime; */
}

	
</style>
 -->
</head>

<body>
<%@ include file="../template/header.jsp"%>
  
	<div class="container">
	<div>
		<h2>인기 여행코스</h2>
	</div>
	<div class="total_check">
		<ul>
			<c:forEach var="list" items="${requestScope.list }">
			<li>
				<div class="photo">
					<a href="#">
					<span class="image">
						<a href="tripDetailView.do?trip_no=${list.trip_no }">
							<img alt="" src="/img/test.jpg">
						</a>
					</span>
					</a>
				</div>
				<div class="txt">
					<div><a href="tripDetailView.do?trip_no=${list.trip_no }"><h3>${list.title }</h3></a></div>
					<div>
						<p>${list.area_name }</p>
						<p>${list.content }
					</div>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>
	</div>
	<div>
	<div>
		<h2>MBTI에 맞는 추천 여행코스</h2>
	</div>
	<div class="total_check">
		<ul>
			<li>
				<div class="photo">
					<a href="#">
					<span class="image">
						<img alt="" src="/img/test.jpg">
					</span>
					</a>
				</div>
				<div class="txt">
					<div><a href="tripDetailView.do?trip_no=${dto.trip_no }"><h3>${dto.title }</h3></a></div>
					<div>
						<p>${dto.area_name }</p>
						<p>${dto.content }
					</div>
				</div>
			</li>
		</ul>
	</div>
	</div>
	<div class="container">
	<div>
		<h2>지역별 여행코스</h2>
	</div>
	<div class="total_check">
		<ul>
			<c:forEach var="areaList" items="${requestScope.areaList }">
			<li>
				<div class="photo">
					<a href="#">
					<span class="image">
						<a href="tripDetailView.do?trip_no=${areaList.trip_no }">
							<img alt="" src="/img/test.jpg">
						</a>
					</span>
					</a>
				</div>
				<div class="txt">
					<div><a href="tripDetailView.do?trip_no=${areaList.trip_no }"><h3>${areaList.title }</h3></a></div>
					<div>
						<p>${areaList.area_name }</p>
						<p>${areaList.content }
					</div>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>
	</div>
	<%@include file="../template/footer.jsp"%>
</body>
</html>