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
<style>
#errorMsg {
	color : red;
}
</style>
</head>
<body class="is-preload" onload="document.userLoginForm.userId.focus();">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Main -->
			<div id="main">
				<div class="inner">	
					<!-- Header -->
					<%@ include file="/WEB-INF/views/board/boardHead.jsp"%>
					<!-- Section -->
						<section>
							<header class="major">
								<br><h2>로그인</h2>
							</header>
							<div style="padding: 0 200px 0 200px; height: auto; min-height: 100px; overflow: auto;">
							     <form name="userLoginForm" action="/login" method="post">
							         <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
							         <div class="form-group">
							             <label >ID</label>
							             <input type="text" class="form-control" name="userId" id="userId" placeholder="id" />
							         </div>
							         <br>
							         <div class="form-group">
							             <label>Password</label>
							             <input type="password" class="form-control" name="userPw" id="userPw" placeholder="Password" />
							         </div>
							         <c:if test="${param.error!=null}">
										<br><br><p id="errorMsg">아이디또는 비밀번호를 확인해주세요.
										<c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>
										</p>
									 </c:if>
							         <p id="loginFailMsg">${loginFailMsg}</p>
									 <input type="submit" id="submit" class="button primary" value="Login"/>
									 
							    </form>
							    <br>
							    <a class="dropdown-item" href="/userFindAccountForm">Forgot user account?</a>
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