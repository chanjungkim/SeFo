<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Login Box Concept</title>
  <link rel='stylesheet prefetch' href='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css'>
  <link rel="stylesheet" href="./assets/css/login.css">
  <script type="text/javascript" src="./assets/js/jquery.js"></script>
	<script type="text/javascript">
	$(function(){
		$('#btnLogin').click(function(){
			var id = $('#id').val();
			var pwd = $('#pwd').val();
			$.ajax({
				type:'post', // 요청 보내면 doPost가 실행됨
				url:'login.do', // 우리가 작성한 java 서블릿에게
				data:{'id':''+id, 'password':''+pwd}, // 검색어 데이터
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
		
		$('#btnSignup').click(function(){
			location.href="moveSignupForm.do";
		})
	})
</script>  
</head>

<body>
  <div class='brand'>
  <a href='https://www.jamiecoulter.co.uk' target='_blank'>
    <img src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/logo.png'>
  </a>
</div>
<div class='login'>
  <div class='login_title'>
    <span>Login to your account</span>
  </div>
  <div class='login_fields'>
    <div class='login_fields__user'>
      <div class='icon'>
        <img src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/user_icon_copy.png'>
      </div>
      <input placeholder='Username' type='text' id="id">
        <div class='validation'>
          <img src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/tick.png'>
        </div>
      </input>
    </div>
    <div class='login_fields__password'>
      <div class='icon'>
        <img src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/lock_icon_copy.png'>
      </div>
      <input placeholder='Password' type='password' id="pwd">
      <div class='validation'>
        <img src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/tick.png'>
      </div>
    </div>
    <div class='login_fields__submit'>
      <input id="btnLogin" type='submit' value='로그인'>
      <input id="btnSignup" style="margin-left: 8px"type='submit' value='회원가입'>
      <div class='forgot'>
        <a href='#'>Forgotten password?</a>
      </div>
    </div>
  </div>
  <div class='disclaimer'>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce semper laoreet placerat. Nullam semper auctor justo, rutrum posuere odio vulputate nec.</p>
  </div>
</div>
<div class='authent'>
  <img src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/puff.svg'>
  <p>Authenticating...</p>
</div>
<div class='love'>
  <p>Made with <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/217233/love_copy.png" /> by <a href='https://www.jamiecoulter.co.uk' target='_blank'> Jcoulterdesign </a></p>
</div>
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js'></script>

    <script  src="./assets/js/login.js"></script>

</body>
</html>
