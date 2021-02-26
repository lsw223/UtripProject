<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<%@ include file="../template/header.jsp"%>
	<div>
	<h2>여행코스</h2>
	<div id="map" style="width: 500px; height: 500px;"></div>
	<p>
		<button onclick="setBounds()">지도 범위 재설정 하기</button>
	</p>
	</div>
	<a href="hotelView.do?area=${requestScope.area}">주변 호텔정보 보러가기</a>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=16b17515f471d69c146a2979295c4faf"></script>
	<script>
		var list = ${requestScope.list}
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(
	<%=request.getAttribute("avgX")%>
		,
	<%=request.getAttribute("avgY")%>
		), // 지도의 중심좌표
			level : 10
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
				+ '    <span class="title">'+list[i].place_name+'</span>' + '  </a>' + '</div>';
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

		// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
		kakao.maps.event.addListener(marker, 'click', function() {
			overlay.setMap(map);
		});

		// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
		function closeOverlay() {
			overlay.setMap(null);
		}
		
	</script>
	
	<%@include file="../template/footer.jsp"%>
</body>
</html>