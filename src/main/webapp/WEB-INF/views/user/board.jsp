<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/board.css" />
<link rel="stylesheet" media="(max-width:480px)" href="css/mobile_board.css" />
<script src="lib/jquery-3.5.1.min .js"></script>

<title>커뮤니티 :: UTrip</title>
</head>
<body>
	<%@ include file="../template/header.jsp"%>
	<div class="backimg">
		<h1>커뮤니티</h1>
		<p>여러분의 여행이야기를 들려주세요</p>
	</div>
	<div id="container">
		<table class="board">
			<tr>
				<th>글번호</th>
				<th class="title">제목</th>
				<th class="id">작성자</th>
				<th class="writeDate">작성일</th>
				<th class="boardLike">좋아요</th>
				<th class="boardCount">조회수</th>
			</tr>
			<c:forEach var="dto" items="${requestScope.list }">
				<tbody id="result_search">
					<tr>
						<td>${dto.boardNo }</td>
						<td><a href="boardView.do?boardno=${dto.boardNo }">
								${dto.title } <c:if test="${dto.commentCount > 0 }">
						[${dto.commentCount}]
					</c:if>
						</a></td>
						<td>${dto.id}</td>
						<td>${dto.writeDate }</td>
						<td>${dto.boardLike }</td>
						<td>${dto.boardCount }</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>

		<div id="pagging">
			<form>
				<div class="page_bar">
					<c:if test="${pagging.previousPageGroup }">
						<a
							href="boardSerach.do?pageNo=${pagging.startPageOfPageGroup - 1 }&kind=${requestScope.kind}&search=${requestScope.search}">◀</a>
					</c:if>
					<c:forEach var="i" begin="${pagging.startPageOfPageGroup}"
						end="${pagging.endPageOfPageGroup}">
						<a
							href="boardSerach.do?pageNo=${i }&kind=${requestScope.kind}&search=${requestScope.search}">${ i}</a>
					</c:forEach>

					<c:if test="${pagging.nextPageGroup }">
						<a
							href="boardSerach.do?pageNo=${pagging.endPageOfPageGroup + 1 }&kind=${requestScope.kind}&search=${requestScope.search}">▶</a>
					</c:if>
					<a href="boardWriteView.do" class="btn_writer">글쓰기</a>
				</div>
			</form>
		</div>
		<div id="search_bar">
			<form action="boardSerach.do" id="search">
				<select name="kind">
					<option value="title"
						<c:if test="${kind eq 'title'}">selected</c:if>>제목</option>
					<option value="id" <c:if test="${kind eq 'id'}">selected</c:if>>아이디</option>
					<option value="content"
						<c:if test="${kind eq 'content'}">selected</c:if>>내용</option>
				</select> <input type="text" name="search" value="${search}" id="keyword">
				<button id="btn_submit">검색</button>
			</form>
			<script>
				$("#btn_submit").click(function() {
					if ($("#keyword").val() == "") {
						alert("검색는 최소 한글자 이상부터 가능합니다")
						$("#keyword").focus();
						return false;
					}

				});
			</script>
		</div>
	</div>
	<%@include file="../template/footer.jsp"%>
</body>
</html>