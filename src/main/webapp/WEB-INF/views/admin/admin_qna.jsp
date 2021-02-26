<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 QnA :: UTrip</title>
<script src="lib/jquery-3.5.1.min .js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="css/admin_qna.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	<%@ include file="../template/header_admin.jsp"%>
	<div id="container">
		<table class="qna">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>날짜</th>
			</tr>
		<c:forEach var="dto" items="${requestScope.list }">
			<tbody id="result_search">
			<tr>
				<td>${dto.qna_no }</td>
				<td><a href="adminQnAView.do?qna_no=${dto.qna_no}">${dto.title }</a></td>
				<td>${dto.user_id }</td>
				<td>${dto.write_date }</td>
			</tr>
			</tbody>
		</c:forEach>
			<tr>
				<td colspan="6">
					<c:set var="page" value="${requestScope.page}" scope="page" />
					<c:if test="${pagging.previousPageGroup }">
						<a href="adminQna.do?pageNo=${pagging.startPageOfPageGroup-1}">◀</a>
					</c:if>
					<c:forEach var="i" begin="${pagging.startPageOfPageGroup }" end="${pagging.endPageOfPageGroup }">
						<a href="adminQna.do?pageNo=${i }">${i}</a>					
					</c:forEach>
					<c:if test="${pagging.nextPageGroup }">
						<a href="adminQna.do?pageNo=${pagging.endPageOfPageGroup+1}">▶</a>
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	<%@ include file="../template/footer.jsp"%>
</body>
</html>