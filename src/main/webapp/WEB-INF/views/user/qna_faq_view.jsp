<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="lib/jquery-3.5.1.min .js"></script>
<link rel="stylesheet" href="css/qna_faq_view.css">
<title>자주 묻는 질문 :: UTrip</title>
</head>
<%@include file="../template/header.jsp" %>
<body>
	<section class="content_wrap">
		<h3 class="title_faq">
		<strong>자주 묻는 질문</strong>
		</h3>
	</section>
	<div class="accordio_box">
		<ol>
			<li class="on">
				<h4><span>Q</span>test질문1</h4>
				<p>test답변1</p>
			</li>
		</ol>
		<ol>
			<li>
				<h4><span>Q</span>test질문2</h4>
				<p>test답변2</p>
			</li>
		</ol>
		<ol>
			<li>
				<h4><span>Q</span>test질문3</h4>
				<p>test답변3</p>
			</li>
		</ol>
		<ol>
			<li>
				<h4><span>Q</span>test질문4</h4>
				<p>test답변4</p>
			</li>
		</ol>
	</div>
<script>
	$(".accordio_box ol li").click(function() {
		$(".accordio_box ol li").removeClass("on");
		this.addClass("on");	
	});
</script>
</body>
<%@include file="../template/footer.jsp"%>
</html>