/*댓글추가*/
$(function() {
		$(".comment_form textarea").keyup(function() {
			$(this).next().text($(this).val().length + "/500");
		});
		$(".comment_form button").click(function() {
			var data = $("#comment").serialize();
			$.ajax({
				url : "insertComment.do",
				data : data,
				method : "get",
				success : function(d) {
					alert("댓글 등록 성공 : " + d);
					location.reload();
				}
			});
		});
		/*좋아요 추가*/
		$(".btn_like").click(
				function() {
					var obj = $(this);
					d = "boardno=${requestScope.board.boardNo}&mode="
							+ $(this).index();
					console.log(d);
					$.ajax({
						url : "plusLike.do",
						data : d,
						method : "get",
						success : function(result) {
							result = result.trim();
							if (result == "false") {
								alert("로그인후 이용하실 수 있습니다.");
								location.href = "loginView.do";
							}
							console.log(result, result.length);
							$(obj).children("span").html(result);

						},
						error : function(request, status, error) {
							alert(request.responseText.trim());
						}
					});
				});
	});

/*if(${sessionScope.user==null  || sessionScope.user.role!='ADMIN'}){
	location.href="/";
}

$("#user").click(function(){
	$("#user_dropdown").toggleClass("hidden");
})
*/