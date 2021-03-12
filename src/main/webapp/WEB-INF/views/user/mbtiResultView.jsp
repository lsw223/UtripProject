<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="lib/jquery-3.5.1.min .js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		var mbti = $("#result").val();
		$("#close").click(function(e){
			$(opener.document).find("#mbti").val(mbti).attr("selected", "selected");
			window.close();
		});
	})
	
</script>
</head>
<body>
	<div class="container">
	<p><strong>MBTI 검사 결과는</strong></p>
	<p><strong>${requestScope.mbti } 입니다.</strong></p>
	<input type="hidden" id="result" value="${requestScope.mbti}">
	<input type="button" value="검사종료" class="btn btn-danger" id="close">
	</div>
</body>
</html>