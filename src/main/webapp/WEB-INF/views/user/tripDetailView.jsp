<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지도 범위 재설정 하기</title>
<style>
.customoverlay {
	position: relative;
	bottom: 85px;
	border-radius: 6px;
	border: 1px solid #ccc;
	border-bottom: 2px solid #ddd;
	float: left;
}

.customoverlay:nth-of-type(n) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.customoverlay a {
	display: block;
	text-decoration: none;
	color: #000;
	text-align: center;
	border-radius: 6px;
	font-size: 14px;
	font-weight: bold;
	overflow: hidden;
	background: #d95050;
	background: #d95050
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
		no-repeat right 14px center;
}

.customoverlay .title {
	display: block;
	text-align: center;
	background: #fff;
	margin-right: 35px;
	padding: 10px 15px;
	font-size: 14px;
	font-weight: bold;
}

.customoverlay:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: -12px;
	width: 22px;
	height: 12px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}
</style>

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
	<div>
		<h2>여행코스</h2>
		<div id="map" style="width: 500px; height: 500px;"></div>
		<p>
			<button onclick="setBounds()">전체 코스보기</button>
		</p>
		<div id="content">
			<p>${requestScope.dto.title}</p>
			<p>${requestScope.dto.content}</p>
			<p>${requestScope.dto.video_url}</p>
			<p>${requestScope.dto.rating}</p>

			<c:forEach var="dto" items="${requestScope.tripList }">
				<a href="#" onclick="setOption(${dto.course_no-1});return false;">${dto.place_name}</a>
				
			</c:forEach>
			<div >
			<c:if test="${sessionScope.user.role == 'ADMIN' }">
				<a href="tripUpdateView.do?tripNo=${requestScope.dto.trip_no}">수정</a>
				<a href="#" id="deleteTripInfo">삭제</a>
			</c:if>
			</div>
		</div>

	</div>
	<a href="hotelView.do?area=${requestScope.area}">주변 호텔정보 보러가기</a>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=16b17515f471d69c146a2979295c4faf"></script>
	<script>
	$("#deleteTripInfo").click(function(){
		if(confirm("정말 삭제하시겠습니까?")==true){
			location="tripDeleteAction.do?trip_no=<%=request.getAttribute("trip_no")%>"
			alert("삭제가 완료되었습니다.")
		}else{
			return;
		}
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
			content[i]= '<div class="customoverlay">'
				+ '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">'
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
	    showDistance(content, points[list.length-1]);   
		
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
            content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
            content += '    </li>';
            content += '    <li>';
            content += '        <span class="label">도보</span>' + walkHour + walkMin;
            content += '    </li>';
            content += '    <li>';
            content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
            content += '    </li>';
            content += '</ul>'

            return content;
        }
	 setBounds();