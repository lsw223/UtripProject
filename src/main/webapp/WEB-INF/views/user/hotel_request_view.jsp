<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="lib/jquery-3.5.1.min .js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="css/hotel_request_view.css" media="screen and (min-width:1024px)">
<link rel="stylesheet" href="css/hotel_request_view_tab.css" media="screen and (max-width:1024px)">
<title>호텔 제휴신청 :: UTrip</title>
</head>
<c:choose>
	<c:when test="${sessionScope.user.role == 'ADMIN' }">
		<%@include file="../template/header_admin.jsp"%>
	</c:when>
	<c:otherwise>
		<%@include file="../template/header.jsp"%>
	</c:otherwise>
</c:choose>
<body>
	<div id="container">
		<p>
			<small>UTrip 호텔</small>
		</p>
		<h1>
			호텔 제휴신청
		</h1>
		<a href="#" id="btn_apply_view" class="button">신청서 작성</a>
		<a href="#" id="btn_request_list_view"class="button">나의 신청 현황</a>
		<hr>
		<table id="table_apply" class="hidden">
			<tr>
				<td id="th" colspan="3">호텔 제휴 신청서</td>
			</tr>
			<tr>
				<td>호텔 이름</td>
				<td>
					<input type="text" name="hotel_name" id="hotel_name">
				</td>
				<td></td>
			</tr>
			<tr>
				<td>주소</td>
				<td>
					<input type="text" name="address" id="address" readonly>
					<a href="#" id="btn_address" class="button">
						주소검색
					</a>
				</td>
				<td></td>
			</tr>
			<tr>
				<td>지역</td>
				<td>
					<input type="text" name="area" id="area" readonly>
				</td>
				<td></td>
			</tr>
			<tr>
				<td>URL</td>
				<td>
					<input type="text" name="hotel_url" id="hotel_url">
				</td>
				<td></td>
			</tr>
			<tr>
				<td id="td_btn" colspan=3>
					<a href=# id="btn_submit" class="button">신청하기</a>
				</td>
			</tr>
		</table>
		<div id="request_list">
		</div>
	</div>
<script>

// 호텔 제휴 신청서 사용자에게 보여주기
$("#btn_apply_view").click(function(){
	if(${empty sessionScope.user}){
		alert("로그인이 필요한 작업입니다");
		location.href="loginView.do";
	}else{
		$("table").toggleClass("hidden");
	}
})

// Daum 우편번호 API 이용해서 주소 입력받기
$("#btn_address").click(function(){
	new daum.Postcode({
	    oncomplete: function(data) {
			$("#address").val(data.address);
			$("#area").val(data.sido);
	    }
	}).open();		
})

// 호텔제휴 신청하기 버튼 클릭시 실행하는 부분
$("#btn_submit").click(function(){
	var hotel_name = $("#hotel_name").val();
	var address = $("#address").val();
	var area = $("#area").val();
	var hotel_url = $("#hotel_url").val();
	if(hotel_name.length==0){
		alert("호텔명을 입력하세요");
		return false;
	}
	if(address.length==0){
		alert("주소를 입력하세요");
		return false;
	}
	var data = {
		"hotel_name":hotel_name,
		"address":address,
		"area":area,
		"hotel_url":hotel_url
	}
	$.ajax({
		method:"get",
		url:"hotelRequest.do",
		data:data,
		dataType:"json",
		success:function(response){
			alert(response.responseMessage);
			$("#table_apply input").val("");
			$("#btn_request_list_view").click();
		}
	})
})

// 나의 신청 현황 버튼 클릭시 실행되는 부분
$("#btn_request_list_view").click(function(){
	if(${empty sessionScope.user}){
		alert("로그인이 필요한 작업입니다.");
		location.href="loginView.do";
		return false;
	}
	$.ajax({
		method:"get",
		url:"showRequestList.do",
		data:{"id":"${sessionScope.user.id}"},
		dataType:"json",
		success:function(resp){
			if(resp.responseCode==201){
				alert(resp.responseMessage);
			}else if(resp.responseCode==200){
				var list = resp.result;
				var str="<p><span>신청번호</span><span>호텔명</span>"
									+"<span>상태</span><span>신청시간</span></p>";
				for(i=0; i<list.length; i++){
					str += "<p><span>"+list[i].request_no+"</span>"
								+"<span>"+list[i].hotel_name+"</span>"
								+"<span>"+list[i].status+"</span>"
								+"<span>"+list[i].request_date+"</span></p>";
				}
				$("#request_list").html(str);
				if($(window).width()<1024){
					$("#request_list span").css({"font-size":"12px"})
				}
			}
		}
	})
})
</script>
</body>
<%@include file="../template/footer.jsp" %>
</html>