<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 페이지</title>
<link rel="stylesheet" href="css/admin_board_view.css">
<link rel="stylesheet" media="(max-width:480px)" href="css/mobile_board_view.css">
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
		    $(this).parent().parent().parent().find(".comment-update-form").show();
		});
		//댓글 수정 창 닫기
	    $(document).on("click","#close_update_comment_btn",function(){
	    	$(this).parent().parent().parent().find(".comment-update-form").hide();
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
				<th>작성일</th>
				<td>${requestScope.board.writeDate }</td>
			</tr>
			<tr>
				<th>조회수</th>	
				<td>${requestScope.board.boardCount }</td>
			</tr>
			<tr>
				<td colspan="4">${requestScope.board.content }</td>
			</tr>
			<tr>
				<td colspan="4" class="text_center">
				<a href="#" class="btn_like"> 
				<img src="${pageContext.request.contextPath }/img/like.png"> <!-- 좋아요 개수 -->
				<span>${requestScope.board.boardLike }</span>
				</a></td>
			</tr>
			<tr>
				<td colspan="2"><p>댓글</p></td>
			</tr>
			<tr>
				<td colspan="4"><c:forEach var="comment" items="${requestScope.comment }">
						<form id="comment_list" action="adminUpdateComment.do">
						<table class="comment">
							<tr>
								<td colspan="2" id="comment_id">
								<input type="hidden" class="comment_update_content" name="commentno" value="${comment.commentNo }">${comment.id }</td>
								<td><p id="comment_date">${comment.writeDate }</p></td><td style="width: 30px; text-align: center;">
								<c:if test="${user.id eq comment.id }">
									<a href="#" class="comment_btn" id="comment_update_btn">수정</a>
								</c:if>
									<a href="adminDeleteComment.do?commentno=${comment.commentNo }&boardno=${requestScope.board.boardNo }" class="comment_btn">삭제</a>
								</td>
							</tr>
							<tr>
								<td colspan="4"><div id="comment_content"><p>${comment.content }</p></div></td>
							</tr>
							<tr>
							<td colspan="4"><c:if test="${user.id eq comment.id }">
									<div class="comment-update-form">
										<input type="hidden" name="commentno" value="${comment.commentNo }" />
										<input type="hidden" name="boardno" value="${requestScope.board.boardNo }">
										<input type="hidden" name="id" value="${comment.id}">
										<textarea name="content">${comment.content }</textarea>
										<button class="comment_update_content_btn">수정</button>
										<a class='comment_update_content_btn' id="close_update_comment_btn">닫기</a>
									</div>
								</c:if>
								</td>
							</tr>
						</table>
						</form>
					</c:forEach>
				</td>
			</tr>
				<tr>
				<td colspan="4">
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
				<td colspan="2">
				<a href="adminBoard.do" class="btn">목록보기</a>
				</td>
				<td colspan="2" style="text-align: right;">
					<c:if test="${user.id eq board.id }">
					<a href="adminUpdateBoardView.do?boardno=${requestScope.board.boardNo }" class="btn">수정</a>
					</c:if>
					<a href="adminDeleteBoard.do?boardno=${requestScope.board.boardNo }" class="btn">삭제</a>
					<c:choose>
						<c:when test = "${requestScope.board.prevNum == null}">
							<script>
								alert("더이상 글이 없습니다.");
								history.back();
							</script>
						</c:when>
						<c:otherwise>
						<a href="adminBoardView.do?boardno=${requestScope.board.prevNum}" class="btn">이전글</a>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test = "${requestScope.board.nextNum eq null}">
							<script>
								alert("더이상 글이 없습니다.");
								history.back();
							</script>
						</c:when>
						<c:otherwise>
							<a href="adminBoardView.do?boardno=${requestScope.board.nextNum}" class="btn">다음글</a>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</div>
	<%@include file="../template/footer.jsp"%>
</body>
</html>











