<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>suvin's cooking class</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
</head>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String name = "";
    if(principal != null) {
        name = auth.getName();
    }
%>
<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
	
	<!-- Main -->
		<div id="main">
			<!-- Header -->
			<header id="header">
				<a href="/" class="logo"><strong>Suvin's Cooking Class</strong> by suvin</a>
					<ul class="icons">
						<sec:authorize access="isAnonymous()">
							<li><a href='<c:url value="/userLoginForm"/>'><span class="label">LOGIN</span></a></li>
							<li><a href="/userJoin.do"><span class="label">JOIN</span></a></li>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<li><p><sec:authentication property="principal.username"/>님, 반갑습니다.</p></li>
							<li><a href="#" onclick="document.getElementById('logout-form').submit();"><span class="label">LOGOUT</span></a></li>
						</sec:authorize>
						<li><a href="https://github.com/suvin-2" class="icon brands fa-github"><span class="label">Github</span></a></li>
					</ul>	
			</header>
<form id="logout-form" action='<c:url value='/logout'/>' method="POST">
   <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
</form>
<!-- Scripts -->
<script src="js/jquery.min.js"></script>
<script src="js/browser.min.js"></script>
<script src="js/breakpoints.min.js"></script>
<script src="js/util.js"></script>
<script src="js/main.js"></script>
</body>
</html>