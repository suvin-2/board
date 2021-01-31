<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board insert</title>
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
		if($("#cName").val().length==0) { 
			alert("카테고리(대분류)를 선택하세요."); 
			$("#cName").focus(); 
			return false; 
		}
		if($("#sName").val().length==0) { 
			alert("카테고리(소분류)를 선택하세요."); 
			$("#sName").focus(); 
			return false; 
		}
		if($("#title").val().length==0) { 
			alert("제목을 입력하세요."); 
			$("#title").focus(); 
			return false; 
		}
		if($("#writer").val().length==0) { 
			alert("작성자를 입력하세요."); 
			$("#writer").focus(); 
			return false; 
		}
		if($("#content").val().length==0) { 
			alert("내용을 입력하세요."); 
			$("#content").focus(); 
			return false; 
		}
	});
});

</script>
</head>
<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- side var -->
		<jsp:include page="boardSide.jsp" flush="false"/>
		<!-- Main -->
		<div id="main">
			<div class="inner">	
				<!-- Header -->
				<jsp:include page="boardHead.jsp" flush="false"/>

				<!-- Section -->
				<section id="banner">
					<div class="content">
						<header class="major">
							<h2>글 등록</h2>
						</header>
						<c:url var="insert" value="/boardInsert.do" />
						<form:form commandName="boardVO" action="${insert}" name="boardVO" method="post">
							<table border="1">
								<tbody>
									<tr>
									   <th>카테고리</th>
									   <td>
									   <c:forEach var="item" items="${list}">
									   		<!-- value는 foreach에서 가지고온 배열, var는 ${}에서 사용할 변수명(?) -->
									   		<c:set var="list" value="${item}"/>
									   		<!-- cList, sList는 사용하지 x (테스트용으로 작성함) -->
									   		<c:set var="cName" value="${item.cName}"/>
									   		<c:set var="sName" value="${item.sName}"/>
									   </c:forEach>
										   	<select id="category" name="category">
										   		<option value="">카테고리 선택</option>
										   		<!-- for문 들어가야함 -->
										   		<optgroup label="${cName}" id="cName">
										   			<option value="sName">${sName}</option>
										   		</optgroup>
										   	</select>
									   	
									   </td>
									   
									</tr>
									<tr>
									   <th>제목</th>
									   <td colspan="3"><form:input path="title" id="title" size="20" maxlength="100" /></td>
									</tr>
									<tr>
									   <th>작성자</th>
									   <td colspan="3"><form:input path="writer" id="writer" size="20"/></td>
									</tr>
									<tr>
									   <th>내용</th>
									   <td colspan="3"><form:textarea path="content" id="content" /></td>
									</tr>
								</tbody>
							</table>
							<div align="center">
								<input type="submit" id="submit" value="등록"/>
				   			</div>
						</form:form>
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
