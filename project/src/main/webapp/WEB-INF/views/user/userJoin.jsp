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
.userBirth { display: flex; }
.userBirth_c { flex: 1; }
</style>
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
								<br><h2>회원가입</h2>
							</header>
							<div style="padding: 0 200px 0 200px; height: auto; min-height: 100px; overflow: auto;">
							     <form name="userJoinForm" action="/login" method="post">
							         <div class="form-group">
							             <label>아이디</label>
							             <input type="text" class="form-control" name="userId" id="userId" placeholder="id" />
							         </div>
							         <br>
							         <div class="form-group">
							             <label>비밀번호</label>
							             <input type="password" class="form-control" name="userPw" id="userPw" placeholder="Password" />
							         </div>
							         <div class="form-group">
							             <label>비밀번호 확인</label>
							             <input type="password" class="form-control" name="userPwCheck" id="userPwCheck" placeholder="Password" />
							         </div>
							         <div class="form-group">
							             <label>이름</label>
							             <input type="text" class="form-control" name="userName" id="userName" placeholder="name" />
							         </div>
							         <div class="form-group">
							             <label>생년월일</label>
							             <div class="userBirth_p">
								             <div class="userBirth_c">
								             	<input type="text" class="form-control" name="userYear" id="userYear" placeholder="year(ex 1995)" />
								             </div>
								             <div class="userBirth_c">
									            <input type="text" class="form-control" name="userMonth" id="userMonth" placeholder="month" />
									         </div>
									         <div class="userBirth_c">
									            <input type="text" class="form-control" name="userDay" id="userDay" placeholder="day" />
								             </div>
							             </div>
							         </div>
							         <div class="form-group">
							             <label>이메일</label>
							             <input type="text" class="form-control" name="userEmail" id="userEmail" placeholder="email" />
							         </div>
							         <div class="form-group">
							             <label>전화번호</label>
							             <input type="text" class="form-control" name="userPhone" id="userPhone" placeholder="phone-number" />
							         </div>
							         <br>
							         <div class="form-group">
							         	<input type="submit" id="submit" class="button primary" value="Login"/>
							         </div>
							    </form>
							    <div class="dropdown-divider"></div>
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