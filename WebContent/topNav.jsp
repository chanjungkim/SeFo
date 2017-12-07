<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script
	src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
<script type="text/javascript">
$(function() {
	$('#srch-term').on('keyup', function() {
				var searchWord = $(this).val();
				$.ajax({
						type : 'post', // 요청 보내면 doPost가 실행됨
						url : 'search.do', // 우리가 작성한 java 서블릿에게
						data : {
							'searchWord' : searchWord
						// 검색어 데이터	
						},
						dataType : 'json', // 응답데이터 형식
						success : function(resultData) {
							console.log(resultData);
							$('.search-option').remove();
							var bookData = '';
							for (var i = 0; i < resultData.length; i++) {
								bookData += '<option class="search-option" value="' + resultData[i] + '" onclick="showMsg()" data-countries="'+ resultData[i]+'">';
							}
							console.log(bookData);
							$('#search-data-list')	.append(bookData);
						},
						error : function() {
							console.log('검색 ajax 요청 실패');
						}
					})
	})
	$(document).on('click', '#search-button', function(){
		var searchWord = $('#srch-term').val();
		
		window.location.href = '<%=request.getContextPath()%>/profile.do/'+searchWord;
	});
function showMsg(){
	var ctry = T.getAttribute("data-countries");
  	 alert("The " + T.innerHTML + " is  " + ctry + ".");	
}
// 	$('.search-option').bind('select', function(){
// 		alert("clicked");
// 	});
})
</script>
</head>
<body>
	<div id="nav-container" class="top-bar navbar navbar-static-top">
		<div class="navbar-header col-md-3">
			<button class="navbar-toggle" type="button" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle</span> <span class="icon-bar"></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a href="<%=request.getContextPath()%>/initMain.do"
				class="navbar-brand logo">Secret Forest</a>
		</div>
		<!-- Search Bar -->
		<div class="col-md-6">
			<div class="input-group input-group-sm" style="max-width: 360px;">
				<input class="form-control" placeholder="Search" name="srch-term"
					id="srch-term" type="text" list="search-data-list">
				<!-- Data List -->
				<datalist id="search-data-list">
				</datalist>
				<!-- EO Data List -->
				<div class="input-group-btn">
					<button id = "search-button" class="btn btn-default" >
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
			</div>
		</div>
		<!-- EOF Search Bar -->
		<div class="col-md-3">
			<ul class="nav navbar-nav">
				<li><a class="profile-link"
					href="<%=request.getContextPath()%>/profile.do/${sessionScope.loginId}"><img
						src="<%=request.getContextPath()%>/assets/img/icon/user.png"
						class="top-nav-icon"></a></li>
				<li><a href="#" role="button" data-toggle="modal"><img
						src="<%=request.getContextPath()%>/assets/img/icon/message.png"
						class="top-nav-icon"></a></li>
				<li><a href="#"><img class="top-nav-icon"
						src="<%=request.getContextPath()%>/assets/img/icon/heart.png"></a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown"><i class="glyphicon glyphicon-cog"></i></a>
				<ul class="dropdown-menu">
					<li><a id="logout"
						href="<%=request.getContextPath()%>/logout.do">Log Out</a></li>
					<li><a href="">More</a></li>
				</ul></li>
		</ul>
		</div>
	</div>
</body>
</html>