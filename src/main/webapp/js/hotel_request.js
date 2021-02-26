$("#btn_address").click(function(){
	new daum.Postcode({
	    oncomplete: function(data) {
	        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	        // 예제를 참고하여 다양한 활용법을 확인해 보세요.
			$("#address").val(data.address);
			$("#area").val(data.sido);
	    }
	}).open();		
})

$("#btn_submit").click(function(){
	var hotel_name = $("#hotel_name").val();
	var address = $("#address").val();
	var area = $("#area").val();
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
		"area":area
	}
	$.ajax({
		method:"get",
		url:"hotelRequest.do",
		data:data,
		dataType:"json",
		success:function(response){
			alert(response.responseMessage);
		}
	})
})



