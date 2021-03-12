<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 페이지</title>
<link rel="stylesheet" href="css/board_write_view.css">
<link rel="stylesheet" media="(max-width:480px)" href="css/mobile_board_write_view.css"/>
<script src="lib/jquery-3.5.1.min .js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>
</head>
<body>
	<%@ include file="../template/header.jsp"%>
	<c:if
		test="${sessionScope.user.id != requestScope.board.id || sessionScope.login == false || sessionScope.login == null }">
		<c:set var="page" target="${sessionScope }"
			value="${pageContext.request.requestURI}${pageContext.request.queryString }"
			property="resultPage" scope="session" />
		${pageContext.request.requestURI}${pageContext.request.queryString }
		<script>
			alert("작성자만 수정 할 수 있습니다.");
			location.href = "javascript:history.back()";
		</script>
	</c:if>


	<div id="container">
		<h2>커뮤니티 글 수정</h2>
		<form action="updateBoard.do" enctype="multipart/form-data"
			method="post">
			<table>
				<tr>
					<td colspan="2"><input type="hidden" name="id"
						value="${requestScope.board.id }"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" name="title"
						value="${requestScope.board.title }">
						<input type="hidden" name="boardno"
						value="${requestScope.board.boardNo }"></td>
				</tr>
				<tr>
					<td colspan="2"><textarea name="content" id="content">${requestScope.board.content }</textarea></td>
				</tr>
				<tr>
					<td><a
						href="board.do?pageNo=${requestScope.pageNo == null ? 1 : requestScope.pageNo }"
						class="btn">목록보기</a></td>
					<td style="text-align: right;"><a
						href="javascript:history.back();" class="btn">뒤로가기</a>
						<button class="btn">수정하기</button></td>
				</tr>
			</table>
		</form>
		<script>
	    ClassicEditor
	        .create( document.querySelector( '#content' ) )
	        .catch( error => {
	            console.error( error );
	        });
		</script>
	</div>
	<%@include file="../template/footer.jsp"%>
</body>
</html>