<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 :: UTrip</title>
<link rel="stylesheet" href="css/registerView.css" >
<script src="lib/jquery-3.5.1.min .js"></script>
</head>
<body>
	<header>
		<a href="/">UTrip</a> 회원가입
	</header>
	<section>
		<form action="register.do" id="frm_register" method="post">
			<small>아이디</small><small id="id_alert" class="alert"></small>
			<p>
				<input type="text" name="id" id="id" maxlength="20">
			</p>
			<small>비밀번호</small><small id="pass_alert" class="alert"></small>
			<p>
				<input type="password" name="password" id="password" id="password" maxlength="20">
			</p>
			<small>비밀번호 확인</small><small id="pass2_alert" class="alert"></small>
			<p>
				<input type="password" name="password2" id="password2"maxlength="20">
			</p>
			<small>이름</small><small id="name_alert" class="alert"></small>
			<p>
				<input type="text" name="name" id="name" maxlength="10">
			</p>
			<small>이메일</small><small id="email_alert" class="alert" ></small><br>
			<p id="p_email">
				<input type="text" name="email" id="email" maxlength="20">
			</p>
			
			<p id="p_domain">
				<input type="text" value="@naver.com"  readonly>
				<select id="domain" name="domain">
					<option value="@naver.com">naver</option>
					<option value="@gmail.com">gmail</option>
					<option value="@daum.net">daum</option>
					<option value="@nate.com">nate</option>
					<option value="@hanmail.com">hanmail</option>
					<option value="self">직접입력</option>
				</select>
			</p>
			<p id="p_mbti">
			<small>MBTI</small><br><small id="mbti_alert" class="alert"></small>
				<select name="mbti" id="mbti">
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
					 자신의 MBTI 타입을 모른다면?
					<a href="#" onclick="window.open('mbtiTestView.do','mbti','width=500px, height=600px, left=0, top=0, resizable = no')">클릭</a>
				</small> 
			</p>
			<button type="button" id="btn_reg">회원가입</button>
		</form>
	</section>
	<script>
	// 아이디 길이, 중복 체크
	$("#id").keyup(function(){
		let id = $("#id").val();
		if(id.length < 4){
			$("#id_alert").text("아이디는 4자 이상 입니다.");
			$("#id_alert").removeClass("blue");
			$("#id_alert").addClass("red");
		}else{
			$.ajax({
				method:'get',
				url:"idCheck.do",
				data:{"id":id},
				dataType:'json',
				success:function(d){
					var resp=d.responseMessage;
					$("#id_alert").text(resp);
					if(d.responseCode==2){
						$("#id_alert").removeClass("red");
						$("#id_alert").addClass("blue");
					}else{
						$("#id_alert").removeClass("blue");
						$("#id_alert").addClass("red");
					}
				}
			})
		}
	})

	//비밀번호 확인 체크
	$("#password2").keyup(function(){
		if($("#password2").val()==$("#password").val()){
			$("#pass2_alert").text("비밀번호가 일치합니다");
			$("#pass2_alert").removeClass("red");
			$("#pass2_alert").addClass("blue");
		}else{
			$("#pass2_alert").text("비밀번호가 일치하지 않습니다");
			$("#pass2_alert").removeClass("blue");
			$("#pass2_alert").addClass("red");
		}
	})

	$("#btn_reg").click(function(){
		if($("#id").length==0||$("#password").length==0||$("#password2").length==0){
			alert("정보를 모두 입력하세요");
			return false;
		}
		if($("#id_alert").hasClass("red")){
			alert("아이디를 확인하세요");
			return false;
		}else if($("#pass2_alert").hasClass("red")){
			alert("비밀번호를 확인하세요");
			return false;
		}
		$("#frm_register").submit();
	})

	$("#p_domain select").change(function(){
		if($("#p_domain select").val() == "self"){
			$("#p_domain input").removeAttr("readonly");
			$("#p_domain input").val("@");
			$("#p_domain input").focus();
			return false;
		}
		$("#p_domain input").attr("readonly","readonly");
		$("#p_domain input").val($("#p_domain select").val());
	})
	</script>
</body>
</html>