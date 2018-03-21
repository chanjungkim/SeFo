<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="EUC-KR">
<title>비밀의숲</title>
<link rel='stylesheet prefetch'
	href='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css'>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/login.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		wsocket = new WebSocket("ws://localhost:8888/chatting/echo-ws");
		wsocket.onopen = function() { //서버연결되면 실행
// 			alert("세션 연결")
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
				type : 'post', // 요청 보내면 doPost가 실행됨
				url : 'login.do', // 우리가 작성한 java 서블릿에게
				data : {
					'id' : '' + id,
					'password' : '' + pwd
				}, // 검색어 데이터
				dataType : 'text', // 응답데이터 형식
				success : function(resultData) {
// 					alert('login success:' + resultData);
					if (resultData == 'true') {
						location.href = "initMain.do" // 로그인 완료후 이동할 화면
					} else {
						alert('로그인 실패') // 로그인 실패시 팝업
					}
				},
				error : function() {
					alert('ajax 요청 실패');
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
		function onMessage(evt) { //서버에서 메세지를받으면 실행
			var data = evt.data;
			alert("서버에서 데이터 받음:" + data);
		}
		function onClose(evt) { //연결이 종료되면 실행}
			alert("연결 끊김");
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
				<input id="btnLogin" type='submit' value='로그인'> <input
					id="btnSignup" style="margin-left: 8px" type='submit' value='회원가입'>
				<div class='forgot'>
					<a href='#'>Forgotten password?</a>
				</div>
			</div>
		</div>
		<div class='disclaimer'>
			<p>SeFo에서 새로운 친구를 만나보세요!</p>
			<!-- 			<h3>지난 로그인</h3> -->
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
