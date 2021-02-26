<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/admin_hotel_request.css">
<title>호텔제휴 :: UTrip관리자</title>
</head>
<body>
<%@include file="../template/header_admin.jsp" %>
	<div id="container">
		<h2>호텔 제휴신청 관리</h2>
		<select>
			<option value="1">전체보기</option>
			<option value="2">신청 대기중</option>
		</select>
		<table>
			<tr>
				<th>신청번호</th>
				<th>신청인</th>
				<th>호텔명</th>
				<th>주소</th>
				<th>지역</th>
				<th>상태</th>
				<th>시간</th>
				<th>URL</th>
				<th></th>
			</tr>
			<c:forEach var="dto" items="${sessionScope.list }" >
				<c:choose>
					<c:when test="${dto.status=='신청대기중'}">
						<tr>
					</c:when>
					<c:otherwise>
						<tr class="completed">
					</c:otherwise>
				</c:choose>
					<td>${dto.request_no }</td>
					<td>${dto.user_id }</td>
					<td>${dto.hotel_name }</td>
					<td>${dto.address}</td>
					<td>${dto.area }</td>
					<td>${dto.status}</td>
					<td>${dto.request_date }</td>
					<td>${dto.hotel_url }</td>
					<td>
						<c:choose>
							<c:when test="${dto.status=='신청대기중'}">
								<a href="permit.do?request_no=${dto.request_no}&address=${dto.address}&area=${dto.area}&hotel_name=${dto.hotel_name}&hotel_url=${dto.hotel_url}" class="button">승인</a>
								<a href="reject.do?request_no=${dto.request_no }" class="button">반려</a>
							</c:when>
							<c:otherwise>
								처리완료
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
<%@include file="../template/footer.jsp" %>
</body>
<script>
$("select").change(function(){
	if($(this).val()=="1"){
		$("tr").removeClass("hidden");
	}else{
		$(".completed").addClass("hidden");
	}
})
</script>
</html>