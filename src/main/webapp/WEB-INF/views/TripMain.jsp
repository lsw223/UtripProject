<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>당신의 여행 스타일 UTrip</title>
<script src="lib/jquery-3.5.1.min .js"></script>
<link rel="stylesheet" media="screen and (min-width:1024px)" href="css/main.css">
<link rel="stylesheet" media="screen and (min-width:0) and (max-width:1024px)" href="css/main_tab.css">
</head>
<c:choose>
	<c:when test="${sessionScope.user.role == 'ADMIN' }">
		<%@include file="template/header_admin.jsp" %>
	</c:when>
	<c:otherwise>
		<%@include file="template/header.jsp" %>
	</c:otherwise>
</c:choose>
<body>
<%!
	public int getMonth(){
		Date now = new Date();
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH) + 1;
		return month;
	}
%>
<div id="container">
	<p class="top" >
		<span>지역별 투어</span>
	</p>
	<a href="#" id="arrow_prev">
		<img src="img/arrow_white_left.png">
	</a>
	<div class="slider">
		<div class="slide">
			<div class="card" id="SU" >
				<p class="area">서울</p>
				<a href="areaView.do?area=SU">
					<img src="img/main/SU.jpg">
				</a>
			</div>
			<div class="card" id="GG">
				<p class="area">경기</p>
				<a href="areaView.do?area=GG">
					<img src="img/main/GG.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">부산</p>
				<a href="areaView.do?area=BS">
					<img src="img/main/BS.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">인천</p>
				<a href="areaView.do?area=IC">
					<img src="img/main/IC.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">제주</p>
				<a href="areaView.do?area=JJ">
					<img src="img/main/JJ.jpg">
				</a>
			</div>
		</div>
		<div class="slide">
			<div class="card">
				<p class="area">대구</p>
				<a href="areaView.do?area=DG">
					<img src="img/main/DG.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">대전</p>
				<a href="areaView.do?area=DJ">
					<img src="img/main/DJ.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">울산</p>
				<a href="areaView.do?area=YS">
					<img src="img/main/YS.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">강원</p>
				<a href="areaView.do?area=KW">
					<img src="img/main/KW.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">충남</p>
				<a href="areaView.do?area=CN">
					<img src="img/main/CN.jpg">
				</a>
			</div>
		</div>
		<div class="slide">
			<div class="card">
				<p class="area">경북</p>
				<a href="areaView.do?area=KB">
					<img src="img/main/KB.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">경남</p>
				<a href="areaView.do?area=KN">
					<img src="img/main/KN.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">전북</p>
				<a href="areaView.do?area=JB">
					<img src="img/main/JB.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">전남</p>
				<a href="areaView.do?area=JN">
					<img src="img/main/JN.jpg">
				</a>
			</div>
			<div class="card">
				<p class="area">광주</p>
				<a href="areaView.do?area=GJ">
					<img src="img/main/GJ.jpg">
				</a>
			</div>
		</div>
	</div>
	<a href="#" id="arrow_next">
		<img src="img/arrow_white.png">
	</a>
	<p id="popul_p" class="top">
		<span>인기투어</span>
		<select id="by">
			<option value="rating">별점순</option>
			<option value="total">좋아요순</option>
		</select>
	</p>
	<div id="popul">
		<c:forEach var="list" items="${requestScope.populList }"  varStatus="i">
			<div class="popul">
				<a href="tripDetailView.do?trip_no=${list.trip_no }" class="trip"> 
				<img alt="" src="/img/trip/${list.trip_no}.jpg">
				<div class="info">
					<small>${list.area_name}</small><br>
					<span class="title">${list.title }</span><br>
					<span class="rating">${list.rating}</span><br>
					<span class="total_like" >좋아요 : ${list.total}</span>
				</div>
				<span class="rank">${i.index+1}</span>
				</a>
			</div>
		</c:forEach>
	</div>
	<p class="top" id="mbti_rank">
		<span>${requestScope.mbti}'s choice</span>
	</p>
	<div id="mbtiTrip">
		<c:forEach var="list"  items="${requestScope.mbtiTripList}" varStatus="i">
			<div class="popul">
				<a href="tripDetailView.do?trip_no=${list.trip_no }" class="trip"> 
				<img alt="" src="/img/trip/${list.trip_no}.jpg">
				<div class="info">
					<small>${list.area_name}</small><br>
					<span class="title">${list.title }</span><br>
					<span class="rating">
						${list.rating}
					</span><br>
					<span class="total_like">${requestScope.mbti}'s 좋아요 : ${list.total }</span>
				</div>
				<span class="rank">${i.index+1}</span>
				</a>
			</div>
		</c:forEach>
	</div>
	
	<div id="active">
		<p class="top" >
			<span><%=getMonth() %>월 활동랭킹</span>
		</p>
		<table>
			<tr>
				<th>순위</th>
				<th>타입</th>
				<th></th>
			</tr>
			<c:forEach var="str" items="${requestScope.mbtiRanking }" varStatus="status">
				<tr>
					<td><c:out value="${status.index + 1}"></c:out></td>
					<td><c:out value="${str}"></c:out></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div id="dialog"  title="유저 이메일">
  		<p></p>
	</div>
</div>

</body>
<%@ include file="template/footer.jsp" %>
<script type="text/javascript" src="lib/slick.min.js"></script>
<link rel="stylesheet" href="css/slick.css">
<script
  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://code.jquery.com/git/ui/jquery-ui-git.css"></link>
<script>

// 랭킹에 st,nd,th 추가
function addTh(){
	$(".rank").eq(0).append("st");
	$(".rank").eq(1).append("nd");
	$(".rank").eq(2).append("rd");
	$(".rank").eq(3).append("th");
	$(".rank").eq(4).append("th");
}
function addTh2(){
	$(".rank").eq(5).append("st");
	$(".rank").eq(6).append("nd");
	$(".rank").eq(7).append("rd");
	$(".rank").eq(8).append("th");
	$(".rank").eq(9).append("th");
}
function addHeart(){
	// 별점 하트로 표시하기
	for(i=0; i<5; i++){
		var str="";
		var count = Math.round($(".rating").eq(i).text());
		if(count > 5) count = 5;
		for(j=0; j<count; j++){
			str = str + "💜";
		}
		for(z=0; z<5-count; z++){
			str = str + "🤍";
		}
		var rating = $(".rating").eq(i).text();
		rating = Math.min(rating,5.0);
		$(".rating").eq(i).text('별점 : ' + rating + str); 
	}
}
function addHeart2(){
	// 별점 하트로 표시하기
	for(i=5; i<10; i++){
		var str="";
		var count = Math.round($(".rating").eq(i).text());
		if(count > 5) count = 5;
		for(j=0; j<count; j++){
			str = str + "💜";
		}
		for(z=0; z<5-count; z++){
			str = str + "🤍";
		}
		var rating = $(".rating").eq(i).text();
		rating = Math.min(rating,5.0);
		$(".rating").eq(i).text('별점 : ' + $(".rating").eq(i).text() + str); 
	}
}

$(function(){
	
	addTh();addTh2();
	addHeart();addHeart2();
	
	// 슬라이드 설정
	$('.slider').slick({
		speed:700,
		autoplay:true,
		arrows:true,
		prevArrow: $('#arrow_prev'),
		nextArrow: $('#arrow_next'),
		fade:true
	});
	

	
	// header 투명도 조절
	$(window).scroll(function(){
		if($(window).scrollTop() <= 50){
			$("header").css({"opacity":1});
		}else{
			$("header").css({"opacity":0.3});
		}
	})
	$("header").mouseenter(()=>{
			$("header").css({"opacity":1});
	})
	$("header").mouseleave(()=>{
		if($(window).scrollTop()!=0){
			$("header").css({"opacity":0.3});
		}
	})
	
	$("#by").change(function(){
		if($(this).val() == "total"){
			$.ajax({
				url:"selectPopulByLike.do",
				dataType:"json",
				success:function(result){
					var list = result.list;
					var str = "";
					for(i=0; i<list.length; i++){
						str += '<div class="popul"> '
						+'<a href="tripDetailView.do?trip_no='+list[i].trip_no+'" class="trip">'
						+'<img alt="" src="/img/trip/'+list[i].trip_no+'.jpg"> '
						+'<div class="info"> '
						+'<small>'+list[i].area_name+'</small><br> '
						+'<span class="title">'+list[i].title+'</span><br>'
						+'<span class="rating">'+list[i].rating+'</span><br> '
						+'<span class="total_like" >좋아요 : '+list[i].total+'</span> '
						+'</div> <span class="rank">'+(i+1)+'</span> </a> </div>';
					}
					$("#popul").html(str);
					addTh();addHeart();
				}
			})
		}
	})
	$("#by").change(function(){
		if($(this).val() == "rating"){
			$.ajax({
				url:"selectPopulByRating.do",
				dataType:"json",
				success:function(result){
					var list = result.list;
					var str = "";
					for(i=0; i<list.length; i++){
						str += '<div class="popul"> '
						+'<a href="tripDetailView.do?trip_no='+list[i].trip_no+'" class="trip">'
						+'<img alt="" src="/img/trip/'+list[i].trip_no+'.jpg"> '
						+'<div class="info"> '
						+'<small>'+list[i].area_name+'</small><br> '
						+'<span class="title">'+list[i].title+'</span><br>'
						+'<span class="rating">'+list[i].rating+'</span><br> '
						+'<span class="total_like" >좋아요 : '+list[i].total+'</span> '
						+'</div> <span class="rank">'+(i+1)+'</span> </a> </div>';
					}
					$("#popul").html(str);
					addTh();addHeart();
				}
			})
		}
	})
	
	// 활동순위 1,2,3등 아이콘
	$("#active tr").eq(1).children("td").eq(0).html(
		'<img src="img/1st.png"></img>'		
	)
	$("#active tr").eq(2).children("td").eq(0).html(
		'<img src="img/2nd.png"></img>'		
	)
	$("#active tr").eq(3).children("td").eq(0).html(
		'<img src="img/3rd.png"></img>'		
	)
	
	// 관리자 계정일때 메일 보내기 기능 추가
	if(${sessionScope.user.role == 'ADMIN'}){
		$("#active tr").eq(1).append(
			'<td><a href="#" class="button">축하메일 보내기</a></td>'		
		)
		$("#active tr").eq(2).append(
			'<td><a href="#" class="button">축하메일 보내기</a></td>'		
		)
		$("#active tr").eq(3).append(
			'<td><a href="#" class="button">축하메일 보내기</a></td>'		
		)
	}
	
	// 축하메일 보내기
	$("#active td a").click(function(e){
		e.preventDefault();
		var index = $("#active td a").index($(this));
		var mbti = $("#active tr").eq(index+1).children("td").eq(1).text();
		mbti = mbti.substring(0,4);
		$.ajax({
			url:"getEmail.do",
			data:{mbti},
			success:function(resp){
				var str = "";
				resp = resp.replace('[',"");
				resp = resp.replace(']',"");
				var emails = resp.split(',');
				for(var e in emails){
					str += '<a href="mailto:'+emails[e]+'">'+emails[e]+'</a><br>';
				}
				$( "#dialog" ).dialog({
					modal:true
				});
				$( "#dialog p").html(str);
			}
		})
	})
	
	
	
})
</script>
</html>