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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<link rel="stylesheet" href="css/main.css" />
<script>
$(function (){
	
	var userId = $("#userId").val();
	
	//탭 컨텐츠 숨기기
	$(".tab_content").hide();

	// 첫번째 탭콘텐츠 보이기
	$(".tab_container").each(function () {
		$(this).children(".tabs li:first").addClass("active"); //Activate first tab
		$(this).children(".tab_content").first().show();
		//writing_list();
	});
	
	
	//탭메뉴 클릭 이벤트
	$(".tabs li a").click(function () {
	  
		$(this).parent().siblings("li").removeClass("active");
		$(this).parent().addClass("active"); $(this).parent().parent().parent().parent().find(".tab_content").hide();
		
		var activeTab = $(this).attr("rel");
		if(activeTab == "tab1"){
			$("#" + activeTab).fadeIn();
		} else if(activeTab == "tab2") {
			location.href = "/userReplyList.do?userId="+userId;
		} else if(activeTab == "tab3") {
			location.href = "/userLikeList.do?userId="+userId;
		}
	});
});
</script>
<style type="text/css">
.tabs ul li a {
	border-bottom : 0;
}
.pagingBnt li {
	list-style: none; 
	float: middle; 
	padding: 10px;
}
.pagingBnt {
	align : center;
}
.btn-group pagination {
	float : middle;
}

.tab_container {
  position: relative;

  margin:auto;
}
.tab_container .tab_content {
  width:100%
  padding: 30px 0;
}

.tabs ul {
  width: 100%;
  display:table;
  table-layout: fixed;
  padding:0
}
.tabs li {
  display: table-cell;
  background: #f6f7f9;
  border-top: 1px solid #ddd;
  border-right: 1px solid #ddd;
  padding: 20px;
  border-bottom: 1px solid #222;
  text-align: center;
}
.tabs li.active {
  background: #fff;
  border-top: 1px solid #222;
  border-left: 1px solid #222;
  border-right: 1px solid #222;
  border-bottom: 0;
}
.tabs li.active a {
  color: #f56a6a;
  font-weight: 500;
}
.tabs li a {
  font-size: 14px;
  color: #f56a6a;
  display: block;
  width: 100%;
  height: 100%;
  vertical-align: middle;
  text-decoration: none;color: #000
}
</style>
</head>
<body class="is-preload">
<!-- Wrapper -->
<div id="wrapper">
<!-- side var -->
<jsp:include page="/WEB-INF/views/board/boardSide.jsp" flush="false"/>
	<!-- Main -->
	<div id="main">
		<div class="inner">	
			<!-- Header -->
			<%@ include file="/WEB-INF/views/board/boardHead.jsp"%>
			<c:set value="<%=userId%>" var="userId"/>
			<input type="hidden" id="userId" value="<%=userId%>">
			<!-- Section -->
			<div class="tab_container">
				<br>
				<!--탭 메뉴 영역 -->
				<div class="tabs">
					<ul>
						<li class="active"><a href="#" rel="tab1">작성한 글</a></li>
						<li><a href="#" rel="tab2">작성한 댓글</a></li>
						<li><a href="#" rel="tab3">좋아요 글</a></li>
					</ul>
				</div>
				<!-- 작성한 글 출력 -->
				<div id="tab1" class="tab_content">
					<table border="1">
						<thead>
							<tr>
							  	<th>카테고리</th>
							    <th>제목</th>
							    <th>작성자</th>
							    <th>작성일</th>
							    <th>조회수</th>
						    </tr>
						</thead>
						<tbody id="writing_tbody">
							<c:forEach var="item" items="${board_list}">
							<c:set value="location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}&cNo=${item.cNo}&writer=${item.writer}'" var="url"/>
							<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
							<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
								<tr onClick = "${url}">
								    <td id="board_sName">${item.sName}</td>
								    <td id="board_title">${item.title}</td>
								    <td id="board_writer">${item.writer}</td>
								    <td id="board_bDate">${bDate}</td>
								    <td id="board_cnt">${item.cnt}</td>
								</tr>
						    </c:forEach>
						</tbody>
					</table>
					<!-- 페이징 -->
					<div class="pagingBnt">
						  <ul class="pagination" id="paging_ul">
						    <c:if test="${board_pageMaker.prev}"> 
						    <li> 
						        <a href='<c:url value="userWritingList.do?userId=${userId}&page=${board_pageMaker.startPage-1}"/>' class="button"></a>
						    </li>
						    </c:if>
						    <c:forEach begin="${board_pageMaker.startPage}" end="${board_pageMaker.endPage}" var="pageNum">
						    <li>
						        <a href='<c:url value="userWritingList.do?userId=${userId}&page=${pageNum}"/>' class="page">${pageNum}</a>
						    </li>
						    </c:forEach>
						    <c:if test="${board_pageMaker.next && board_pageMaker.endPage>0}">
						    <li>
						        <a href='<c:url value="userWritingList.do?userId=${userId}&page=${board_pageMaker.endPage+1}"/>' class="button"></a>
						    </li>
						    </c:if>
						</ul>
					</div>
				</div>
			</div>
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