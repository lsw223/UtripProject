/**
 * 게시판 전체 글 조회
 */


// 아이디 길이, 중복 체크
	$(function() {
		$("#btn_submit").click(function(e) {
			var data = $("#search").serialize();// kind=id&name=검색어
			$.ajax({
				url : "boardSerach.do",
				data : data,
				method : 'get',
				dataType:'json',
				success : function(d) {
					console.log(d);
					var arr = d.result;
					console.log(arr);
					var result = "<table class='board'>";
					for(i=0;i<arr.length;i++){
						// 한건당 한줄씩 표현
						result += 
						"<tr><td>"+arr[i].boardNo+"</td>"
						+"<td>"+arr[i].title+"</td>"
						+"<td>"+arr[i].id+"</td>"
						+"<td>"+arr[i].writeDate+"</td>"
						+"<td>"+arr[i].boardLike+"</td>"
						+"<td>"+arr[i].boardCount+"</td></tr>";
					}
					arr += "</table>";
					$("#result_search").html(result);
					// 동적엘리먼트에 대한 이벤트 처리
				}
			});
			e.preventDefault();	
		});
	});	