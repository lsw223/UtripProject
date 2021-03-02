<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="lib/jquery-3.5.1.min .js"></script>
<title>QnA :: UTrip</title>
</head>
<%@include file="../template/header.jsp"%>
<body>
	<div id="container">
		<a href="qnaFaqView.do" id="btn_faq_view" class="button">자주 묻는 질문</a> <a href="#"
			id="btn_qna_view" class="button">문의하기</a> <a href="#"
			id="btn_qna_list_view" class="button">문의조회</a>
		<hr>
		<table id="table_qna" class="hidden">
			<tr>
				<th>문의하기</th>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" id="title"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="hidden" name="user_id" id="user_id"
					value="${sessionScope.user.id }"> ${sessionScope.user.id }</td>
			</tr>
			<tr>
				<th style="vertical-align: top;">내용</th>
				<td><textarea name="content" id="content"></textarea></td>
			</tr>
			<tr>
				<th></th>
				<td id="td_btn" style="text-align: right;">
					<a href=# id="btn_submit" class="button">등록</a>
				</td>
			</tr>
		</table>
		<div id="qna_list">
		</div>
	</div>
	<script>
		$("#btn_qna_view").click(function(){
			if(${empty sessionScope.user}){
				alert("로그인이 필요한 서비스입니다");
			location.href="loginView.do";
		}else{
			$("table").toggleClass("hidden");
		}
		})
		
		$("#btn_submit").click(function(){
			var title = $("#title").val();
			var user_id = $("#user_id").val();
			var content = $("#content").val();
			if(title.length==0){
				alert("제목을 입력하세요");
				return false;
			}
			if(user_id.length==0){
				alert("아이디를 읽을 수 없음");
				return false;
			}
			if(content.length==0){
				alert("내용을 입력하세요");
				return false;
			}
			var data = {
				"title":title,
				"user_id":user_id,
				"content":content
			}
			$.ajax({
				method:"get",
				url:"qna.do",
				data:data,
				dataType:"json",
				success:function(response){
					alert(response.responseMessage);
					$("#table_qna input").val("");
					$("#btn_qna_list_view").click();
				}
			})
		})
		
		$("#btn_qna_list_view").click(function(){
	if(${empty sessionScope.user}){
		alert("로그인이 필요한 서비스입니다.");
		location.href="loginView.do";
		return false;
	}
	$.ajax({
		method:"get",
		url:"showQnaList.do",
		data:{"user_id":"${sessionScope.user.id}"},
		dataType:"json",
		success:function(resp){
			if(resp.responseCode==211){
				alert(resp.responseMessage);
			}else if(resp.responseCode==210){
				var list = resp.result;
				var str="<p><span>번호</span><span>제목</span>"
								+"<span>작성자</span><span>작성일</span></p>";
				for(i=0; i<list.length; i++){
					str += "<p><span>"+list[i].qna_no+"</span>"
								+"<span>"+list[i].title+"</span>"
								+"<span>"+list[i].user_id+"</span>"
								+"<span>"+list[i].write_date+"</span></p>";
				}
				$("#qna_list").html(str);
			}
		}
	})
})
</script>
</body>
<%@include file="../template/footer.jsp"%>
</html>