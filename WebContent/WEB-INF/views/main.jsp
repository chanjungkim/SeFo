<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=EUC-KR">
<meta charset="EUC-KR">
<title>Facebook Theme Demo</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="assets/css/bootstrap.css" rel="stylesheet">
<!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<link href="assets/css/facebook.css" rel="stylesheet">
</head>

<body>
	<c:if test="${empty sessionScope.loginId}">
		<%
			response.sendRedirect(request.getContextPath() + "/loginPageMove.do");
		%>
	</c:if>
	<c:if test="${not empty sessionScope.loginId}">
		<%
			response.sendRedirect(request.getContextPath() + "/initMain.do");
		%>
	</c:if>
</body>
</html>