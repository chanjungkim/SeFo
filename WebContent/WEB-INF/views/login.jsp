<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="EUC-KR">
<title>����ǽ�</title>
<link rel='stylesheet prefetch'
	href='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css'>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/login.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		wsocket = new WebSocket("ws://localhost:8888/chatting/echo-ws");
		wsocket.onopen = function() { //��������Ǹ� ����
// 			alert("���� ����")
		};
		$('#id').focus();

		$('body').keypress(function(e) {
			if (e.keyCode != 13)
				return;
			if (!$('input[id="id"]').val())
				$('input[id="id"]').focus();
			if (!$('input[id="pwd"]').val())
				$('input[id="pwd"]').focus();
			if ($('input[id="pwd"]').val() && $('input[id="id"]').val()) {
				$('#btnLogin').click();
			}
		})

		$('#btnLogin').click(function() {
			var id = $('#id').val();
			var pwd = $('#pwd').val();
			$.ajax({
				type : 'post', // ��û ������ doPost�� �����
				url : 'login.do', // �츮�� �ۼ��� java ��������
				data : {
					'id' : '' + id,
					'password' : '' + pwd
				}, // �˻��� ������
				dataType : 'text', // ���䵥���� ����
				success : function(resultData) {
// 					alert('login success:' + resultData);
					if (resultData == 'true') {
						location.href = "initMain.do" // �α��� �Ϸ��� �̵��� ȭ��
					} else {
						alert('�α��� ����') // �α��� ���н� �˾�
					}
				},
				error : function() {
					alert('ajax ��û ����');
				}
			})
		})

		$('#btnSignup').click(function() {
			location.href = "moveSignupForm.do";
		})

		////////////////////////////////////////////
		function sendMessage() {
			wsocket.onmessage = onMessage;
		}
		function onMessage(evt) { //�������� �޼����������� ����
			var data = evt.data;
			alert("�������� ������ ����:" + data);
		}
		function onClose(evt) { //������ ����Ǹ� ����}
			alert("���� ����");
		}
	})
</script>
</head>

<body>
	<div class='brand'>
		<a href='https://www.jamiecoulter.co.uk' target='_blank'> <img
			src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/logo.png'>
		</a>
	</div>
	<div class='login'>
		<div class='login_title'>
			<span>Login to your account</span>
		</div>
		<div class='login_fields'>
			<div class='login_fields__user'>
				<div class='icon'>
					<img
						src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/user_icon_copy.png'>
				</div>
				<%
					Cookie[] cookies = request.getCookies();

					if (cookies != null) {
						for (int i = 0; i < cookies.length; i++) {
							if (cookies[i].getName().equals("sefoId")) { // Find a cookie named as "sefoId"

								// get "sefoId" Cookie
								String cName = cookies[i].getName();

								// get the value of the Cookie
								String cValue = cookies[i].getValue();

								pageContext.setAttribute("lastId", cValue);
								break;
							}
						}
					}
				%>
				<c:choose>
					<c:when test="${lastId != null}">
						<input placeholder='Username' type='text' id="id"
							value="${lastId}">
					</c:when>
					<c:otherwise>
						<input placeholder='Username' type='text' id="id">
					</c:otherwise>
				</c:choose>
				<div class='validation'>
					<img
						src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/tick.png'>
				</div>
				</input>
			</div>
			<div class='login_fields__password'>
				<div class='icon'>
					<img
						src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/lock_icon_copy.png'>
				</div>
				<input placeholder='Password' type='password' id="pwd"
					onkeydown="onEnterSubmit()">
				<div class='validation'>
					<img
						src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/tick.png'>
				</div>
			</div>
			<div class='login_fields__submit'>
				<input id="btnLogin" type='submit' value='�α���'> <input
					id="btnSignup" style="margin-left: 8px" type='submit' value='ȸ������'>
				<div class='forgot'>
					<a href='#'>Forgotten password?</a>
				</div>
			</div>
		</div>
		<div class='disclaimer'>
			<p>SeFo���� ���ο� ģ���� ����������!</p>
			<!-- 			<h3>���� �α���</h3> -->
			<!-- 			<table border="1"> -->

			<%-- 				<c:forEach var="logInfo" items="loggedInIdList"> --%>
			<!-- 					<tr> -->
			<!-- 						<td></td> -->
			<!-- 					</tr> -->
			<%-- 				</c:forEach> --%>
			<!-- 			</table> -->
		</div>
	</div>
	<div class='authent'>
		<img
			src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/puff.svg'>
		<p>Authenticating...</p>
	</div>
	<div class='love'>
		<p>
			Made with <img
				src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/love_copy.png" />
			by <a href='https://www.jamiecoulter.co.uk' target='_blank'>
				Jcoulterdesign </a>
		</p>
	</div>
	<script
		src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script
		src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>

	<script src="./assets/js/login.js"></script>

</body>
</html>
