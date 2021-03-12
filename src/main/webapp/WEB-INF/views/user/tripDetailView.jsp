<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="lib/jquery-3.5.1.min .js"></script>
<link rel="stylesheet" href="css/trip_detail_view.css">
<title>여행 코스 :: UTrip</title>
</head>
<body>
	<c:choose>
		<c:when test="${sessionScope.user.role == 'ADMIN' }">
			<%@include file="../template/header_admin.jsp"%>
		</c:when>
		<c:otherwise>
			<%@include file="../template/header.jsp"%>
		</c:otherwise>
	</c:choose>
	<div id="container">
		<div id="head">
			<small>
				<a href="tripView.do">대한민국</a> > <a href="areaView.do?area=${fn:substring(requestScope.dto.trip_no,0,2)}">${requestScope.dto.area_name}</a>			
			</small><br>
			<h2>${requestScope.dto.title}</h2>
			<c:if test="${!empty sessionScope.user}">
				<a href="#" id="like">
					<span>${sessionScope.user.mbti}</span><img src="img/like2.png">
				</a>
				<span>${requestScope.tripLike}</span>
			</c:if>
			<span id="rating">
				평점 
				<span>${requestScope.dto.rating }</span> 
			</span>
			<a href="#">평가하기</a>
		</div>
		<hr>
		<div id="content">
			<h3>여행 소개</h3>
			<p>${requestScope.dto.content}</p>
			<h3>여행 코스 길이</h3>
			<div id="course_length"></div>
			<c:forEach var="dto" items="${requestScope.tripList }">
				<a href="#" onclick="setOption(${dto.course_no-1});return false;" class="button">${dto.place_name}</a>
			</c:forEach>
			<div id="map" ></div>
			<button onclick="setBounds()" id="btn_zoom" class="button">전체 코스보기</button>
			<p id="hotel">
				<a href="hotelView.do?area=${requestScope.area}" class="button" id="btn_hotel">주변 호텔정보 보러가기</a>
			</p>
			<p id="btns">
				<c:if test="${sessionScope.user.role == 'ADMIN' }">
					<a href="tripUpdateView.do?tripNo=${requestScope.dto.trip_no}" class="button">수정</a>
					<a href="#" id="deleteTripInfo"class="button">삭제</a>
				</c:if>
				<span id="go_back">
					<a href="#" class="button" onclick="history.back()">목록보기</a>
				</span>
			</p>
		</div>
		<div id="alert">
			<p>
				평가하기
				<a id="close" href="#">x</a>
			</p>
			<label>
				<input type="radio" name="assess"value=5 checked> 💜💜💜💜💜<br>
			</label>
			<label>
				<input type="radio" name="assess"value=4> 💜💜💜💜🤍<br>
			</label>
			<label>
				<input type="radio" name="assess"value=3> 💜💜💜🤍🤍<br>
			</label>
			<label>
				<input type="radio" name="assess"value=2> 💜💜🤍🤍🤍<br>
			</label>
			<label>
				<input type="radio" name="assess" value=1> 💜🤍🤍🤍🤍<br>
			</label>
			<input type="hidden" value=5>
			<a href="#" class="button" >확인</a>
		</div>

		</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=16b17515f471d69c146a2979295c4faf"></script>
	<script>
	$(function(){
	$("#deleteTripInfo").click(function(){
		if(confirm("정말 삭제하시겠습니까?")==true){
			location="tripDeleteAction.do?trip_no=<%=request.getAttribute("trip_no")%>"
			alert("삭제가 완료되었습니다.")
		}else{
			return;
		}
	})
	})
</script>
	<script>
		var list = ${requestScope.list}
		var distanceOverlay;
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(
	<%=request.getAttribute("avgX")%>
		,
	<%=request.getAttribute("avgY")%>
		), // 지도의 중심좌표
			level : 5
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정합니다 
		var points = new Array();
		var content = new Array();
		
		
		for (i = 0; i < list.length; i++) {
			points[i] = new kakao.maps.LatLng(list[i].place_x, list[i].place_y);
			var x = list[i].place_x;
			var y = list[i].place_y;
			var a = parseInt(x);
			var b = parseInt((x-a)*60);
			var c = ((x - a) * 60 - b ) * 60;
			var str = a+"°"+b+"'"+c+'&quot;N';
			a=parseInt(y);
			b = parseInt((y-a)*60);
			c = ((y - a) * 60 - b ) * 60;
			str += "&#43;"+a+"°"+b+"'"+c+'&quot;E';
			console.log(str);
			content[i]= '<div class="customoverlay">'
				+ '  <a href="https://www.google.co.kr/maps/place/'+str+'" target="_blank">'
				+ '    <span class="title">'+list[i].course_no+'.'+list[i].place_name+'</span>' + '  </a>' + '</div>';
		}

		// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
		var bounds = new kakao.maps.LatLngBounds();

		var i, marker, overlay;
		for (i = 0; i < points.length; i++) {
			// 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
			marker = new kakao.maps.Marker({
				position : points[i]
			});
			marker.setMap(map);
			overlay = new kakao.maps.CustomOverlay({
				content : content[i],
				map : map,
				position : marker.getPosition()
			});

			// LatLngBounds 객체에 좌표를 추가합니다
			bounds.extend(points[i]);
		}
		
		function setBounds() {
			// LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
			// 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
			map.setBounds(bounds);
		}
		
		//지도 좌표 이동
		function setOption(course_no) {
			var bounds1 = new kakao.maps.LatLngBounds();
			bounds1.extend(points[course_no]);
			map.setBounds(bounds1);
		}

		// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
		kakao.maps.event.addListener(marker, 'click', function() {
			overlay.setMap(map);
		});


		// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
		function closeOverlay() {
			overlay.setMap(null);
		}
		
		// 지도에 표시할 선을 생성합니다
		var polyline = new kakao.maps.Polyline({
		    path: points, // 선을 구성하는 좌표배열 입니다
		    strokeWeight: 5, // 선의 두께 입니다
		    strokeColor: '#FFAE00', // 선의 색깔입니다
		    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		    strokeStyle: 'solid' // 선의 스타일입니다
		});

		// 지도에 선을 표시합니다 
		polyline.setMap(map);  
		
		 
		var distance = Math.round(polyline.getLength()), // 선의 총 거리를 계산합니다
        content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
        content = getTimeHTML(distance);
	    // 거리정보를 지도에 표시합니다
	    console.log(points[list.length-1])
	  /*   showDistance(content, points[list.length-1]);    */
		
		//거리정보 출력
        function showDistance(content, position) {
	     
	     if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
	         
	         // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
	         distanceOverlay.setPosition(position);
	         distanceOverlay.setContent(content);
	         
	     } else { // 커스텀 오버레이가 생성되지 않은 상태이면
	         
	         // 커스텀 오버레이를 생성하고 지도에 표시합니다
	         distanceOverlay = new kakao.maps.CustomOverlay({
	             map: map, // 커스텀오버레이를 표시할 지도입니다
	             content: content,  // 커스텀오버레이에 표시할 내용입니다
	             position: position, // 커스텀오버레이를 표시할 위치입니다.
	             xAnchor: 0,
	             yAnchor: 0,
	             zIndex: 3  
	         });      
	     }
	 }
        function getTimeHTML(distance) {

            // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
            var walkkTime = distance / 67 | 0;
            var walkHour = '', walkMin = '';

            // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
            if (walkkTime > 60) {
                walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
            }
            walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

            // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
            var bycicleTime = distance / 227 | 0;
            var bycicleHour = '', bycicleMin = '';

            // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
            if (bycicleTime > 60) {
                bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
            }
            bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

            // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
            var content = '<ul class="dotOverlay distanceInfo">';
            content += '    <li>';
            content += '        <span class="label">총거리</span><span class="number">' + Math.trunc(distance/100)/10.0 + '</span>km';
            content += '    </li>';
            content += '    <li>';
            content += '        <span class="label" id="walk">도보</span>' + walkHour + walkMin;
            content += '    </li>';
            content += '    <li>';
            content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
            content += '    </li>';
            content += '</ul>'

	     	$("#course_length").html(content);
            return content;
        }
	 setBounds();
	 
	 
	 //좋아요 클릭
	 $("#like").click(function(e){
		 e.preventDefault();
		 $.ajax({
			 method:"get",
			 url:"tripLike.do",
			 data:{
				 "tripNo":"${param.trip_no}",
				 "mbti":"${sessionScope.user.mbti}",
				 "userId":"${sessionScope.user.id}"
			 },
			 dataType:"json",
			 success:function(resp){
				 if(resp.responseCode == 200){
					 $("#like+span").html(resp.responseMessage);
				 }
				 else if(resp.responseCode == 201){
					 alert(resp.responseMessage);
				 }
			 }
		 })
	 })
	 
	 // 별점 나타내기
	 var rating = Math.round(${requestScope.dto.rating});
	 var str = "";
	for(i=0; i<rating; i++){
		str += "💜"; 
	}	 
	 for(i=0; i<5-rating; i++){
		 str += "🤍";
	 }
	 $("#rating").append(str);
	 
	 $("#rating+a").click(function(){
		 if(${sessionScope.user==null}){
			 if(confirm("로그인이 필요한 작업입니다,\n로그인 하시겠습니까?")){
				 location.href="loginView.do";
			 }
			 return false;
		 }
		 $("#alert").show();
	 })
	 $("#close").click(function(){
		 $("#alert").hide();
	 })
	 
	 $("#alert input").click(function(){
		 $("#alert input[type=hidden]").val($(this).val());
	 })
	 $("#alert .button").click(function(e){
		 e.preventDefault();
		 $.ajax({
			 method:"get",
			 url:"assess.do",
			 data:{
				"score":$("#alert input[type=hidden]").val(),
				"trip_no":"${param.trip_no}",
				"user_id":"${sessionScope.user.id}"
			 },
			 dataType:"json",
			 success:function(resp){
				 if(resp.responseCode==201){
					 alert(resp.responseMessage);
					 $("#alert").hide();
					 return false;
				 }
				 alert("평가 해주셔서 감사합니다");
				 location.href="tripDetailView.do?trip_no=${param.trip_no}";
				 $("#alert").hide();
			 }
		 })
	 })
	</script>
<%@include file="../template/footer.jsp"%>
</body>
</html>


