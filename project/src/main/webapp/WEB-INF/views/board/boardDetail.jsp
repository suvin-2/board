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
							<h2>자유게시판</h2>
						</header>
						<c:forEach var="item" items="${list}">
						<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
						<table border="1">
							  <tr>
							    <th>제목</th>
							    <td colspan="3"><p id="title">${item.title}</p></td>
							  </tr>
							  <tr>
							    <th>작성자</th>
							    <td><p id="writer">${item.writer}</p></td>
							  </tr>
							  <tr>
							    <th>작성일</th>
							    <td><p id="bDate">${bDate}</p></td>
							    <th>조회수</th>
							    <td><p id="cnt">${item.cnt}</p></td>
							  </tr>
							  <tr>
							    <th>내용</th>
							    <td colspan="3"><p id="content">${item.content}</p></td>
							  </tr>
						</table>
						<div align="center">
							<a href="${path}/boardUpdateForm.do?bNo=${item.bNo}" class="button primary">수정</a>
			   				<a href="${path}/boardDelete.do?bNo=${item.bNo}" onclick="return confirm('게시글을 삭제하시겠습니까?');" class="button">삭제</a>
						</div>
						</c:forEach>
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