<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/notice/notice_update_view.css">
<script src="lib/jquery-3.5.1.min .js"></script>
<script>
	$(function(){
		var count = 3;//첨부파일 태그 개수
		$("#plus").click(function(){
			if(count == 5) return;
			count++;
			$("#file_form").append("<p><input type='file' name='file'></p>");
		});
		$("#minus").click(function(){
			if(count == 1) return;
				$(this).parent().parent().children("p").last().remove();
			count--;
		});
	});
</script>
	<%@include file="../template/header_admin.jsp" %>
</head>
<body>
	<div id="container">
		<div id="container">
			<h2>글수정 페이지</h2>
			<form action="noticeUpdateAction.do" enctype="multipart/form-data" method="post">
				<input type="hidden" name="notice_no"	value="${requestScope.detail.notice_no }">
				<input type="hidden" name="nno" 		value="${requestScope.file[0].nno }">
				<table>
					<tr>
						<th>제목</th>
						<td><input type="text" name="title" value="${requestScope.detail.title }"></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>
							${requestScope.detail.nwriter }		
						</td>
					</tr>
					<tr>
						<th style="vertical-align: top;">내용</th><td><textarea name="content">${requestScope.detail.content}</textarea></td>
					</tr>
					<!-- 첨부 파일 -->
					<tr>
						<th></th>
						<td colspan="2" id="file_form">
							<p><input type="file" name="file"> 
							<button type="button" id="plus">+</button> <button type="button" id="minus">-</button></p>
							<p><input type="file" name="file"></p>
							<p><input type="file" name="file"></p>
						</td>
					</tr>
					<tr>
						<th><a href="adminnotice.do?pageNo=${requestScope.pageNo == null ? 1 : requestScope.pageNo }" class="btn">목록보기</a></th>
						<td style="text-align: right;">
							<a href="javascript:history.back();" class="btn">뒤로가기</a>
							<button class="btn">수정하기</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
	<%@ include file="../template/footer.jsp" %>
</html>