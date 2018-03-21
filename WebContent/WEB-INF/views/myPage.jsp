<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>����ǽ� - ${sessionScope.loginId}</title>
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
		$('#submit').on('click',function(){
			if(${original.password} == $('#now_password').val()){
				alert($('#new_password').val()+" "+$('#confirm_password').val());
				
				if($('#new_password').val() == $('#confirm_password').val()){
					var id = '${original.id}';
					var newPw= $('#new_password').val();
					alert(id+" "+newPw);
					
					$.ajax({
						type : 'post', // ��û ������ doPost�� �����
						url : 'updatePw.do', // �츮�� �ۼ��� java ��������
						data : {
							'id' : id,
							'newPw' : newPw
						}, // �˻��� ������
						dataType : 'text', // ���䵥���� ����
						success : function(resultData) {
							alert("��й�ȣ ���� �Ϸ�");
							window.location.href="profile.do/${sessionScope.loginId}"
						},
						error : function() {
							alert('��й�ȣ ���� ajax ��û ����');
						}
					});
				}
			}else{
				alert("���� ��й�ȣ�� Ʋ�Ƚ��ϴ�.");
			}
		});
		
		$('#logoutBtn').on('click',function(){
			alert("�α׾ƿ��Ǿ����ϴ�.")
		});
		
		$('#submit2').on('click',function(){
			if($('#delete_password').val() == ${original.password}){
				var id = '${original.id}';
				var deletePw= $('#new_password').val();
				$.ajax({
					type : 'post', // ��û ������ doPost�� �����
					url : 'deleteAll.do', // �츮�� �ۼ��� java ��������
					data : {
						'id' : id,
						'deletePw' : deletePw
					}, // �˻��� ������
					dataType : 'text', // ���䵥���� ����
					success : function(resultData) {
						alert("ȸ��Ż��  �Ϸ�");
						window.location.href="logout.do"
					},
					error : function() {
						alert('ȸ��Ż�� ajax ��û ����');
					}
				});
			}
			return false;
		})
	});
</script>
<style type="text/css">
table {
	width: 100%;
	height: 100%;
	border-color: #FFF;
}

.panel-info {
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
									<li><a href="" data-target-id="deleteUser"><i
											class="glyphicon glyphicon-user"></i>Delete</a></li>
									<li><a href="" data-toggle="modal" data-target=".bs-example-modal-sm"
										data-target=".bs-example-modal-sm"><i
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
														<option id=aaa value="��" selecter>��</option>
														<option id=aaa value="��" selecter>��</option>
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

							<div class="col-md-9  admin-content" id="change-password">
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
													id="now_password">
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
												<input type="button" class="form-control btn btn-primary"
													name="submit" id="submit" value="����">
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="col-md-9  admin-content" id="deleteUser">
								<div class="panel panel-info" style="margin: 1em;">
									<div class="panel-heading">
										<h3 class="panel-title">
											<label for="new_password" class="control-label panel-title">��й�ȣ�� �Է��Ͻÿ�</label>
										</h3>
									</div>
									<div class="panel-body">
										<div class="form-group">
											<div class="col-sm-10">
												<input type="password" class="form-control" name="password"
													id="delete_password">
											</div>
										</div>

									</div>
								</div>											
								<div class="panel panel-info border" style="margin: 1em;">
									<div class="panel-body">
										<div class="form-group">
											<div class="pull-left">
												<input type="button" class="form-control btn btn-primary"
													name="submit" id="submit2" value="ȸ��Ż��">
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div id="logout" class="modal bs-example-modal-sm" tabindex="-1"
								role="dialog" aria-hidden="true">
								<div class="modal-dialog modal-sm">
									<div class="modal-content">
										<div class="modal-header">
											<h4>
												Logout <i class="fa fa-lock"></i>
											</h4>
										</div>
										<div class="modal-body">
											<i class="fa fa-question-circle"></i> ������ ��������?:(
										</div>
										<div class="modal-footer">
											<a href="logout.do" class="btn btn-primary btn-block">Logout</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</body>