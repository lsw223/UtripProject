<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/notice/notice_view.css">
<script src="lib/jquery-3.5.1.min .js"></script>
<script>
	$(function(){
		$(".comment_form textarea").keyup(function() {
			$(this).next().text($(this).val().length+"/500");
		});
		$(".comment_form button").click(function(){
			var data = $("#comment").serialize();
			$.ajax({
				url : "insertnoticeComment.do",
				data : data,
				method:"get",
				success:function(d){
					alert("댓글 등록 성공 : " + d);
					location.reload();	
				}
			});
		});
		$(".btn_like").click(function(){
			// 0 - like, 1 - hate
			// bno;
			var obj = $(this);
			d = "notice_no=${requestScope.notice.notice_no}&mode="+$(this).index();
			console.log(d);
			$.ajax({
				url : "plusLikeHate.do",
				data : d,
				method : "get",
				success:function(result){
					result = result.trim();
					if(result == "false"){
						alert("로그인후 이용하실 수 있습니다.");
						location.href="loginView.do";
					}
					console.log(result, result.length);
					$(obj).children("span").html(result);
					
				},
				/* error : function(request, status, error) {
					alert(request.responseText.trim());
					location.href="loginView.do";
					
				} */
			});
		});
	});
</script>
</head>
	<%@include file="../template/header.jsp"%>
<body>
	<c:if test="${sessionScope.login == null || sessionScope.login == false  }">
		<c:set var="page" target="${sessionScope }" value="${pageContext.request.requestURI}${pageContext.request.queryString }" property="resultPage" scope="session"/>
		${pageContext.request.requestURI}${pageContext.request.queryString }
		<script>
			alert("로그인을 하셔야 이용할수 있습니다.");
			location.href="loginView.do";
		</script>
	</c:if>
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
					<td colspan="2" class="text_center">
						<a href="#" class="btn_like">
							<img src="${pageContext.request.contextPath }/img/like.png">
							<!-- 좋아요 개수 -->
							<span>${requestScope.notice.nlike }</span>
						</a>
						<a href="#" class="btn_like">
							<img src="${pageContext.request.contextPath }/img/like.png" class="hate">
							<!-- 싫어요 개수 -->
							<span>${requestScope.notice.nhate }</span>
						</a>
					</td>
				</tr>
				<c:if test="${sessionScope.login == true}">
				<tr>
					<td colspan="2">
						<div class="comment_form">
							<form id="comment">
							<input type="hidden" name="notice_no" value="${requestScope.notice.notice_no }">
							<input type="hidden" name="writer" value="${sessionScope.user.id }">
							<span class="writer">${sessionScope.user.id }</span>
							<textarea name="content" maxlength="500"></textarea>
							<input type="hidden" name="writeDate">
							<p class="length">0/500</p><hr>
							<p style="text-align: right;"><button type="button">등록</button></p>
							</form>							
						</div>
					</td>
				</tr>
				</c:if>
				<tr>
					<th><a href="notice.do" class="btn">목록보기</a></th>
				</tr>
				<tr>
				
						<td colspan="2">
					
					<c:forEach var="noticecomment" items="${requestScope.noticecomment }">
						<table class="comment">	
							<tr>
								<th>작성자</th>
								<th>작성일</th>
								<th>좋아요</th>
								<th>싫어요</th>
							</tr>
							<tr>
								<td style="width:100px;text-align: center;">${noticecomment.writer }</td>
								<td style="width:180px;text-align: center;">${noticecomment.write_date }</td>
								<td style="width:50px;text-align: center;"><a href="noticecommentLike.do?comment_no=${noticecomment.comment_no }&notice_no=${requestScope.notice.notice_no}">${noticecomment.clike }</a></td>
								<td style="width:50px;text-align: center;"><a href="noticecommentHate.do?comment_no=${noticecomment.comment_no }&notice_no=${requestScope.notice.notice_no}">${noticecomment.chate }</a></td>
							</tr>
							<tr><td colspan="4" style="text-align: left;">${noticecomment.content }</td>
							</tr>
						</table>
					</c:forEach>
					
						</td>
							
				</tr>
		</table>
	</div>
</body>
<%@ include file="../template/footer.jsp" %>
</html>