<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=EUC-KR">
<meta charset="EUC-KR">
<title>Facebook Theme Demo</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="assets/css/bootstrap.css" rel="stylesheet">
<!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<link href="assets/css/facebook.css" rel="stylesheet">
</head>

<body>
	<c:if test="${empty sessionScope.loginEmail}">
		<%
			response.sendRedirect(request.getContextPath() + "/loginPageMove.do");
		%>
	</c:if>
	<div class="wrapper">
		<div class="box">
			<div class="row row-offcanvas row-offcanvas-left">

				<!-- sidebar -->
				<div class="column col-sm-2 col-xs-1 sidebar-offcanvas" id="sidebar">

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
						<li><a href="#"><i class="glyphicon glyphicon-refresh"></i>
								Refresh</a></li>
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
						<li><a href="#" class="text-center"><i
								class="glyphicon glyphicon-refresh"></i></a></li>
					</ul>

				</div>
				<!-- /sidebar -->

				<!-- main right col -->
				<div class="column col-sm-10 col-xs-11" id="main">

					<!-- top nav -->
					<div class="navbar navbar-blue navbar-static-top">
						<div class="navbar-header">
							<button class="navbar-toggle" type="button"
								data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle</span> <span class="icon-bar"></span>
								<span class="icon-bar"></span> <span class="icon-bar"></span>
							</button>
							<a href="http://usebootstrap.com/theme/facebook"
								class="navbar-brand logo">b</a>
						</div>
						<nav class="collapse navbar-collapse" role="navigation">
						<form class="navbar-form navbar-left">
							<div class="input-group input-group-sm" style="max-width: 360px;">
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
							<li><a href="#"><i class="glyphicon glyphicon-home"></i>
									Home</a></li>
							<li><a href="#postModal" role="button" data-toggle="modal"><i
									class="glyphicon glyphicon-plus"></i> Post</a></li>
							<li><a href="#"><span class="badge">badge</span></a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i></a>
								<ul class="dropdown-menu">
									<li><a href="">More</a></li>
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

								<!-- main col left -->
								<div class="col-sm-5">

									<div class="well">
										<form class="form-horizontal" role="form">
											<h4>What's New</h4>
											<div class="form-group" style="padding: 14px;">
												<textarea class="form-control"
													placeholder="Update your status"></textarea>
											</div>
											<button class="btn btn-primary pull-right" type="button">Post</button>
											<ul class="list-inline">
												<li><a href=""><i
														class="glyphicon glyphicon-upload"></i></a></li>
												<li><a href=""><i
														class="glyphicon glyphicon-camera"></i></a></li>
												<li><a href=""><i
														class="glyphicon glyphicon-map-marker"></i></a></li>
											</ul>
										</form>
									</div>

									<div class="panel panel-default">
										<div class="panel-thumbnail">
											<img src="assets/img/bg_5.jpg" class="img-responsive">
										</div>
										<div class="panel-body">
											<p class="lead">Urbanization</p>
											<p>45 Followers, 13 Posts</p>

											<p>
												<img src="assets/img/uFp_tsTJboUY7kue5XAsGAs28.png"
													height="28px" width="28px">
											</p>
										</div>
									</div>


									<div class="panel panel-default">
										<div class="panel-heading">
											<a href="#" class="pull-right">View all</a>
											<h4>Bootstrap Examples</h4>
										</div>
										<div class="panel-body">
											<div class="list-group">
												<a href="http://usebootstrap.com/theme/facebook"
													class="list-group-item">Modal / Dialog</a> <a
													href="http://usebootstrap.com/theme/facebook"
													class="list-group-item">Datetime Examples</a> <a
													href="http://usebootstrap.com/theme/facebook"
													class="list-group-item">Data Grids</a>
											</div>
										</div>
									</div>


									<div class="panel panel-default">
										<div class="panel-heading">
											<a href="#" class="pull-right">View all</a>
											<h4>More Templates</h4>
										</div>
										<div class="panel-body">
											<img src="assets/img/150x150.gif"
												class="img-circle pull-right"> <a href="#">Free
												@Bootply</a>
											<div class="clearfix"></div>
											There a load of new free Bootstrap 3 ready templates at
											Bootply. All of these templates are free and don't require
											extensive customization to the Bootstrap baseline.
											<hr>
											<ul class="list-unstyled">
												<li><a href="http://usebootstrap.com/theme/facebook">Dashboard</a></li>
												<li><a href="http://usebootstrap.com/theme/facebook">Darkside</a></li>
												<li><a href="http://usebootstrap.com/theme/facebook">Greenfield</a></li>
											</ul>
										</div>
									</div>

									<div class="panel panel-default">
										<div class="panel-heading">
											<h4>What Is Bootstrap?</h4>
										</div>
										<div class="panel-body">Bootstrap is front end
											frameworkto build custom web applications that are fast,
											responsive &amp; intuitive. It consist of CSS and HTML for
											typography, forms, buttons, tables, grids, and navigation
											along with custom-built jQuery plug-ins and support for
											responsive layouts. With dozens of reusable components for
											navigation, pagination, labels, alerts etc..</div>
									</div>



								</div>

								<!-- main col right -->
								<div class="col-sm-7">

									<div class="well">
										<form class="form">
											<h4>Sign-up</h4>
											<div class="input-group text-center">
												<input class="form-control input-lg"
													placeholder="Enter your email address" type="text">
												<span class="input-group-btn"><button
														class="btn btn-lg btn-primary" type="button">OK</button></span>
											</div>
										</form>
									</div>

									<div class="panel panel-default">
										<div class="panel-heading">
											<a href="#" class="pull-right">View all</a>
											<h4>Bootply Editor &amp; Code Library</h4>
										</div>
										<div class="panel-body">
											<p>
												<img src="assets/img/150x150.gif"
													class="img-circle pull-right"> <a href="#">The
													Bootstrap Playground</a>
											</p>
											<div class="clearfix"></div>
											<hr>
											Design, build, test, and prototype using Bootstrap in
											real-time from your Web browser. Bootply combines the power
											of hand-coded HTML, CSS and JavaScript with the benefits of
											responsive design using Bootstrap. Find and showcase
											Bootstrap-ready snippets in the 100% free Bootply.com code
											repository.
										</div>
									</div>

									<div class="panel panel-default">
										<div class="panel-heading">
											<a href="#" class="pull-right">View all</a>
											<h4>Stackoverflow</h4>
										</div>
										<div class="panel-body">
											<img src="assets/img/150x150.gif"
												class="img-circle pull-right"> <a href="#">Keyword:
												Bootstrap</a>
											<div class="clearfix"></div>
											<hr>

											<p>
												If you're looking for help with Bootstrap code, the
												<code>twitter-bootstrap</code>
												tag at <a
													href="http://stackoverflow.com/questions/tagged/twitter-bootstrap">Stackoverflow</a>
												is a good place to find answers.
											</p>

											<hr>
											<form>
												<div class="input-group">
													<div class="input-group-btn">
														<button class="btn btn-default">+1</button>
														<button class="btn btn-default">
															<i class="glyphicon glyphicon-share"></i>
														</button>
													</div>
													<input class="form-control" placeholder="Add a comment.."
														type="text">
												</div>
											</form>

										</div>
									</div>

									<div class="panel panel-default">
										<div class="panel-heading">
											<a href="#" class="pull-right">View all</a>
											<h4>Portlet Heading</h4>
										</div>
										<div class="panel-body">
											<ul class="list-group">
												<li class="list-group-item">Modals</li>
												<li class="list-group-item">Sliders / Carousel</li>
												<li class="list-group-item">Thumbnails</li>
											</ul>
										</div>
									</div>

									<div class="panel panel-default">
										<div class="panel-thumbnail">
											<img src="assets/img/bg_4.jpg" class="img-responsive">
										</div>
										<div class="panel-body">
											<p class="lead">Social Good</p>
											<p>1,200 Followers, 83 Posts</p>

											<p>
												<img src="assets/img/photo.jpg" height="28px" width="28px">
												<img src="assets/img/photo.png" height="28px" width="28px">
												<img src="assets/img/photo_002.jpg" height="28px"
													width="28px">
											</p>
										</div>
									</div>

								</div>
							</div>
							<!--/row-->

							<div class="row">
								<div class="col-sm-6">
									<a href="#">Twitter</a> <small class="text-muted">|</small> <a
										href="#">Facebook</a> <small class="text-muted">|</small> <a
										href="#">Google+</a>
								</div>
							</div>

							<div class="row" id="footer">
								<div class="col-sm-6"></div>
								<div class="col-sm-6">
									<p>
										<a href="#" class="pull-right">Copyright 2013</a>
									</p>
								</div>
							</div>

							<hr>

							<h4 class="text-center">
								<a href="http://usebootstrap.com/theme/facebook" target="ext">Download
									this Template @Bootply</a>
							</h4>

							<hr>


						</div>
						<!-- /col-9 -->
					</div>
					<!-- /padding -->
				</div>
				<!-- /main -->

			</div>
		</div>
	</div>


	<!--post modal-->
	<div id="postModal" class="modal fade" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true"></button>
					Update Status
				</div>
				<div class="modal-body">
					<form class="form center-block">
						<div class="form-group">
							<textarea class="form-control input-lg" autofocus=""
								placeholder="What do you want to share?"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<div>
						<button class="btn btn-primary btn-sm" data-dismiss="modal"
							aria-hidden="true">Post</button>
						<ul class="pull-left list-inline">
							<li><a href=""><i class="glyphicon glyphicon-upload"></i></a></li>
							<li><a href=""><i class="glyphicon glyphicon-camera"></i></a></li>
							<li><a href=""><i class="glyphicon glyphicon-map-marker"></i></a></li>
						</ul>
					</div>
				</div>
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
														.toggleClass('active');
												$('#lg-menu').toggleClass(
														'hidden-xs')
														.toggleClass(
																'visible-xs');
												$('#xs-menu').toggleClass(
														'visible-xs')
														.toggleClass(
																'hidden-xs');
												$('#btnShow').toggle();
											});
						});
	</script>
</body>
</html>