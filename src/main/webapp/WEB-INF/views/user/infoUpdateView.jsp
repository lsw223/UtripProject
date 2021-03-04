<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 변경 :: UTrip</title>
<link rel="stylesheet" href="css/infoChangeView.css">
<script src="lib/jquery-3.5.1.min .js"></script>
<script>
	$(function(){
		for(i=0; i<16; i++){
			var mbti = $("option").eq(i).val();
			if(mbti == '${sessionScope.user.mbti}'){
				$("option").eq(i).attr("selected","true");
			}
		}
		$("#btn2").click(function(){
			if(${empty sessionScope.user}){
				alert("로그인이 필요한 작업입니다.");
				location.href="loginView.do";
				return false;
			}
			var data = {"name" :$("#name").val(),"email":$("#email").val(),"mbti":$("#mbti").val()};
			$.ajax({
				method:"post",
				url:"infoUpdate.do",
				data:JSON.stringify(data),
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				success:function(d){
					alert(d.responseMessage);
				}
			})			
		})
		$("#btn1").click(function(){
			if(${empty sessionScope.user}){
				location.href="/";
				return false;
			}
			var result = confirm("정말 탈퇴 하시겠습니까?");
			if(result){
				alert("계정이 삭제되었습니다");
				location.href="withdraw.do";
			}
		})
	})
</script>
</head>
<body>
	<%@include file="../template/header.jsp"%>
	<div id="container">
		<div id="user_info">
			<p>계정정보</p>
			<table>
				<tr>
					<td>이름</td>
					<td><input type="text" id="name"value="${sessionScope.user.name }" ></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" id="email"value="${sessionScope.user.email }" ></td>
				</tr>
				<tr>
					<td>MBTI</td>
					<td><select name="mbti" id="mbti">
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
					</select></td>
				</tr>
			</table>
			<p id="btns">
				<a id="btn1" href="#" >계정탈퇴</a>
				<a id="btn2" href="#">저장</a>
			</p>
		</div>
	</div>
	<%@include file="../template/footer.jsp" %>
</body>
</html>