<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/notice/admin_notice_view.css">
<script src="lib/jquery-3.5.1.min .js"></script>
<script>
	
</script>
</head>
	<%@include file="../template/header_admin.jsp" %>
<body>
	<div id="container">
		<h2>글조회 페이지</h2>
			<table>
				<tr>
					<th>제목</th>
					<td>
						<!-- 조회한 내용 -->
						${requestScope.notice.title }
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						${requestScope.notice.nwriter }			
					</td>
				</tr>
				<tr>
					<th>작성일</th>
					<td>
						${requestScope.notice.write_date }
					</td>
				</tr>
				<tr>
					<th style="vertical-align: top;">내용</th>
					<td>
						<textarea readonly="readonly">${requestScope.notice.content }</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						첨부파일<br>
						<c:forEach var="f" items="${requestScope.file }">
							<a href="fileDownload.do?writer=${f.writer }&file=${f.fileName}">
							${f.fileName}</a><br>
							<!-- 해당 파일이 이미지인지? -->
							<c:if test="${f.type =='image' }">
								<img src="imageLoad.do?writer=${f.writer }&file=${f.fileName}">
							</c:if>
							<c:if test="${f.type =='video' }">
								<video controls src="imageLoad.do?writer=${f.writer }&file=${f.fileName}"></video>
							</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th><a href="adminnotice.do" class="btn">목록보기</a></th>
					<td style="text-align: right;">
						<a href="updateNoticeview.do?notice_no=${requestScope.notice.notice_no }" class="btn">수정</a>
						<a href="deleteNotice.do?notice_no=${requestScope.notice.notice_no }" class="btn">삭제</a>
					</td>
				</tr>
		</table>
	</div>
</body>
<%@ include file="../template/footer.jsp" %>
</html>