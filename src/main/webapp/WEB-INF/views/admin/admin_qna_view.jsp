<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 QnA :: UTrip</title>
<link rel="stylesheet" href="css/admin_qna_view.css">
<script src="lib/jquery-3.5.1.min .js"></script>
</head>
<body>
	<%@include file="../template/header_admin.jsp"%>
	<div id="container">
		<div id="top">
			<p id="p_1">
				<img id="img_1" src="img/qna_img.png" width="90" height="90"><span
					id="sp_1" style="display: inline-block; height: 90px;">QnA</span><span
					id="sp_2">문의사항 전체 조회</span>
			</p>
		</div>
		<hr class="h_1">
		<a href="qnaFaqView.do" id="btn_faq_view" class="button">>자주 묻는 질문
			보러가기</a>
		<hr class="h_2">
		<div id="select_qna">
			<h2 class="qna_title">
				<ul>
					<li>제목 <span>${requestScope.dto.title }</span></li>
					<li>작성자 <span>${requestScope.dto.user_id }</span></li>
					<li>작성일 <span>${requestScope.dto.write_date }</span></li>
					<li>문의 내용</li>
				</ul>
			</h2>
			<div id="qna_content_div">
				<p class="qna_content"><span>${requestScope.dto.content }</span></p>
			</div>
			<hr>
			<div id="response_form">
				<form action="insertResponse.do">
					<input type="hidden" name="qna_no"
						value="${requestScope.dto.qna_no }">
					<c:if test="${response.response_content == null}">
						<table id="response_table">
							<tr>
								<td><textarea name="response_content" id="response_content"
										placeholder="답변 내용을 입력해 주세요"></textarea></td>
								<td>
									<button id="btn_response">등록</button>
								</td>
							</tr>
						</table>
					</c:if>
					<table id="response">
						<c:choose>
							<c:when test="${response.response_content ==null }">
								<p>
									<span id="response_yet">현재 답변이 완료되지 않았습니다</span>
								</p>
							</c:when>
							<c:otherwise>
								<tr>
									<td id="A"><span id="A_1">A.</span>${response.response_content }</td>
								</tr>
								<tr>
									<td id="response_date">${response.response_date}</td>
								</tr>
								<tr>
									<td><a href="deleteResponse.do?qna_no=${response.qna_no }"
										id="btn_delete" class="btn">삭제</a></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</form>
			</div>
		</div>
	</div>
	<%@include file="../template/footer.jsp"%>
</body>
<script>
	$("#btn_response").click(function() {
		var qna_no = $("#qna_no").val();
		var response_content = $("#response_content").val();
		if (qna_no.length == 0) {
			alert("문의 번호를 입력하세요");
			return false;
		}
		if (response_content.length == 0) {
			alert("답변을 입력하세요");
			return false;
		}
		var data = {
			"qna_no" : qna_no,
			"response_content" : response_content
		}

	})
</script>
</html>