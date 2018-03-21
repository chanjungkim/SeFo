<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀의숲 - ${sessionScope.loginId}</title>

<script type="text/javascript">
	window.onload=function(){
		$.ajax({
			type : 'post', // 요청 보내면 doPost가 실행됨
			url : 'profile.do/${sessionScope.loginId}', // 우리가 작성한 java 서블릿에게
			data : {
				'id' : ${sessionScope.loginId}
			}, // 검색어 데이터
			dataType : 'text', // 응답데이터 형식
			success : function(resultData) {
				alert("수정 완료")
			},
			error : function() {
				alert('회원탈퇴 ajax 요청 실패');
			}
		});
	}
</script>
</head>
<link rel="shortcut icon"  href="<%=request.getContextPath()%>/favicon.ico" />
<body>
</body>
</html>