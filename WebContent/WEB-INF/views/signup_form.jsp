<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>비밀의숲 회원가입</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
	<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>
	<link rel="stylesheet" href="./assets/css/signup.css">
</head>
<style type="text/css">
.input[type=text] {
	-webkit-ime-mode: inactive;
	-moz-ime-mode: inactive;
	-ms-ime-mode: inactive;
	ime-mode: inactive;
}
</style>
<body>
  
<div class="container">
  <form>
    <div class="row">
      <h4>Account</h4>
      <div class="input-group input-group-icon">
        <input type="text" placeholder="아이디" pattern="[A-Za-z0-9]*" maxlength="20"/>
        <div class="input-icon"><i style="margin-top:18px" class="fa fa-user"></i></div>
      </div>
      <div class="input-group input-group-icon">
        <input type="password" placeholder="비밀번호" maxlength="20"/>
        <div class="input-icon"><i style="margin-top:18px" class="fa fa-key"></i></div>
      </div>
      <div class="input-group input-group-icon">
        <input type="password" placeholder="비밀번호 확인" maxlength="20"/>
        <div class="input-icon"><i style="margin-top:18px" class="fa fa-key"></i></div>
      </div>
      <div class="input-group input-group-icon">
        <input type="text" placeholder="이름"/>
        <div class="input-icon"><i style="margin-top:18px" class="fa fa-tag"></i></div>
      </div>
      <div class="input-group input-group-icon">
        <input type="email" placeholder="이메일"/>
        <div class="input-icon"><i style="margin-top:18px" class="fa fa-envelope"></i></div>
      </div>
      
    </div>
    <div class="row">
      <div class="col-half">
        <h4>Date of Birth</h4>
        <div class="input-group">
          <div class="col-third">
            <input type="text" placeholder="YYYY"/>
          </div>
          <div class="col-third">
            <input type="text" placeholder="MM"/>
          </div>
          <div class="col-third">
            <input type="text" placeholder="DD"/>
          </div>
        </div>
      </div>
      <div class="col-half">
        <h4>Gender</h4>
        <div class="input-group">
          <input type="radio" name="gender" value="male" id="gender-male"/>
          <label for="gender-male">남자</label>
          <input type="radio" name="gender" value="female" id="gender-female"/>
          <label for="gender-female">여자</label>
        </div>
      </div>
    </div>
     <div class="row">
      <div class="col-half">
        <h4>Phone</h4>
        <div class="input-group">
          <div class="col-third">
            <input type="text"/>
          </div>
          <div class="col-third">
            <input type="text"/>
          </div>
          <div class="col-third">
            <input type="text"/>
          </div>
        </div>
      </div>
  </form>
</div>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
</body>
</html>