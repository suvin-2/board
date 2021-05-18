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
			var rContent = $("#rContent").val();
			var bNo = $("#bNo").val();
			var rWriter = $("#rWriter").val();
			var param = {"bNo":bNo, "rContent":rContent, "rWriter":rWriter};
			
			console.log('content :'+rContent+', bNo:'+bNo+', writer:'+rWriter);
			
			$.ajax({
				url : '/replyInsert.do',
				data : param,
				type : 'get',
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				error : function(xhr, status, msg) {
					console.log("ajax 실패");
					console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
				},
				success : function(data) {
					//alert("댓글이 등록되었습니다.");
					// 페이지 새로고침
					location.href = location.href;
				}
			});
		}
	});
});
</script>
<style>
.title {
	text-align : center;
}

.title p {
	color : silver;
}

#writer {
	font-weight : 600;
}

#bDate {
	color : silver;
	width : 49%;
}

.writer_info {
	display: table;
    width: 100%;
}

.writer_info1 {
    display: table-cell;
    width: 70%;
}

.writer_info2 {
    display: table-cell;
    text-align : right;
} 

#reply_writer {
	font-weight : 600;
	margin : 0 0 10px 0;
}

#reply_content {
	margin : 0 0 5px 0;
}

#reply_date {
	color : silver;
}

#reply_insert_writer {
	font-weight : 600;
	margin : 0 0 10px 0;
}

.reply_insert_box {
    display: table;
    width: 100%;
}

.reply_insert_content {
    display: table-cell;
    width: 80%;
}

.reply_insert_btn {
    display: table-cell;
    padding-left: 50px;
    float: right;
}

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
				<%@ include file="/WEB-INF/views/board/boardHead.jsp"%>
				<!-- Section -->
				<section id="banner">
					<div class="content">
						<c:forEach var="item" items="${list}">
						<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
						<!-- 카테고리, 제목 -->
						<div class="title">
							<p id="sName">${item.sName}</p>
							<h2 id="title">${item.title}</h2>
						</div>
						<!-- 작성자, 작성시간, 조회수 -->
						<div class="writer_info">
							<div class="writer_info1">
								<span id="writer">${item.writer}</span>&nbsp;
								<span id="bDate">${bDate}</span>
							</div>
							<div class="writer_info2">
								<span id="cnt">조회수 ${item.cnt}</span>
							</div>
						</div>
						<hr>
						<div class="main_content">
							<textarea id="content" cols="100" rows="10">${item.content}</textarea>
						</div>
						<br>
						
						<!-- 댓글 (select) -->
						<div id="reply">
							<ol class="alt">
							<table border="1">
								<c:forEach items="${replyList}" var="replyList">
									<tr>
										<td>
											<li>
												<p id="reply_writer">${replyList.rWriter}</p>
												<p id="reply_content">${replyList.rContent}</p>
												<span id="reply_date"><fmt:formatDate value="${replyList.rDate}" pattern="yyyy-MM-dd HH:mm" /></span>
												<c:set var="userId" value="<%= userId %>"/>
												<c:if test="${replyList.rWriter eq userId}">
													<div id="reply_btn">
														<a class="button small" id="reply_update">수정</a>&nbsp;
														<a class="button small" id="reply_delete">삭제</a>
													</div>
												</c:if>
											</li>
										</td>
									</tr>
								</c:forEach>
							</table>
							</ol>
						</div>
						
						<%  
							if(!userId.equals("anonymousUser")) {
						%>
							<!-- 댓글 (insert) -->
							<form name="replyForm" method="post">
							<input type="hidden" id="bNo" name="bNo" value="${item.bNo}" />
							<input type="hidden" id="rWriter" name="rWriter" value="<%= userId %>" />
								<div class="box">
									<p id="reply_insert_writer"><%= userId %></p>
									<div class="reply_insert_box">
										<div class="reply_insert_content">
											<input type="text" id="rContent" name="rContent" maxlength="300" placeholder="최대 300자까지 입력가능합니다.">
										</div>
										<div class="reply_insert_btn">
											<input type="button" id="replyWriteBtn" class="button" value="댓글 작성"/>
										</div>
									</div>
								</div>
							</form>
						<%
							}
						%>
						
						<div align="center">
							<a href="${path}/boardList.do?cName=${item.cName}&sName=${item.sName}&cNo=${item.cNo}" class="button">목록</a>
							<%
								String writer = request.getParameter("writer");
								if(userId.equals(writer)) {
							%>
								<a href="${path}/boardUpdateForm.do?bNo=${item.bNo}" class="button">수정</a>
				   				<a href="${path}/boardDelete.do?bNo=${item.bNo}&cName=${item.cName}&sName=${item.sName}&cNo=${item.cNo}" onclick="return confirm('게시글을 삭제하시겠습니까?');" class="button primary">삭제</a>
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