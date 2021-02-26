<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 QnA :: UTrip</title>
<link rel="stylesheet" href="css/admin_qna_view.css">
<script src="lib/jquery-3.5.1.min .js"></script>
</head>
<body>
	<jsp:include page="../template/header.jsp"></jsp:include>
	<div id="container">
		<h3 class="qna_title">
				<ul>
					<li>제목 : ${requestScope.dto.title }</li>
					<li>작성자 : ${requestScope.dto.user_id }</li>
					<li>작성일 : ${requestScope.dto.write_date }  </li>
				</ul>
				</h3>
				<div>
					<p><b>문의내용</b></p>
					<p class="qna_content">${requestScope.dto.content }</p>
				</div>
		<hr>
		<div id="response_form">
			<form id="response">
							<input type="hidden" name="qna_no" value="${requestScope.dto.qna_no }"> 
				<table>
					<tr>
						<td>
							<textarea name="response_content" placeholder="답변 내용을 입력해 주세요">${requestScope.dto.response_content}</textarea>
						</td>
						<td>
						<button id="response.do">답변하기</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<jsp:include page="../template/footer.jsp"></jsp:include>
</body>
</html>