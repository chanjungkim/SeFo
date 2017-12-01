<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div id="nav-container" class="top-bar navbar navbar-static-top">
		<div class="navbar-header">
			<button class="navbar-toggle" type="button" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle</span> <span class="icon-bar"></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a href="initMain.do" class="navbar-brand logo">b</a>
		</div>
		<nav class="collapse navbar-collapse" role="navigation"> <!-- Search Bar -->
		<form class="search-bar navbar-form navbar-left">
			<div class="input-group input-group-sm" style="max-width: 360px;">
				<input class="form-control" placeholder="Search" name="srch-term"
					id="srch-term" type="text" list="search-data-list">
				<datalist id="search-data-list"> </datalist>
				<div class="input-group-btn">
					<button class="btn btn-default" type="submit">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
			</div>
		</form>
		<!-- EOF Search Bar -->

		<ul class="nav navbar-nav">
			<li><a class="profile-link" href="myProfile.do"><img
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