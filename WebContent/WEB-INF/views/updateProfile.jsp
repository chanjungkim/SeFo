<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>비밀의숲 - ${sessionScope.loginId}</title>

<script type="text/javascript">
	window.onload=function(){
		alert("수정 완료")
		location.href="profile.do/${sessionScope.loginId}";
	}
</script>
</head>
<link rel="shortcut icon"  href="<%=request.getContextPath()%>/favicon.ico" />
<body>

</body>
</html>