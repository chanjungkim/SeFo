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
	font-size: 16px;
	color: black;
	margin-right: 10px
}

.profile-span-margin-3px {
	font-size: 16px;
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
	border: 0.5px solid #aaa;
}

#profile-edit {
	color: black;
	background-color: transparent;
	border-bottom-style: solid;
	border-right-style: solid;
	border-color: #BBB;
	border-radius: 5px 5px 5px 5px;
	background-color: transparent;
}

#div_midle {
	
}

img {
	display: block;
}

.gallery {
	position: relative;
	z-index: 2;
	padding: 10px;
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-flow: row wrap;
	flex-flow: row wrap;
	-webkit-box-pack: justify;
	-ms-flex-pack: justify;
	/*           justify-content: space-between; */
	-webkit-transition: all .5s ease-in-out;
	transition: all .5s ease-in-out;
}

.gallery figure {
	-ms-flex-preferred-size: 33.333%;
	flex-basis: 33.333%;
	padding: 15px;
	overflow: hidden;
	cursor: pointer;
}

.gallery figure img {
	width: 100%;
	-webkit-transition: all .3s ease-in-out;
	transition: all .3s ease-in-out;
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
					<%-- 					<jsp:include page="${request.getContextPath()}/sidebar.jsp" />  --%>
					<!-- /sidebar -->

					<!-- main right col -->
					<div class="column col-sm-12 col-xs-11" id="main">

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
								<div style="margin: auto; max-width: 1000px;">
									<!-- content -->
									<div class="row">
										<div class="my_profile_img col-md-4 img-fluid"
											style="margin: auto; width: auto; max-height: 100%; margin-left: 80px; margin-right: 80px;">
											<img id="profile_img"
												src="assets/img/profile_pictures/test.JPG"
												style="width: 160px; height: 160px; margin: 0px">
										</div>
										<div class="col-md-8"
											style="margin: auto; width: auto; max-height: 100%;">
											<div class="row"
												style="display: flex; align-items: center; align-self: center; margin-top: 10px;">
												<div
													style="font-size: 30px; margin-right: 10px; float: left;">${memberVO.id }</div>

												<div class="row"
													style="float: left; display: flex; align-items: center;">
													<button id="profile-edit" style="float: left;">프로필편집</button>
													<a href="#"><img src="assets/img/profile_settiong.png"
														style="width: 30px; height: 30px; float: left; vertical-align: bottom;"></a>
												</div>
											</div>
											<div class="row" style="margin-top: 10px;">
												<span class="profile-span-margin-3px">게시물 </span> <span
													class="profile-span-margin-10px" id="span_profile_article">${totalContentCnt}
												</span> <span class="profile-span-margin-3px">팔로워</span> <span
													class="profile-span-margin-10px" id="span_profile_follower">${memberVO.follower_count}</span>
												<button id="btn_profile_follow"
													style="font-size: 16px; background-color: transparent; border-style: none">팔로우
													${memberVO.follow_count}</button>
											</div>
											<div
												style="font-size: 15px; color: black; font-weight: bold; margin-top: 10px;">${memberVO.self_info }</div>
										</div>
									</div>
									<div class="gallery" style="margin-top: 15px">
										<c:forEach items="${articleList}" var="articleVO">
											<figure> <img
												src=${articleVO.getPhotoList().get(0).file_origiName }> </figure>
										</c:forEach>
									</div>
								</div>
								<!-- 									</div> -->
								<hr>
								<jsp:include page="${request.getContextPat()}/footer.jsp" />
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