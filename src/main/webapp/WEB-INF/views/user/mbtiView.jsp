<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="mbtiTest.do" method="post">
		<c:forEach var="list" items="${requestScope.list}">
			<div>
			<p>${list.mbti_no}번</p>
			<p>${list.mbti_text}</p>
			<script type="text/javascript">
			document.write("<input type='radio' name='${list.mbti_no}' value='"+1+"' checked>"+1+"점")
				for(i=2; i<6; i++){
					document.write("<input type='radio' name='${list.mbti_no}' value='"+i+"'>"+i+"점")					
				}
			</script>
			</div>
		</c:forEach>
		<button>검사하기</button>
	</form>
</body>
</html>