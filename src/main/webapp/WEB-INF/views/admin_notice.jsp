<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

</style>
<script src="lib/jquery-3.5.1.min .js"></script>
<script>
	
</script>

</head>
	<%@include file="template/header.jsp" %>
<body>
		<!-- header.jsp를 현재 문서에 포함 -->
		<div id="container">
		<table class="notice">
			<tr>
				<th class="notice_no">글번호</th>
				<th class="title">제목</th>
				<th class="nwriter">작성자</th>
				<th class="write_date">작성일</th>
			</tr>
	<!-- 게시판 기능 추가 기존 게시판에 있는 내용을 el과 jstl로 표현 -->
		<c:if test="${requestScope.list ==null}">
			<script>
				location.href="adminnotice.do?pageNo=1";
			</script>
		</c:if>
		<c:forEach var="dto" items="${requestScope.list }">
			<tr>
				<td>${dto.num }</td>
				<td><a href="adminnoticeView.do?notice_no=${dto.notice_no }"> ${dto.title }</a></td>
				<td>${dto.nwriter}</td>
				<td>${dto.write_date }</td>
			</tr>
		</c:forEach>
		   <tr>
			<td colspan="7">
					<div class="page_bar">
						<c:if test="${pagging.previousPageGroup }">
							<a href="adminnotice.do?pageNo=${pagging.startPageOfPageGroup - 1 }">◀</a>
						</c:if>
						<c:forEach var="i" begin="${pagging.startPageOfPageGroup}" end="${pagging.endPageOfPageGroup}">
							<a href="adminnotice.do?pageNo=${i }">${ i}</a>
						</c:forEach>
					
						<c:if test="${pagging.nextPageGroup }">
							<a href="adminnotice.do?pageNo=${pagging.endPageOfPageGroup + 1 }">▶</a>
						</c:if>
						<a href="adminnoticeWriteView.do" class="btn_writer">글쓰기</a>
					</div>
			</tr>
		</table>
	</div>
</body>
	<%@ include file="template/footer.jsp" %>
</html>