<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 페이지</title>
<link rel="stylesheet" href="css/board_write_view.css">
<script src="lib/jquery-3.5.1.min .js"></script>
</head>
<body>
	<%@ include file="../template/header.jsp"%>
	<c:if
		test="${sessionScope.login == null || sessionScope.login == false  }">
		<c:set var="page" target="${sessionScope }"
			value="${pageContext.request.requestURI}${pageContext.request.queryString }"
			property="resultPage" scope="session" />
		${pageContext.request.requestURI}${pageContext.request.queryString }
		<script>
			alert("로그인을 하셔야 이용할수 있습니다.");
			location.href = "loginView.do";
		</script>
	</c:if>

	<div id="container">
		<h2>글쓰기 페이지</h2>
		<form action="boardWriteAction.do" enctype="multipart/form-data"
			method="post">
			<table>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><input type="hidden" name="id" value="${sessionScope.user.id }">
						${sessionScope.user.id }</td>
				</tr>
				<tr>
					<th style="vertical-align: top;">내용</th>
					<td><textarea name="content"></textarea></td>
				</tr>
				<tr>
					<th><a
						href="board.do?pageNo=${requestScope.pageNo == null ? 1 : requestScope.pageNo }"
						class="btn">목록보기</a></th>
					<td style="text-align: right;"><a
						href="javascript:history.back();" class="btn">뒤로가기</a>
						<button class="btn">글쓰기</button></td>
				</tr>
			</table>
		</form>
	</div>
	<%@include file="../template/footer.jsp"%>
</body>
</html>