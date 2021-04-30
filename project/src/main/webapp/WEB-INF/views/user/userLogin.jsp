<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>suvin's cooking class</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<script type="text/javascript">
$(function(){
	$("#submit").click(function(){
		
		if($("#userId").val().length==0) { 
			alert("ID를 입력하세요."); 
			$("#userId").focus(); 
			return false; 
		}
		if($("#userPw").val().length==0) { 
			alert("비밀번호를 입력하세요."); 
			$("#userPw").focus(); 
			return false; 
		}
	});
});

</script>
</head>
<body class="is-preload" onload="document.userLoginForm.userId.focus();">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Main -->
			<div id="main">
				<div class="inner">	
					<!-- Header -->
					<jsp:include page="../board/boardHead.jsp" flush="false"/>	
					<!-- Section -->
						<section>
							<header class="major">
								<br><h2>로그인</h2>
							</header>
							<div style="padding: 0 200px 0 200px; height: auto; min-height: 100px; overflow: auto;">
							     <form name="userLoginForm" action="/login" method="post">
							         <div class="form-group">
							             <label for="exampleDropdownFormEmail1">ID</label>
							             <input type="text" class="form-control" name="userId" id="userId" placeholder="example" />
							         </div>
							         <br>
							         <div class="form-group">
							             <label for="exampleDropdownFormPassword1">Password</label>
							             <input type="password" class="form-control" name="userPw" id="userPw" placeholder="Password" />
							         </div>
							         <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
							         <br>
							         <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
									    <font color="red">
									        <p>Your login attempt was not successful due to <br/>
									            ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</p>
									        <c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"/>
									    </font>
									</c:if>
									<input type="submit" id="submit" class="button primary" value="Login"/>
							        <!-- <button type="submit" class="btn btn-primary">Login</button> -->
							    </form>
							    <div class="dropdown-divider"></div>
							    <a class="dropdown-item" href="#">New around here? Sign up</a>
							    <br>
							    <a class="dropdown-item" href="#">Forgot password?</a>
							</div>
							
						</section>
				</div>
			</div>
	</div>
<!-- Scripts -->
<script src="js/jquery.min.js"></script>
<script src="js/browser.min.js"></script>
<script src="js/breakpoints.min.js"></script>
<script src="js/util.js"></script>
<script src="js/main.js"></script>
</body>
</html>