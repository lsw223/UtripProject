<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오계정 연동 :: UTrip</title>
<link rel="stylesheet" href="css/kakaoRegisterView.css">
</head>
<body>
	<header>
		<a href="/">UTrip</a> 카카오 계정 연동
	</header>
		<section>
		<form action="kakaoRegister.do" id="frm_register" method="post">
			<p id="p_mbti">
			<small>MBTI</small><br>
				<select name="mbti" >
					<option value="INTP">INTP</option>
					<option value="ENTP">ENTP</option>
					<option value="ISTP">ISTP</option>
					<option value="INFP">INFP</option>
					<option value="INTJ">INTJ</option>
					<option value="ESTP">ESTP</option>
					<option value="ISFP">ISFP</option>
					<option value="INFP">INFP</option>
					<option value="ISFJ">ISFJ</option>
					<option value="ESFP">ESFP</option>
					<option value="ESTJ">ESTJ</option>
					<option value="ENFJ">ENFJ</option>
					<option value="ESFJ">ESFJ</option>
					<option value="ENTJ">ENTJ</option>
					<option value="ENFP">ENFP</option>
					<option value="ISTJ">ISTJ</option>
				</select>
				<small>
					 본인의 MBTI 타입을 모른다면?
					<a href="https://www.16personalities.com/ko/%EB%AC%B4%EB%A3%8C-%EC%84%B1%EA%B2%A9-%EC%9C%A0%ED%98%95-%EA%B2%80%EC%82%AC" target="_blank">클릭</a>
				</small> 
			</p>
			<button>회원가입</button>
		</form>
	</section>
</body>
</html>