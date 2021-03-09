<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="/css/mbtiView.css">
<style>
	
</style>
<title>Insert title here</title>
</head>
<body>
	<form action="mbtiTest.do" method="post">
			<div class="container">
			<div class="row">
				<div class="col">
		<c:forEach var="list" items="${requestScope.list}">
			<p><strong>${list.mbti_no}번</strong></p>
			<p><strong>${list.mbti_text}</strong></p>
			<div class="btn-group btn-group-toggle" data-toggle="buttons">
			<script type="text/javascript">
			
			document.write("<label class='btn btn-danger'><input type='radio' name='${list.mbti_no}' id='jb-radio-1' value='"+1+"' checked>"+1+"점</label>")
				for(i=2; i<6; i++){
					document.write("<label class='btn btn-danger'><input type='radio' name='${list.mbti_no}' id='jb-radio-1' value='"+i+"'>"+i+"점</label>")					
				}
			</script>
			</div>
			<hr>
		</c:forEach>
			</div>
			</div>
			</div>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
		<button id="close" class="btn btn-danger">검사하기</button>
	</form>
</body>
</html>