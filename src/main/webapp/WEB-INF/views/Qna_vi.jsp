<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="lib/jquery-3.5.1.min .js"></script>
<script>
  $( function() {
    $( "#accordion" ).accordion();
  } );
  </script>
</head>
<body>
	
	<div id="accordion">
	<c:forEach var = "dto" items="${requestScope.list }">
	  <h3>${dto.title}</h3>
	  <div>
	  	<c:if test="${dto.responseContent!=null}">
	    <p>
	    	${dto.responseContent}
	    </p>
	    </c:if>
	  </div>
	</c:forEach> 
  
</div> 
	
</body>
</html>