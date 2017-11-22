<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<title>비밀의숲 메인</title>
<link rel="stylesheet" href="assets/css/login.css">

<script type="text/javascript" src="./assets/js/jquery.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btnLogin').click(function(){
			var email = $('#email').val();
			var pwd = $('#pwd').val();
			$.ajax({
				type:'post', // 요청 보내면 doPost가 실행됨
				url:'login.do', // 우리가 작성한 java 서블릿에게
				data:{'email':''+email, 'password':''+pwd}, // 검색어 데이터
				dataType: 'text',// 응답데이터 형식
				success: function(resultData){
					
					if(resultData == 'true'){
						location.href="initMain.do" // 로그인 완료후 이동할 화면
					}else{
						alert('로그인 실패')// 로그인 실패시 팝업
					}
				},
				error : function() {
					alert('ajax 요청 실패');
				}
			})
		})
	})
</script>
</head>
<body>
	<div class="cotn_principal">
		<div class="cont_centrar">
			<div class="cont_login">
				<div class="cont_info_log_sign_up">
					<div class="col_md_login">
						<div class="cont_ba_opcitiy">
							<h2>LOGIN</h2>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
							<button class="btn_login" onclick="cambiar_login()">LOGIN</button>
						</div>
					</div>
					<div class="col_md_sign_up">
						<div class="cont_ba_opcitiy">
							<h2>SIGN UP</h2>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
							<button class="btn_sign_up" onclick="cambiar_sign_up()">SIGN
								UP</button>
						</div>
					</div>
				</div>
				<div class="cont_back_info">
					<div class="cont_img_back_grey">
						<img
							src="https://images.unsplash.com/42/U7Fc1sy5SCUDIu4tlJY3_NY_by_PhilippHenzler_philmotion.de.jpg?ixlib=rb-0.3.5&q=50&fm=jpg&crop=entropy&s=7686972873678f32efaf2cd79671673d"
							alt="" />
					</div>
				</div>
				<div class="cont_forms">
					<div class="cont_img_back_">
						<img
							src="https://images.unsplash.com/42/U7Fc1sy5SCUDIu4tlJY3_NY_by_PhilippHenzler_philmotion.de.jpg?ixlib=rb-0.3.5&q=50&fm=jpg&crop=entropy&s=7686972873678f32efaf2cd79671673d"
							alt="" />
					</div>
					<div class="cont_form_login">
						<a href="#" onclick="ocultar_login_sign_up()"><i
							class="material-icons">&#xE5C4;</i></a>
						<h2>LOGIN</h2>
						<input type="text" placeholder="Email" id="email"/> 
						<input type="password"placeholder="Password" id="pwd"/>
						<button id="btnLogin" class="btn_login" onclick="cambiar_login()">LOGIN</button>
					</div>

					<div class="cont_form_sign_up">
						<a href="#" onclick="ocultar_login_sign_up()"><i
							class="material-icons">&#xE5C4;</i></a>
						<h2>SIGN UP</h2>
						<input type="text" placeholder="Email" /> <input type="text"
							placeholder="User" /> <input type="password"
							placeholder="Password" /> <input type="password"
							placeholder="Confirm Password" />
						<button class="btn_sign_up" onclick="cambiar_sign_up()">SIGN
							UP</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="assets/js/login.js"></script>
</html>