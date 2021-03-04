<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 :: UTrip</title>
<link rel="stylesheet" href="css/loginView.css">
</head>
<body>
	<div id="login">
		<p>
			<span id="logo"><a href="/">UTrip</a></span><br>
			<small>find your trip</small>
		</p>
		<form action="login.do"  method="post" >
			<p>
				<input type="text" id="id" name="id" placeholder="아이디" >
			</p>
			<p>
				<input type="password" id="password" name="password" placeholder="비밀번호" >
			</p>
			<button id="btn_login">로그인</button>
			<button type="button" id="btn_register" onclick="location.href='registerView.do'">회원가입</button>
			<a href="https://kauth.kakao.com/oauth/authorize?
							client_id=38ad5f7eaf5e40dc6b4d7274dabc0268
							&redirect_uri=http://nam2626.synology.me:32772/kakaoLogin.do  
							&response_type=code&prompt=login">
				<img src="img/kakao_login_medium_wide.png">
			</a>
		</form>
		
	</div>
</body>
</html>