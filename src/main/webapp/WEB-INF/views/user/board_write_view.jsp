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
<%-- <script src="<%=ctx%>/vendor/ckeditor/ckfinder/ckfinder.js"></script> --%>
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
		<h2>커뮤니티 글쓰기</h2>
		<form action="boardWriteAction.do" enctype="multipart/form-data"
			method="post">
			<table>
				<tr>
					<td><input type="hidden" name="id" value="${sessionScope.user.id }"></td>
				</tr>
				<tr>
					<td><input type="text" name="title" id="title" placeholder="제목을 입력하세요"></td>
				</tr>
				<tr>
					<td><textarea name="content" id="content" placeholder="내용을 입력하세요"></textarea></td>
				</tr>
				<tr>
					<td><a href="board.do?pageNo=${requestScope.pageNo == null ? 1 : requestScope.pageNo }"
						class="btn">목록보기</a>
						<a href="javascript:history.back();" class="btn" style="float : right;">뒤로가기</a>
						<button class="btn" id="write_btn" style="float : right;">글쓰기</button></td>
				</tr>
			</table>
		</form>
		<script>
	    ClassicEditor
	        .create( document.querySelector( '#content' ) , {
	        	toolbar: [ 'heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|', 'blockQuote','insertTable','|','undo',
	        		'redo'],
	    	} )
	    	.catch( error => {
	    	    console.error( error );
	    	} );
		 $("#write_btn").click(function() {
			 if($("#title").val()==""){
				 alert("제목을 입력해주십시오")
				 $("#title").focus();
				 return false;
			 }
			 if($(".ck ck-editor__main").val()==""){
				 alert("내용을 입력해주십시오")
				 $("#content").focus();
				 return false;
			 }
		});
		</script>
	</div>
	<%@include file="../template/footer.jsp"%>
</body>
</html>