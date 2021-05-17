<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	
	// 댓글 등록
	$("#replyWriteBtn").click(function() {
		console.log('댓글 작성 버튼 누름');
		if($("#rContent").val().length == 0) {
			alert("댓글 내용을 입력하세요.");
			$("#rContent").focus(); 
			return false; 
		} else {
			var formObj = $("form[name='replyForm']");
			formObj.attr("action", "/replyInsert");
			formObj.submit();
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
				<%@ include file="/WEB-INF/views/board/boardHead.jsp"%>
				<!-- Section -->
				<section id="banner">
					<div class="content">
						<c:forEach var="item" items="${list}">
						<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
						<header class="major">
							<h2>${item.sName}</h2>
						</header>
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
						
						<%  
							if(!userId.equals("anonymousUser")) {
						%>
							<!-- 댓글 (insert) -->
							<form name="replyForm" method="post">
							<input type="hidden" id="bNo" name="bNo" value="${item.bNo}" />
							<input type="hidden" id="rWriter" name="rWriter" value="<%= userId %>" />
								<div>
									<table border="1">
										  <tr>
										  	<th>댓글 작성자</th>
										  	<td><p><%= userId %></p></td>
										  </tr>
										  <tr>
										    <th>댓글 내용</th>
										    <td colspan="3"><input type="text" id="rContent" name="rContent" maxlength="300" placeholder="최대 300자까지 입력가능합니다."></td>
										  </tr>
									</table>
									<div align="center">
										<input type="button" id="replyWriteBtn" class="button" value="댓글 작성"/>
									</div>
								</div>
							</form>
						<%
							}
						%>
						<!-- 댓글 (select) -->
						<div id="reply">
							<ol class="replyList">
								<c:forEach items="${replyList}" var="replyList">
									<li>
										<p>
											작성자 : ${replyList.rWriter}<br />
											작성 날짜 :  <fmt:formatDate value="${replyList.rDate}" pattern="yyyy-MM-dd HH:mm" />
										</p>
									
										<p>${replyList.rContent}</p>
									</li>
								</c:forEach>   
							</ol>
						</div>
						<div align="center">
							<a href="${path}/boardList.do?cName=${item.cName}&sName=${item.sName}&cNo=${item.cNo}" class="button">목록</a>
							<%  String writer = request.getParameter("writer");
								
								if(userId.equals(writer)) {
							%>
								<a href="${path}/boardUpdateForm.do?bNo=${item.bNo}" class="button">수정</a>
				   				<a href="${path}/boardDelete.do?bNo=${item.bNo}" onclick="return confirm('게시글을 삭제하시겠습니까?');" class="button primary">삭제</a>
				   			<% } %>
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