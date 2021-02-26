/**
 * 회원가입
 */


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






