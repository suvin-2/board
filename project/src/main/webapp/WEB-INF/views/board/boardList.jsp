<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>suvin's cooking class</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<style type="text/css">
	.pagingBnt li {list-style: none; float: left; padding: 10px;}
	.pagingBnt {align:middle;}
</style>
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
					
					<%  
						String sName = request.getParameter("sName"); 
						System.out.println("boardList.jsp 넘어온 sName : " + sName);
					%>
					<header class="major">
							<h2 id="sName"><%= sName %></h2>
						</header>
						<!-- 카페 내 전체 글 -->
						<table border="1">
							<thead>
							  <tr>
							    <th>제목</th>
							    <th>작성자</th>
							    <th>작성일</th>
							    <th>조회수</th>
							  </tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
							<c:set value="${item.cName}" var="cNameCopy"/>
							<c:set value="${item.sName}" var="sNameCopy"/>
							<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
							<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
							
								  <tr onClick = "location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}&cNo=${item.cNo}'">
								    <td id="title">${item.title}</td>
								    <td id="writer">${item.writer}</td>
								    <td id="bDate">${bDate}</td>
								    <td id="cnt">${item.cnt}</td>
								  </tr>
						    </c:forEach>
							</tbody>
						</table>
						<a href="boardInsertForm.do?sName=<%=sName%>" class="button">글쓰기</a>
						<div class="pagingBnt">
							  <ul class="btn-group pagination">
							    <c:if test="${pageMaker.prev }"> 
							    <li> 
							        <a href='<c:url value="boardList.do?cName=${cNameCopy}&sName=${sNameCopy}&page=${pageMaker.startPage-1}"/>'><i class="fa fa-chevron-left"></i></a>
							    </li>
							    </c:if>
							    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
							    <li>
							        <a href='<c:url value="boardList.do?cName=${cNameCopy}&sName=${sNameCopy}&page=${pageNum}"/>'><i class="fa">${pageNum}</i></a>
							    </li>
							    </c:forEach>
							    <c:if test="${pageMaker.next && pageMaker.endPage >0}">
							    <li>
							        <a href='<c:url value="boardList.do?cName=${cNameCopy}&sName=${sNameCopy}&page=${pageMaker.endPage+1}"/>'><i class="fa fa-chevron-right"></i></a>
							    </li>
							    </c:if>
							</ul>
						</div>
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