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
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
<script type="text/javascript">
	$(function(){
		var profileImg = new Image;
		var memberId = '${sessionScope.loginId}';
		profileImg.src = "<%=request.getContextPath()%>/assets/img/profile_pictures/" + memberId + ".JPG";
		var profileImgPath = "<%=request.getContextPath()%>/assets/img/profile_pictures/" + memberId + ".JPG";
		if (!profileImg.complete) {
			profileImgPath = "<%=request.getContextPath()%>/assets/img/profile_pictures/default_profile.JPG";
		}
		$('#top_nav_profile_img').attr('src', profileImgPath);
		
		$('#srch-term').on('keyup', function(){
			var searchWord = $(this).val();
			console.log(searchWord);
			$.ajax({
				type : 'post', // 요청 보내면 doPost가 실행됨
				url : 'search.do', // 우리가 작성한 java 서블릿에게
				data : {
					'searchWord' : searchWord // 검색어 데이터	
				},
				dataType : 'json',// 응답데이터 형식
				success : function(resultData) {
					console.log(resultData);
					$('.search-option').remove();
					var bookData='';
					for(var i=0; i<resultData.length; i++){
						bookData += '<option class="search-option" value="' +resultData[i]+ '">';
					}
// 					$.each(resultData, function(index, item) {
// 						bookData += '<option class="search-option" value="'+item+'">';
					console.log(bookData);
					$('#search-data-list').append(bookData);
				},
				error : function() {
					console.log('검색 ajax 요청 실패');
				}
			})
		})
	})

</script>
</head>
<body>
	<div id="nav-container" class="top-bar navbar navbar-static-top">
		<div class="navbar-header">
			<button class="navbar-toggle" type="button" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle</span> <span class="icon-bar"></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a href="<%=request.getContextPath()%>/initMain.do" class="navbar-brand logo">b</a>
		</div>
		<nav class="collapse navbar-collapse" role="navigation"> 
		
		<!-- Search Bar -->
		<form class="search-bar navbar-form navbar-left" action="profile.do" method="get">
			<div class="input-group input-group-sm" style="max-width: 360px;">
				<input class="form-control" placeholder="Search" name="srch-term"
					id="srch-term" type="text" list="search-data-list">
				<datalist id="search-data-list"> </datalist>
				<div class="input-group-btn">
					<button class="btn btn-default" type="submit" onClick="searchUser()">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
			</div>
		</form>
		<!-- EOF Search Bar -->

		<ul class="nav navbar-nav">
			<li><a class="profile-link" href="<%=request.getContextPath()%>/profile.do/${sessionScope.loginId}">
			<img id="top_nav_profile_img"
					class="status"
					width="20px" height="20px"> ${sessionScope.loginId}</a></li>
			<li><a href="#"><i class="glyphicon glyphicon-user"></i></a></li>
			<li><a href="#" role="button" data-toggle="modal"><i
					class="	glyphicon glyphicon-comment"></i></a></li>
			<li><a href="#"><span
					class="glyphicon glyphicon-heart-empty"></span></a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown"><i class="glyphicon glyphicon-cog"></i></a>
				<ul class="dropdown-menu">
					<li><a id="logout" href="logout.do">Log Out</a></li>
					<li><a href="">More</a></li>
					<li><a href="">More</a></li>
					<li><a href="">More</a></li>
					<li><a href="">More</a></li>
				</ul></li>
		</ul>
		</nav>
	</div>
</body>
</html>