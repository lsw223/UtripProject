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
	color:#eeeeee;
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
	z-index:3;
	border-bottom: 1px solid #e9e9e9;
	background-color: #2f3042;
}
header div:first-child{
	width:10%;
	float:left;
	font-size: 18px;
	padding:15px 0;
}
/****************************/
header>ul{
	display:block;
	width:45%;
	min-width:503px;
	float:left;
	list-style-type: none;
	box-sizing: border-box;
}
header li{
	width:100px;
	float:left;
	padding:15px 0;
}
header li a{
	font-size: 14px;
}
header>ul a:hover{
	color:rgba(255, 255, 255, 0.7);
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
	list-style-type: none;
	float:right;
	background-color: #f1f1f1;
	border-radius: 5px;
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
#user_dropdown a{
	color:black;
}
.hidden{
	display: none;
}
</style>

<!-- tablit, mobile -->
<style media="screen and (min-width:0) and (max-width:1024px)">
	header>ul{
		width:100%;
		display:none;
		height:270px;
		background-color: #2f3042;
		border-radius: 0 0 10px 10px;
	}
	header>ul li{
		width:100%;
		text-align: center;
	}
	#info{
		display: none;
		float:left;
		text-align: left;
		background-color: #2f3042;
	}
	header>div:first-of-type{
		width:100%;
		text-align: center;
	}
	#menu{
		display: block;
		float:right;
		position:absolute;
		top:13px;
		right:10px;
	}
	#btn_user{
		display: block;
		float:left;
		position:absolute;
		top:16px;
		left:10px;
	}
</style>
	
	
<body>
	<header>
		<div>
			<a href="#"  class="hidden" id="btn_user">
				<img alt="사용자 메뉴" src="img/user.png">
			</a>
			<a href="/">UTrip 관리자</a>
		</div>
		<a href="#" id="menu" class="hidden">
			<img alt="메뉴" src="img/menu_white.png">
		</a>
		<ul>
			<li><a href="adminnotice.do">공지사항</a></li>
			<li><a href="adminQna.do">QnA</a></li>
			<li><a href="tripView.do">여행정보</a></li>
			<li><a href="adminBoard.do">커뮤니티</a></li>
			<li><a href="hotelRequestAdminView.do">제휴관리</a></li>
		</ul>
		
		<!-- 로그인 된 상태일때  -->
		<div id="info">
			<p>
				<c:if test="${!empty sessionScope.login}">
					<a href="#" id="user">안녕하세요 관리자님!<img src="img/dropdown_white.png"></a>
				</c:if>
			<!-- 로그인 안된 상태일때  -->
				<c:if test="${empty sessionScope.login}">
					<a href="loginView.do">로그인/회원가입</a>
				</c:if>
			</p>
			<ul id="user_dropdown" class="hidden">
				<li><a href="infoUpdateView.do">정보변경</a></li>
				<li><a href="logout.do">로그아웃</a></li>
				<li><a href="#">내 보관함</a></li>
			</ul>
		</div>
	</header>
	
<script>
if(${sessionScope.user==null  || sessionScope.user.role!='ADMIN'}){
	location.href="/";
}

$("#user").click(function(){
	$("#user_dropdown").toggleClass("hidden");
})

$("#menu").click(function(e){
	e.preventDefault();
	$("#info").slideUp(400)
	$("header>ul").slideToggle(400)
})
$("#btn_user").click(function(e){
	e.preventDefault();
	$("header>ul").slideUp(400)
	$("#info").slideToggle(400)
})

$(window).resize(function(){
	if($(window).width() > 1026){
		$("header>ul").css({"display":"block"});
		$("#info").css({"display":"block"});
	}else{
		$("header>ul").css({"display":"none"});
		$("#info").css({"display":"none"});
	}
})

</script>
</body>
