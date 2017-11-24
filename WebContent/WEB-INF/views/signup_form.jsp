<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>비밀의숲 회원가입</title>
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
				type:'post', // 요청 보내면 doPost가 실행됨
				url:'overlab-check.do', // 우리가 작성한 java 서블릿에게
				data:{'id':''+id}, // 검색어 데이터
				dataType: 'text',// 응답데이터 형식
				success: function(resultData){
					
					if(resultData == 'true'){
						alert('사용 가능한 아이디 입니다.')// 로그인 실패시 팝업
					}else{
						alert('이미 존재하는 아이디 입니다.')// 로그인 실패시 팝업
					}
				},
				error : function() {
					alert('ajax 요청 실패');
				}
			})
		})
		
	})
function checkIn() {
		///////////예외 처리 해야하는 부분

}
</script>
</head>
<body>
	<div class="container">
		<h2>비밀의 숲 회원가입</h2>
		<form action="signup.do" method="post" onsubmit="return checkIn();">
			<div class="row">
				<h4>계정</h4>
				<div id="inputId" class="input-group input-group-icon input-harf">
					<input id="input-id" type="text" placeholder="아이디" maxlength="20" name="id"/>
					<span class="input-icon"><i style="margin-top: 18px"
						class="fa fa-user"></i></span> <input id="duplicate-check-button"
						style="padding-left: 15px; color: #ffffff" type="button"
						value="중복 확인">
				</div>
				<div class="input-group input-group-icon">
					<input type="password" placeholder="비밀번호" maxlength="20" name="password"/>
					<div class="input-icon">
						<i style="margin-top: 18px" class="fa fa-key"></i>
					</div>
				</div>
				<div class="input-group input-group-icon">
					<input type="password" placeholder="비밀번호 확인" maxlength="20" />
					<div class="input-icon">
						<i style="margin-top: 18px" class="fa fa-key"></i>
					</div>
				</div>
				<div class="input-group input-group-icon">
					<input type="text" placeholder="이름" name="name" />
					<div class="input-icon">
						<i style="margin-top: 18px" class="fa fa-tag"></i>
					</div>
				</div>
				<div class="input-group input-group-icon">
					<input type="email" placeholder="이메일" maxlength="30" name="email"/>
					<div class="input-icon">
						<i style="margin-top: 18px" class="fa fa-envelope"></i>
					</div>
				</div>

			</div>
			<div class="row">
				<div class="col-half">
					<h4>생일</h4>
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
					<h4>성별</h4>
					<div class="input-group">
						<input type="radio" name="gender" value="남" id="gender-male" />
						<label for="gender-male">남자</label> <input type="radio"
							name="gender" value="녀" id="gender-female" /> <label
							for="gender-female">여자</label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-half">
					<h4>핸드폰</h4>
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
						value="회원 가입">
				</div>
			</div>
		</form>
	</div>
	<script
		src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
</body>
</html>