<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width">
<script src="lib/jquery-3.5.1.min .js"></script>
<title>QnA :: UTrip</title>
</head>
<link rel="stylesheet" href="css/qna_view.css">
<%@include file="../template/header.jsp"%>
<body>
	<div id="container">
		<div id="top">
			<p id="p_1">
				<img id="img_1" src="img/qna_img.png" width="90" height="90"><span
					id="sp_1" style="display: inline-block; height: 90px;">QnA</span><span
					id="sp_2">문의사항</span>
			</p>
		</div>
		<div id="faq_div">
			<a href="qnaFaqView.do" id="btn_faq_view" class="button">>자주 묻는
				질문 보러가기</a>
		</div>
		<c:if test="${requestScope.list == null}">
			<div id="not_login">
				<img id="img_2" src="img/qna_img_2.png"> <span id="sp_3">문의는
					로그인 후 이용 가능합니다.</span>
			</div>
		</c:if>
		<c:if test="${requestScope.list != null}">
			<form id="sendQnA" action="sendQnA.do">
				<h1>문의하기</h1>
				<table id="table_qna">
					<tr>
						<th>제목</th>
						<td><input type="text" name="title" id="title"
							placeholder="한글 최대 20자"></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td><input type="hidden" name="user_id" id="user_id"
							value="${sessionScope.user.id}"> ${sessionScope.user.id}</td>
					</tr>
					<tr>
						<th style="vertical-align: top;">내용</th>
						<td><textarea name="content" id="content"
								placeholder="한글 최대 500자"></textarea></td>
					</tr>
					<tr>
						<th id="th_1"></th>
						<td id="td_btn" style="text-align: right;"><button
								id="btn_submit">등록</button>
					</tr>
				</table>
			</form>
			<div id="MY">
				<h1>MY 문의</h1>
			</div>
			<div id="qna_list">
				<c:if test="${requestScope.list.size() == 0 }">
					<div id="no_qna_list">
						<span id="no_qna_list_span">문의 내역이 없습니다</span>
					</div>
				</c:if>
				<c:forEach var="list" items="${requestScope.list}">
					<table class="result">
						<tr>
							<td id="result_1">제목</td>
							<td id="result_2">${list.title }</td>
						</tr>
						<tr>
							<td id="result_1">내용</td>
							<td id="result_2">${list.content }</td>
						</tr>
						<tr>
							<td id="result_1">작성일</td>
							<td id="result_2">${list.write_date }</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td><a href="deleteQna.do?qna_no=${list.qna_no }"
								id="btn_delete" class="btn">삭제</a>
							<td>
						</tr>
					</table>
					<c:choose>
						<c:when test="${list.response_content ==null }">
							<div id="response_yet">
								<span id="response_yet_span">현재 답변이 완료되지 않았습니다.</span>
							</div>
						</c:when>
						<c:otherwise>
							<div id="response">
								<span id="response_content">A.${list.response_content }</span><br>
								<span id="response_date">${list.response_date}</span>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</c:if>
	</div>
	<script>
		$("#btn_submit").click(function() {
			var title = $("#title").val();
			var user_id = $("#user_id").val();
			var content = $("#content").val();
			if (title.length == 0) {
				alert("제목을 입력하세요");
				return false;
			}
			if (user_id.length == 0) {
				alert("아이디를 읽을 수 없음");
				return false;
			}
			if (content.length == 0) {
				alert("내용을 입력하세요");
				return false;
			}
			var data = {
				"title" : title,
				"user_id" : user_id,
				"content" : content
			}
		})
	</script>
</body>
<%@include file="../template/footer.jsp"%>
</html>