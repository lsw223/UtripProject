<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>당신의 여행 스타일 UTrip</title>
</head>
<c:choose>
	<c:when test="${sessionScope.user.role == 'ADMIN' }">
		<%@include file="template/header_admin.jsp" %>
	</c:when>
	<c:otherwise>
		<%@include file="template/header.jsp" %>
	</c:otherwise>
</c:choose>
<body>
</body>
<%@ include file="template/footer.jsp" %>
<link rel="stylesheet" href="css/main.css">
</html>