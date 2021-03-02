<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 페이지</title>
<link rel="stylesheet" href="css/admin_trip_insert_view.css">
<script src="lib/jquery-3.5.1.min .js"></script>
<script>
$(function(){
	var data="";
	var count=0;
	$("#plus").click(function(){
		if(count==0){
			alert("지역을 우선적으로 선택해주세요.");
			console.log(count);
			return false;
		}
		
		count++;
		console.log(count);
		$("#course_form").append(function(e){
			$.ajax({
				url:"courseSearch.do",
				data:data,
				method:'get',
				dataType:'json',
				success: function(d){
					console.log(d);
					var arr = d.result;
					console.log(arr);
					var result="";
						result += "<div><select class='area' name='place"+count+"'>";
						for(i=0;i<arr.length;i++){
							result +="<option value="+arr[i].place_no+">"+
							arr[i].place_name+"</option>";
						}
						result += "</select></div>";
					$("#course_form").append(result);
				}
			});
		});
				
	});
	$("#minus").click(function(){
		if(count == 1) return;
		document.getElementById('course_form').lastChild.remove();
		count--;
	});
	
	var sel_file;
	$(document).ready(function(){
		$("#input_img").on("change",handleImgFileSelect);
		$("#area").on("change",function(e){
			data = "area="+$("#area").val();
			console.log(data);
			$.ajax({
				url:"courseSearch.do",
				data:data,
				method:'get',
				dataType:'json',
				success: function(d){
					console.log(d);
					var arr = d.result;
					console.log(arr);
					var result="";
					for(j=1;j<4;j++){
						result += "<div><select class='area' name='place"+j+"'>";
						for(i=0;i<arr.length;i++){
							result +="<option value="+arr[i].place_no+">"+
							arr[i].place_name+"</option>";
						}
						result += "</select></div>";
						count=3;
					}
					$("#course_form").html(result);
				}
			});
			e.preventDefault();	
		});
	});
	
	
	function handleImgFileSelect(e){
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			if(!f.type.match("image/jp*")){
				alert("jpg형식으로 이미지를 업로드해주세요.");
				return;
			}
			
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e){
				$("#img").attr("src",e.target.result);
			}
			reader.readAsDataURL(f);
		});
		
	}
});


</script>
</head>
<body>
	<c:choose>
		<c:when test="${sessionScope.user.role == 'ADMIN' }">
			<%@include file="../template/header_admin.jsp"%>
		</c:when>
		<c:otherwise>
			<%@include file="../template/header.jsp"%>
			<script>
				alert("관리자만 이용할 수 있습니다.");
				location.href = "tripMain.do";
			</script>
		</c:otherwise>
	</c:choose>


	<div id="container">
	<div>
		<h2>여행정보 등록</h2>
	</div>
	<form action="tripInsertInfoAction.do" enctype="multipart/form-data" method="post">
		<div>
			<div class="row" id="a">
				<div class="col-6 col-12-medium">
					<select name ="area" id="area">
							<option>지역 선택</option>
							<c:forEach var="str" items="${requestScope.areaList}">
								<option value="${str}">${str}</option>
							</c:forEach>
					</select>
				</div>
				<div class="title">
					<input type="text" name="title" placeholder="제목" />
				</div>
				<div class="col-12">
					<textarea name="content" placeholder="컨텐츠 내용" rows="30"></textarea>
				</div>
				<div class="col-12" id="course_form">
					
				</div>
				<div class="plus_btn"><button type="button" id="plus">+</button>
				<button type="button" id="minus">-</button></div>
				<div class="col-12">
					<img id="img" name="file" src="">
				</div>
				<div class="file">
					<input type="file" name="file" id="input_img">	
				</div>
				<div class="button">
				<a href="javascript:history.back();" class="btn-gradient green">뒤로가기</a>
				<button class="btn-gradient green">작성하기</button></div>
			</div>
		</div>
	</form>
	</div>
	<%@include file="../template/footer.jsp"%>
</body>
</html>