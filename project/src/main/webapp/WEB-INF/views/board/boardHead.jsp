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
<script type="text/javascript">
	var userId = $("#securityLogin");
	
	console.log('board head user id : '+userId);
</script>
<style>
#header {
	padding : 5em 0 0 0;
}

.icons {
	height : 57px;
}

.icons a {
	border-bottom : 0;
	font-family : "Roboto Slab", serif;
	color : #3d4449;
}
.drop_menu_li { 
	display:inline-block; 
	width:100px; 
	padding:5px 10px; 
	position:relative; 
}
.drop_menu_li:hover { 
	background:#ffffff; 
}
.drop_menu_li ul.drop_menu_ul { 
	display:none; 
	position:absolute; 
	top:25px; 
	left:0; 
}
.drop_menu_li:hover ul.drop_menu_ul { 
	display:block; 
	font-size : 13px; 
	font-color : gray;
}
.drop_menu_li ul.drop_menu_ul > li { 
	display:inline-block; 
	width:200px; 
	padding:5px 10px; 
	background-color: rgba( 255, 255, 255, 0.7 ); 
	text-align : left;
}
.drop_menu_li ul.drop_menu_ul > li:hover { 
	background-color: rgba( 255, 255, 255, 0.7 ); 
}
</style>
</head>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String userId = "";
    if(principal != null) {
    	userId = auth.getName();
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
						<li><a href='<c:url value="/userLoginForm"/>'>LOGIN</a></li>
						<li><a href="/userJoin.do">JOIN</a></li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li><p><sec:authentication property="principal.username"/>님, 반갑습니다.</p></li>
						<% if(userId.equals("admin")) { %>
							<li><a href="/adminMainForm.do">ADMIN PAGE</a></li>
						<% } %>
						<li class="drop_menu_li">
							<a href="#"><span class="label">MY PAGE</span></a>
							<ul class="drop_menu_ul">
								<li><a href="userInfoForm.do?userId=<%=userId%>">MY INFORMATION</a></li>
								<li><a href="userWritingList.do?userId=<%=userId%>">WRITING/REPLY/LIKE</a></li>
							</ul>
						</li>
						<li><a href="#" onclick="document.getElementById('logout-form').submit();"><span class="label">LOGOUT</span></a></li>
					</sec:authorize>
					<li><a href="https://github.com/suvin-2" class="icon brands fa-github"><span class="label">Github</span></a></li>
				</ul>
			</header>
<form id="logout-form" action='<c:url value='/logout'/>' method="POST">
   <input id="securityLogin" name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
</form>
<!-- Scripts -->
<script src="js/jquery.min.js"></script>
<script src="js/browser.min.js"></script>
<script src="js/breakpoints.min.js"></script>
<script src="js/util.js"></script>
<script src="js/main.js"></script>
</body>
</html>