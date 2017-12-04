<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	var wsocket;
	function connect(){
		wsocket=new WebSocket("ws://localhost:8888/SeFo/chat-ws")
		wsocket.onopen=onOpen;
		wsocket.onmessage=onMessage;
		wsocket.onclose=onClose;
	}
	function disconnect(){
		wsocket.close();
	}
	function onOpen(evt){
		appendMessage("연결되었습니다.");
	}
	function onMessage(evt){
		var data=evt.data;
		if(data.substring(0,4)=="msg:"){
			appendMessage(data.substring(4));
		}
	}
	function onClose(evt){
		appendMessage("연결을 끊었습니다.")
	}
	function send(){
		var nickname=$('#nickname').val();
		var msg=$('#message').val();
		wsocket.send("msg:"+nickname+":"+msg);
		$('#message').val("");
	}
	function appendMessage(msg){
		$('#chatMessageArea').append(msg+"<br>");
		var chatAreaHeight =  $('#chatArea').height();
		var maxScroll=$('#chatMessageArea').height()-chatAreaHeight;
		$('#chatArea').scrollTop(maxScroll);
	}
	$(document).ready(function(){
		$('#message').keypress(function(event){
			var keycode = (event.keyCode?event.keyCode:event.which);
			if(keycode=='13'){
				send();
			}
			event.stopPropagation();
		});
		$('#sendBtn').click(function(){send();});
		$('#enterBtn').click(function(){connect();});
		$('#exitBtn').click(function(){disconnect();});
	});
</script>
<style type="text/css">
	#chatArea{
		width: 300px;
		height: 200px;
		overflow-y:auto;
		border: 1px solid; 
	}
</style>
</head>
<body>
	이름:<input type="text" id="nickname">
	<input type="button" id="enterBtn" value="입장">
	<input type="button" id="exitBtn" value="나가기">
	
	<h1>대화 영역</h1>
	<div id="chatArea">
		<div id="chatMessageArea"></div>
	</div> 
	<br>
	<input type="text" id="message">
	<input type="button" id="sendBtn" value="전송">
</body>
</html>