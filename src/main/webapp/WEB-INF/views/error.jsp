<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러 페이지 :: UTrip</title>
<style>
	#container{
		width:700px;
		border:2px solid #e8e8e8;
		margin:200px auto;
		text-align: center;
		height:500px;
		padding:30px;
	}
	img{
		margin-top:50px;
	}
	h3{
		color:#78c1ee;
	}
	a{
		text-decoration: none;
		color:gray;
	}
	.button{
		padding:10px 15px;
		border:1px solid gray;
		display:inline-block;
		margin:30px 10px;
	}
	.button:hover{
		border:1px solid black;
	}
</style>
</head>
<body>
	<div id="container">
		<img src="img/error.png">
		<h3>죄송합니다 에러가 발생했습니다.</h3>
		<p>
			신속히 문제점을 찾아서 보완하겠습니다<br>
			감사합니다.
		</p>
		<a href="/" class="button">메인으로</a>
		<a href="#" class="button" onclick="history.back()">이전 페이지</a>
	</div>
</body>
</html>