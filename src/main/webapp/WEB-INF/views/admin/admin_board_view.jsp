<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 페이지</title>
<link rel="stylesheet" href="css/notice/admin_notice.css" media="screen and (min-width:1024px)">
<link rel="stylesheet" href="css/notice/admin_notice_tab.css" media="screen and (max-width:1024px)">
<script src="lib/jquery-3.5.1.min .js"></script>
<!-- <script src="js/board_view.js"></script> -->
<script type="text/javascript">
/*댓글추가*/
$(function() {
		$(".comment_form textarea").keyup(function() {
			$(this).next().text($(this).val().length + "/500");
		});
		$(".comment_form button").click(function() {
			var data = $("#comment").serialize();
			$.ajax({
				url : "insertComment.do",
				data : data,
				method : "get",
				success : function(d) {
					alert("댓글 등록 성공 : " + d);
					location.reload();
				}
			});
		});
		//댓글 수정 창 보여주기
		$(document).on("click","#comment_update_btn",function(){ 
			var commentno=$(this).parent().parent().find("input[name=commentno]").val();
			
		    $(this).parent().parent().after("<tr><td colspan='3' style='text-align: center';><input type='hidden' name='commentno' value='"+commentno+"'><input style='width : 450px;' type='text' class='comment_update_content' name='content'></td>"
		    				+"<td><button href='#' class='comment_update_content_btn' id='update_comment'>수정</button>"
							+"<a href='#' class='comment_update_content_btn' id='close_update_comment_btn'>닫기</a></td></tr>");

				 	//댓글 수정 창 닫기
					$("#close_update_comment_btn").click(function(){
						$(this).parent().parent().remove();
					});
			
		});
		/*좋아요 추가*/
		$(".btn_like").click(function(){
			var obj = $(this);
			d = "boardno=${requestScope.board.boardNo}&mode="+$(this).index();
			console.log(d);
			$.ajax({
				url : "plusLike.do",
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
				error : function(request, status, error) {
					/*alert(request.responseText.trim());*/
					console.log(request.responseText.trim());
					location.href="loginView.do";
					
				}
			});
		});
});
</script>
</head>
<body>
	<%@ include file="../template/header_admin.jsp"%>
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
		<h2>글조회 페이지</h2>
		<table>
			<tr>
				<th>제목</th>
				<td>${requestScope.board.title }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${requestScope.board.id }</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${requestScope.board.writeDate }</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${requestScope.board.boardCount }</td>
			</tr>
			<tr>
				<th style="vertical-align: top;">내용</th>
				<td>${requestScope.board.content }</td>
			</tr>
			<tr>
				<td colspan="2" class="text_center"><a href="#" class="btn_like"> 
				<img src="${pageContext.request.contextPath }/img/like.png"> <!-- 좋아요 개수 -->
				<span>${requestScope.board.boardLike }</span>
				</a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="comment_form">
						<form id="comment">
							<input type="hidden" name="boardno" value="${requestScope.board.boardNo }"> 
							<input type="hidden" name="id" value="${sessionScope.user.id }"> 
							<span class="id"></span>
							<textarea name="content" maxlength="500"></textarea>
							<p class="length">0/500</p>
							<hr>
							<p style="text-align: right;">
								<button type="button">등록</button>
							</p>
						</form>
					</div>
				</td>
			</tr>
			<tr>
				<th>
				<a href="adminBoard.do" class="btn">목록보기</a>
				</th>
					<td style="text-align: right;">
						<c:if test="${user.id eq board.id }">
						<a href="adminUpdateBoardView.do?boardno=${requestScope.board.boardNo }" class="btn">수정</a>
						</c:if>
						<a href="adminDeleteBoard.do?boardno=${requestScope.board.boardNo }" class="btn">삭제</a>
						<!-- <a href="#" class="btn">이전글</a> 
						<a href="#" class="btn">다음글</a> -->
					</td>
			</tr>
			<tr>

				<td colspan="2"><c:forEach var="comment" items="${requestScope.comment }">
						<form id="comment_list" action="adminUpdateComment.do">
						<table class="comment">
							<tr>
								<th>작성자</th>
								<th>작성일</th>
								<th>내용</th>
								<th></th>
							</tr>
							<tr>
								<td style="width: 100px;">
								<input type="hidden" class="comment_update_content" name="commentno" value="${comment.commentNo }">${comment.id }</td>
								<td style="width: 120px;">${comment.writeDate }</td>
								<td style="width: 450px;">${comment.content }</td>
								<td style="width: 30px; text-align: center;">
								<c:if test="${user.id eq comment.id }">
									<a href="#" class="comment_btn" id="comment_update_btn">수정</a>
								</c:if>
									<a href="adminDeleteComment.do?commentno=${comment.commentNo }&boardno=${requestScope.board.boardNo }" class="comment_btn">삭제</a>
								</td>
							</tr>
							<tr>
									<td><input type="hidden" class="comment_update_content"
										name="boardno" value="${requestScope.board.boardNo }"></td>
									<td><input type="hidden" class="comment_update_content"
										name="id" value="${comment.id }"></td>
								</tr>
						</table>
						</form>
					</c:forEach>
				</td>
			</tr>
		</table>
	</div>
	<%@include file="../template/footer.jsp"%>
</body>
</html>











