<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>suvin's cooking class admin page</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<script>
// 댓글 삭제
function adminReplyDelete(userId, rNo) {
	 
	if(confirm(userId+'님의 댓글을 삭제하시겠습니까?') == true){
	
			$.ajax({
				url : '/adminReplyDelete.do/'+rNo,
				type : 'GET',
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				error : function(xhr, status, msg) {
					console.log("ajax 실패");
					console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
				},
				success : function(data) {
					alert('댓글이 삭제되었습니다.');
					// 페이지 새로고침
					location.href = location.href;
				}
			});
			
	} else {
		alert('댓글이 삭제되지 않았습니다.');
	}
}

</script>
<style>
#title {
	text-align : left;
}
#board_head {
	display : inline;
}
#category_div {
	float : right;
}
</style>
</head>
<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- side var -->
		<jsp:include page="adminSide.jsp" flush="false"/>
		<!-- Main -->
			<div id="main">
				<div class="inner">	
					<!-- Header -->
					<%@ include file="/WEB-INF/views/board/boardHead.jsp"%>
					<!-- Section -->
					<section>
						<header class="major" id="board_head">
							<h2>전체 댓글</h2>
						</header>
						<div id="all_reply">
							<table border="1">
								<thead>
									<tr>
									  	<th>카테고리</th>
									    <th>제목</th>
									    <th>댓글 내용</th>
									    <th>댓글 작성자</th>
									    <th>댓글 작성일</th>
									    <th>삭제</th>
									</tr>
								</thead>
								<tbody id="boardList_tbody">
									<c:forEach var="item" items="${list}">
									<c:set value="location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}&cNo=${item.cNo}&writer=${item.writer}'" var="url"/>
									<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
									<fmt:formatDate var="rDate" value="${item.rDate}" pattern="yyyy-MM-dd HH:MM"/>
										<tr>
										    <td id="sName" onClick = "${url}">${item.sName}</td>
										    <td id="title" onClick = "${url}">${item.title}</td>
										    <td id="rContent" onClick = "${url}">${item.rContent}</td>
										    <td id="rWriter" onClick = "${url}">${item.rWriter}</td>
										    <td id="rDate" onClick = "${url}">${rDate}</td>
										    <td id="replyDeleteBnt"><input type="button" value="삭제" onclick="adminReplyDelete('${item.rWriter}',${item.rNo})"></td>
										</tr>
								    </c:forEach>
								</tbody>
							</table>
						</div>
						<div class="pagingBnt">
							  <ul class="pagination" id="paging_ul">
							    <c:if test="${pageMaker.prev}"> 
							    <li> 
							        <a href='<c:url value="adminReplyForm.do?page=${pageMaker.startPage-1}"/>' class="button"></a>
							    </li>
							    </c:if>
							    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
							    <li>
							        <a href='<c:url value="adminReplyForm.do?page=${pageNum}"/>' class="page">${pageNum}</a>
							    </li>
							    </c:forEach>
							    <c:if test="${pageMaker.next && pageMaker.endPage>0}">
							    <li>
							        <a href='<c:url value="adminReplyForm.do?page=${pageMaker.endPage+1}"/>' class="button"></a>
							    </li>
							    </c:if>
							</ul>
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