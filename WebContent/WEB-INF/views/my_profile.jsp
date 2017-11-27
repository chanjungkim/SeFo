<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>Welcome! ${sessionScope.loginId}</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="assets/css/bootstrap.css" rel="stylesheet">
<!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<link href="assets/css/facebook.css" rel="stylesheet">
<script src="https://use.fontawesome.com/804ea8b780.js"></script>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script
	src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>
<style>
.profile {
	border-radius: 50px 50px 50px 50px;
	border-style: dotted;
	border-color: fuchsia;
	border-width: 3px;
}

.search-bar {
	margin-bottom: 0px;
	border-width: 0px;
}

.top-bar {
	height: 46px;
}

.status {
	
}

.profile-link {
	height: 43px;
}

ul {
	padding: 0px;
}

ul li {
	list-style-type: none;
}

.write-time {
	color: gray;
	font-size: 8px;
}

hr {
	margin-top: 15px;
	margin-bottom: 15px;
	margin-left: 0px;
	margin-right: 0px;
}

.comment-write-area {
	border-style: none;
	border-color: #FFF;
	width: 100%;
	height: 100%;
}

.profile-span-margin-10px {
	font-size: 17px;
	color: black;
	margin-right: 10px
}
.profile-span-margin-3px {
	font-size: 17px;
	color: black;
	margin-right: 3px
}

#comment-delete {
	color: #CCC;
	font-size: 5px;
}

#profile_img {
	border-radius: 50%;
	margin-right: 100px;
	border: 1px solid #bbb;
}

#profile-edit {
	color: black; background-color : transparent;
	border-bottom-style: solid;
	border-right-style: solid;
	border-color: #BBB;
	border-radius: 5px 5px 5px 5px;
	background-color: transparent;
}
</style>

</head>
<body>
	<c:if test="${empty sessionScope.loginId}">
		<%
			response.sendRedirect(request.getContextPath() + "/loginPageMove.do");
		%>
	</c:if>
	<c:if test="${not empty sessionScope.loginId}">

		<div class="wrapper">
			<div class="box">
				<div class="row row-offcanvas row-offcanvas-left">

					<!-- sidebar -->
					<div class="column col-sm-2 col-xs-1 sidebar-offcanvas"
						id="sidebar">

						<ul class="nav">
							<li><a href="#" data-toggle="offcanvas"
								class="visible-xs text-center"><i
									class="glyphicon glyphicon-chevron-right"></i></a></li>
						</ul>

						<ul class="nav hidden-xs" id="lg-menu">
							<li class="active"><a href="#featured"><i
									class="glyphicon glyphicon-list-alt"></i> Featured</a></li>
							<li><a href="#stories"><i
									class="glyphicon glyphicon-list"></i> Stories</a></li>
							<li><a href="#"><i class="glyphicon glyphicon-paperclip"></i>
									Saved</a></li>
							<li><a href="initMain.do"><i
									class="glyphicon glyphicon-refresh"></i> Refresh</a></li>
						</ul>
						<ul class="list-unstyled hidden-xs" id="sidebar-footer">
							<li><a href="http://usebootstrap.com/theme/facebook"><h3>Bootstrap</h3>
									<i class="glyphicon glyphicon-heart-empty"></i> Bootply</a></li>
						</ul>

						<!-- tiny only nav-->
						<ul class="nav visible-xs" id="xs-menu">
							<li><a href="#featured" class="text-center"><i
									class="glyphicon glyphicon-list-alt"></i></a></li>
							<li><a href="#stories" class="text-center"><i
									class="glyphicon glyphicon-list"></i></a></li>
							<li><a href="#" class="text-center"><i
									class="glyphicon glyphicon-paperclip"></i></a></li>
							<li><a href="initMain.do" class="text-center"><i
									class="glyphicon glyphicon-refresh"></i></a></li>
						</ul>

					</div>
					<!-- /sidebar -->

					<!-- main right col -->
					<div class="column col-sm-10 col-xs-11" id="main">

						<!-- top nav -->
						<div class="top-bar navbar navbar-blue navbar-static-top">
							<div class="navbar-header">
								<button class="navbar-toggle" type="button"
									data-toggle="collapse" data-target=".navbar-collapse">
									<span class="sr-only">Toggle</span> <span class="icon-bar"></span>
									<span class="icon-bar"></span> <span class="icon-bar"></span>
								</button>
								<a href="initMain.do" class="navbar-brand logo">b</a>
							</div>
							<nav class="collapse navbar-collapse" role="navigation">
							<form class="search-bar navbar-form navbar-left">
								<div class="input-group input-group-sm"
									style="max-width: 360px;">
									<input class="form-control" placeholder="Search"
										name="srch-term" id="srch-term" type="text">
									<div class="input-group-btn">
										<button class="btn btn-default" type="submit">
											<i class="glyphicon glyphicon-search"></i>
										</button>
									</div>
								</div>
							</form>
							<ul class="nav navbar-nav">
								<li><a class="profile-link" href="#"><img
										class="status"
										src="assets/img/profile_pictures/${sessionScope.loginId}.JPG"
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
										<li><a id="logout" href="">Log Out</a></li>
										<li><a href="">More</a></li>
										<li><a href="">More</a></li>
										<li><a href="">More</a></li>
										<li><a href="">More</a></li>
									</ul></li>
							</ul>
							</nav>
						</div>
						<!-- /top nav -->

						<div class="padding">
							<div class="full col-sm-9">
								<!-- content -->
								<div class="row">
									<div class="my_profile_img"
										style="float: left; margin-left: 80px">
										<img id="profile_img"
											src="assets/img/profile_pictures/test.JPG" width="160"
											height="160">
									</div>

									<div style="float: left;">
										<div style="margin-bottom: 10px">
											<span style="font-size: 2.0em; margin-right: 10px">Dev.goree</span>
											<button id="profile-edit">프로필 편집</button>
											<a href="#"><img src="assets/img/profile_settiong.png"
												width="30" height="30"></a>
										</div>
										<div style="margin-bottom: 15px">
											<span class="profile-span-margin-3px">게시물 </span> 
											<span class="profile-span-margin-10px" id="span_profile_article">0 </span> 
											<span class="profile-span-margin-3px">팔로워</span>
											<span class="profile-span-margin-10px" id="span_profile_follower">0</span>
											<button id="btn_profile_follow"
												style="font-size: 17px; background-color: transparent; border-style: none">팔로우</button>
										</div>
										<div>
											<span
												style="font-size: 17px; color: black; font-weight: bold;">소개글</span>
										</div>
									</div>
								</div>
								<!-- 									</div> -->
								<hr>
								<div class="row" id="footer footer-column">
									<div>
										<div class="col-sm-3">
											<ul>
												<li><a href="#">SeFo정보</a></li>
												<li><a href="#">지원</a></li>
											</ul>
										</div>
										<div class="col-sm-3">
											<ul>
												<li><a href="#">블로그</a></li>
												<li><a href="#">홍보 센터</a></li>
												<li><a href="#">채용 정보</a></li>
											</ul>
										</div>
										<div class="col-sm-3">
											<ul>
												<li><a href="#">개인정보처리방침</a></li>
												<li><a href="#">약관</a></li>
												<li><a href="#">디렉터리</a></li>
												<li><a href="#">언어</a></li>
											</ul>
										</div>
									</div>
									<div class="col-sm-3">
										<p>
											<a href="#" class="pull-right">© 2017 SeFo</a>
										</p>
									</div>
								</div>
								<hr>
								<!--<hr> -->

								<!--<h4 class="text-center"> -->
								<!--	<a href="http://usebootstrap.com/theme/facebook" target="ext">Download -->
								<!--this Template @Bootply</a> -->
								<!--</h4> -->

								<!--<hr> -->


							</div>
							<!-- /col-9 -->
						</div>
						<!-- /padding -->
					</div>
					<!-- /main -->

				</div>
			</div>
		</div>

		<script type="text/javascript" src="assets/js/jquery.js"></script>
		<script type="text/javascript" src="assets/js/bootstrap.js"></script>
		<script type="text/javascript">
			$(document)
					.ready(
							function() {
								$('[data-toggle=offcanvas]')
										.click(
												function() {
													$(this)
															.toggleClass(
																	'visible-xs text-center');
													$(this)
															.find('i')
															.toggleClass(
																	'glyphicon-chevron-right glyphicon-chevron-left');
													$('.row-offcanvas')
															.toggleClass(
																	'active');
													$('#lg-menu')
															.toggleClass(
																	'hidden-xs')
															.toggleClass(
																	'visible-xs');
													$('#xs-menu')
															.toggleClass(
																	'visible-xs')
															.toggleClass(
																	'hidden-xs');
													$('#btnShow').toggle();
												});
							});
		</script>
	</c:if>
</body>
</html>