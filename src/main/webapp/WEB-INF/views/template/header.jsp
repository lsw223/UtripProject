<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="lib/jquery-3.5.1.min .js"></script>
<style>
 @font-face { 
	font-family: 'Noto Sans KR'; 
	font-weight:normal;
	font-style:normal;
	src: 'url(/font/NotoSansKR-Bold.otf) format('truetype'); 
} 
*{
	font-family: 'Noto Sans KR';
	padding:0;
	margin:0;
	color:#121212;
}
header a:link,a:visited{
	text-decoration: none;
	color:black;
	transition: all 0.1s;
}
/*****************************/
header{
	font-weight:bold;
	text-align: center;
	height:55px;
	transition:all 0.3s;
	position:relative;
	width:100%;
	min-width: 1200px;
	z-index:3;
	border-bottom: 1px solid #e9e9e9;
	background-color: white;
}
header div:first-child{
	width:10%;
	float:left;
	font-size: 18px;
	padding:15px 0;
}
/****************************/
header ul{
	width:45%;
	float:left;
	list-style-type: none;
}
header li{
	width:100px;
	float:left;
	padding:15px 0;
}
header li a{
	font-size: 14px;
}
/****************************/
#info{
	width:45%;
	float:right;
	padding:15px 25px;
	box-sizing:border-box;
	text-align: right;
}
#info ul{
	float:right;
	background-color: #f1f1f1;
	border-radius: 5px;
	display: none;
	width:200px;
}
header #info li{
	border-top: 1px solid #e8e8e8;
	border-bottom: 1px solid #e8e8e8;
	width:100%;
	text-align: left;
	padding:5px;
	box-sizing: border-box;
}
#info img{
	width:14px;
}
</style>
<script>
	$(function(){
		$("#user").click(function(){
			$("#user_dropdown").slideToggle(400);
		})
	})
</script>
<body>
	<header>
		<div>
			<a href="/">UTrip</a>
		</div>
		<ul>
			<li><a href="adminnotice.do">공지사항</a></li> <!-- 임시 -->
			<li><a href="qna.do">QnA</a></li>
			<li><a href="tripView.do">여행정보</a></li>
			<li><a href="board.do">커뮤니티</a></li>
			<li><a href="hotelRequestView.do">제휴신청</a></li>
		</ul>
		
		<!-- 로그인 된 상태일때  -->
		<div id="info">
			<p>
				<c:if test="${!empty sessionScope.login}">
					<a href="#" id="user">안녕하세요 ${sessionScope.user.name }님!<img src="img/dropdown.png"></a>
				</c:if>
			<!-- 로그인 안된 상태일때  -->
				<c:if test="${empty sessionScope.login}">
					<a href="loginView.do">로그인/회원가입</a>
				</c:if>
			</p>
			<ul id="user_dropdown">
				<li><a href="infoUpdateView.do">정보변경</a></li>
				<li><a href="logout.do">로그아웃</a></li>
				<li><a href="#">내 보관함</a></li>
			</ul>
		</div>
	</header>
	
</body>
