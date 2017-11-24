<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>����ǽ� ȸ������</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet prefetch'
	href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>
<link rel="stylesheet" href="./assets/css/signup.css">
<script type="text/javascript" src="./assets/js/jquery.js"></script>
<script type="text/javascript">
	$(function(){
		$('#duplicate-check-button').click(function(){
			var id = $('#input-id').val();
			$.ajax({
				type:'post', // ��û ������ doPost�� �����
				url:'overlab-check.do', // �츮�� �ۼ��� java ��������
				data:{'id':''+id}, // �˻��� ������
				dataType: 'text',// ���䵥���� ����
				success: function(resultData){
					
					if(resultData == 'true'){
						alert('��� ������ ���̵� �Դϴ�.')// �α��� ���н� �˾�
					}else{
						alert('�̹� �����ϴ� ���̵� �Դϴ�.')// �α��� ���н� �˾�
					}
				},
				error : function() {
					alert('ajax ��û ����');
				}
			})
		})
		
	})
function checkIn() {
		///////////���� ó�� �ؾ��ϴ� �κ�

}
</script>
</head>
<body>
	<div class="container">
		<h2>����� �� ȸ������</h2>
		<form action="signup.do" method="post" onsubmit="return checkIn();">
			<div class="row">
				<h4>����</h4>
				<div id="inputId" class="input-group input-group-icon input-harf">
					<input id="input-id" type="text" placeholder="���̵�" maxlength="20" name="id"/>
					<span class="input-icon"><i style="margin-top: 18px"
						class="fa fa-user"></i></span> <input id="duplicate-check-button"
						style="padding-left: 15px; color: #ffffff" type="button"
						value="�ߺ� Ȯ��">
				</div>
				<div class="input-group input-group-icon">
					<input type="password" placeholder="��й�ȣ" maxlength="20" name="password"/>
					<div class="input-icon">
						<i style="margin-top: 18px" class="fa fa-key"></i>
					</div>
				</div>
				<div class="input-group input-group-icon">
					<input type="password" placeholder="��й�ȣ Ȯ��" maxlength="20" />
					<div class="input-icon">
						<i style="margin-top: 18px" class="fa fa-key"></i>
					</div>
				</div>
				<div class="input-group input-group-icon">
					<input type="text" placeholder="�̸�" name="name" />
					<div class="input-icon">
						<i style="margin-top: 18px" class="fa fa-tag"></i>
					</div>
				</div>
				<div class="input-group input-group-icon">
					<input type="email" placeholder="�̸���" maxlength="30" name="email"/>
					<div class="input-icon">
						<i style="margin-top: 18px" class="fa fa-envelope"></i>
					</div>
				</div>

			</div>
			<div class="row">
				<div class="col-half">
					<h4>����</h4>
					<div class="input-group">
						<div class="col-third">
							<input type="text" placeholder="YYYY" maxlength="4" name="birth_year"/>
						</div>
						<div class="col-third">
							<input type="text" placeholder="MM" maxlength="2" name="birth_month"/>
						</div>
						<div class="col-third">
							<input type="text" placeholder="DD" maxlength="2" name="birth_day"/>
						</div>
					</div>
				</div>
				<div class="col-half">
					<h4>����</h4>
					<div class="input-group">
						<input type="radio" name="gender" value="��" id="gender-male" />
						<label for="gender-male">����</label> <input type="radio"
							name="gender" value="��" id="gender-female" /> <label
							for="gender-female">����</label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-half">
					<h4>�ڵ���</h4>
					<div class="input-group ">
						<div class="col-third">
							<input type="text" placeholder="000" maxlength="3" name="phone_1"/>
						</div>
						<div class="col-third">
							<input type="text" placeholder="0000" maxlength="4" name="phone_2"/>
						</div>
						<div class="col-third">
							<input type="text" placeholder="0000" maxlength="4" name="phone_3"/>
						</div>
					</div>
				</div>
				<div clas="col-half">
					<input style="color: #ffffff; float: right;" type="submit"
						value="ȸ�� ����">
				</div>
			</div>
		</form>
	</div>
	<script
		src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
</body>
</html>