<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="assets/css/sefo.css" rel="stylesheet">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function() {
		var navItems = $('.admin-menu li > a');
		var navListItems = $('.admin-menu li');
		var allWells = $('.admin-content');
		var allWellsExceptFirst = $('.admin-content:not(:first)');
		allWellsExceptFirst.hide();
		navItems.click(function(e) {
			e.preventDefault();
			navListItems.removeClass('active');
			$(this).closest('li').addClass('active');
			allWells.hide();
			var target = $(this).attr('data-target-id');
			$('#' + target).show();
		});


	});
</script>
<style type="text/css">
table {
	width: 100%;
	height: 100%;
	border-color: #FFF;
}
.panel-info{
	border-color: #FFF;
}

#aaa {
	font-size: 20px;
	font-family: sans-serif;
	font-weight: 900;
}

.profile-container {
	border-style: solid;
	border-width: 1px;
	border-color: grey;
	padding: 20px;
}

</style>
</head>
<body>
	<div class="wrapper">
		<div class="box">
			<div class="row row-offcanvas">
				<div class="column col-sm-12" id="main">
					<!-- top nav -->
					<jsp:include page="${request.getContextPath()}/topNav.jsp" />
					<!-- /top nav -->
					<div class="container profile-container">

						<div class="row">

							<div class="col-md-3 sidebar">
								<ul class="nav nav-pills nav-stacked admin-menu">
									<li class="active"><a href="" data-target-id="profile"><i
											class="glyphicon glyphicon-user"></i>Profile</a></li>
									<li><a href="" data-target-id="change-password"><i
											class="glyphicon glyphicon-lock"></i>Change Password</a></li>
									<li><a href="" data-target-id="settings"><i
											class="glyphicon glyphicon-cog"></i>Settings</a></li>
									<li><a href="" data-target-id="logout"><i
											class="glyphicon glyphicon-log-out"></i>Logout</a></li>
								</ul>
							</div>

							<div class="col-md-9  admin-content" id="profile">
								<div class="panel panel-info">
									<form action="updateProfile.do" method="post">
										<table>
											<tr class="panel panel-info">
												<td class="panel-body"><h3 class="panel-title">�̸�</h3></td>
												<td><input id=aaa type="text" name="name"
													value="${original.name}"></td>
											</tr>
											<tr class="panel panel-info">
												<td class="panel-body"><h3 class="panel-title">�ڱ�Ұ�</h3></td>
												<td><input id=aaa type="textarea" name="self_info"
													value="${original.self_info}"></td>
											</tr>
											<tr class="panel panel-info">
												<td class="panel-body"><h3 class="panel-title">�̸���</h3></td>
												<td><input id=aaa type="text" name="email"
													value="${original.email}"></td>
											</tr>
											<tr class="panel panel-info">
												<td class="panel-body"><h3 class="panel-title">��ȭ��ȣ</h3></td>
												<td><input id=aaa type="text" name="phone"
													value="${original.phone}"></td>
											</tr>
											<tr class="panel panel-info">
												<td class="panel-body"><h3 class="panel-title">����</h3></td>
												<td><select class="panel-body">
														<option id=aaa value="����" selecter>����</option>
														<option id=aaa value="����" selecter>����</option>
												</select></td>
											</tr>
											<tr class="panel panel-info">

												<td class="panel-body"><input id=aaa type="hidden"
													name="id" value="${original.id}"> <input
													class="btn btn-primary" type="submit" value="����"></td>
											</tr>
										</table>
									</form>
								</div>
							</div>
							<div class="col-md-9  admin-content" id="settings">
								<div class="panel panel-info">
									<div class="panel-heading">
										<h3 class="panel-title">Notification</h3>
									</div>
									<div class="panel-body">
										<div class="label label-success">allowed</div>
									</div>
								</div>
								<div class="panel panel-info" >
									<div class="panel-heading">
										<h3 class="panel-title">Newsletter</h3>
									</div>
									<div class="panel-body">
										<div class="badge">Monthly</div>
									</div>
								</div>
								<div class="panel panel-info" >
									<div class="panel-heading">
										<h3 class="panel-title">Admin</h3>

									</div>
									<div class="panel-body">
										<div class="label label-success">yes</div>
									</div>
								</div>

							</div>

							<div class="col-md-9  admin-content" id="change-password">
								<form action="/password" method="post">


									<div class="panel panel-info" style="margin: 1em;">
										<div class="panel-heading">
											<h3 class="panel-title">
												<label for="new_password" class="control-label panel-title">����
													��й�ȣ</label>
											</h3>
										</div>
										<div class="panel-body">
											<div class="form-group">
												<div class="col-sm-10">
													<input type="password" class="form-control" name="password"
														id="new_password">
												</div>
											</div>

										</div>
									</div>
									<div class="panel panel-info" style="margin: 1em;">
										<div class="panel-heading">
											<h3 class="panel-title">
												<label for="new_password" class="control-label panel-title">New
													Password</label>
											</h3>
										</div>
										<div class="panel-body">
											<div class="form-group">
												<div class="col-sm-10">
													<input type="password" class="form-control" name="password"
														id="new_password">
												</div>
											</div>

										</div>
									</div>


									<div class="panel panel-info" style="margin: 1em;">
										<div class="panel-heading">
											<h3 class="panel-title">
												<label for="confirm_password"
													class="control-label panel-title">Confirm password</label>
											</h3>
										</div>
										<div class="panel-body">
											<div class="form-group">
												<div class="col-sm-10">
													<input type="password" class="form-control"
														name="password_confirmation" id="confirm_password">
												</div>
											</div>
										</div>
									</div>


									<div class="panel panel-info border" style="margin: 1em;">
										<div class="panel-body">
											<div class="form-group">
												<div class="pull-left">
													<input type="submit" class="form-control btn btn-primary"
														name="submit" id="submit">
												</div>
											</div>
										</div>
									</div>

								</form>
							</div>

							<div class="col-md-9  admin-content" id="settings"></div>

							<div class="col-md-9  admin-content" id="logout">
								<div class="panel panel-info" style="margin: 1em;">
									<div class="panel-heading">
										<h3 class="panel-title">Confirm Logout</h3>
									</div>
									<div class="panel-body">
										Do you really want to logout ?<a href="#"
											class="label label-danger"
											onclick="event.preventDefault();
                                                     document.getElementById('logout-form').submit();">
											<span>Yes</span>
										</a><a href="/account" class="label label-success"><span>No</span></a>
									</div>
									<form id="logout-form" action="#" method="POST"
										style="display: none;"></form>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>