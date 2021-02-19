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
</head>
<body class="is-preload">
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
								<h2>로그인</h2>
							</header>
								<form name="userLiginForm" action="/login" method="POST">
							        <table>
							            <tbody>
							                <tr>
							                    <td>User Id:</td>
							                    <td><input type="text" name="userId" value=""></td>
							                </tr>
							                <tr>
							                    <td>User Password:</td>
							                    <td><input type="password" name="userPwd"></td>
							                </tr>
							                <tr>
							                    <td colspan="2"><input name="submit" type="submit" value="Login"></td>
							                </tr>
							            </tbody>
							        </table>
							        <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
									<button type="submit" class="btn btn-primary">Sign in</button>
							    </form>
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