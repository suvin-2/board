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
	//탭 컨텐츠 숨기기
	$(".tab_content").hide();

	// 첫번째 탭콘텐츠 보이기
	$(".tab_container").each(function () {
		$(this).children(".tabs li:first").addClass("active"); //Activate first tab
		$(this).children(".tab_content").first().show();
		writing_list();
	});
	
	//탭메뉴 클릭 이벤트
	$(".tabs li a").click(function () {
	  
		$(this).parent().siblings("li").removeClass("active");
		$(this).parent().addClass("active"); $(this).parent().parent().parent().parent().find(".tab_content").hide();
		
		var activeTab = $(this).attr("rel");
		if(activeTab == "tab1"){
			$("#" + activeTab).fadeIn();
			writing_list();
		} else if(activeTab == "tab2") {
			$("#" + activeTab).fadeIn();
			reply_list();
		} else if(activeTab == "tab3") {
			$("#" + activeTab).fadeIn();
			like_list();
		}
	});
});

function writing_list(){
	
	var userId = $("#userId").val();
		
	$.ajax({
		url : '/writingList.do',
		type : 'GET',
		data : {'userId':userId},
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			console.log('user writing list');
			console.log(data);
			var table_html = "";
			var ul_html = "";
			
			for(var i=0;i<data.list.length;i++) {
				//날짜 형식 포맷
				var bDate = moment(data.list[i].bDate).format('YYYY-MM-DD HH:MM');
				var url = "location.href=\"/boardSelectDetail.do?bNo="+data.list[i].bNo+"&sName="+data.list[i].sName+"&cNo="+data.list[i].cNo+"&writer="+data.list[i].writer+"\"";

				table_html += "<tr id='writing_tr' onClick="+url+">";
				table_html += "<td id='writing_sName'>"+data.list[i].sName+"</td>";
				table_html += "<td id='writing_title'>"+data.list[i].title+"</td>";
				table_html += "<td id='writing_writer'>"+data.list[i].writer+"</td>";
				table_html += "<td id='writing_bDate'>"+bDate+"</td>";
				table_html += "<td id='writing_cnt'>"+data.list[i].cnt+"</td>";
				table_html += "</tr>";
			}
			$("#writing_tbody").empty();
			$("#writing_tbody").append(table_html);
			
			if(data.pageMaker.prev == true) {
				ul_html += "<li>";
				ul_html += "<a href='/writingList.do?userId="+userId+"&page="+data.pageMaker.startPage-1+"'></a>";
				ul_html += "</li>";
			}
			for(var pageNum=data.pageMaker.startPage;pageNum<=data.pageMaker.endPage;pageNum++) {
				ul_html += "<li>";
				ul_html += "<a href='/writingList.do?userId="+userId+"&page="+pageNum+"' class='page active'>"+pageNum+"</a>";
				ul_html += "</li>";
			}
			if(data.pageMaker.next == true && data.pageMaker.endPage > 0) {
				ul_html += "<li>";
				ul_html += "<a href='/writingList.do?userId="+userId+"&page="+data.pageMaker.startPage+1+"'></a>";
				ul_html += "</li>";
			}
			
			$("#writing_page").empty();
			$("#writing_page").append(ul_html);
		}
	});
}

function reply_list(){
	
	var userId = $("#userId").val();
		
	$.ajax({
		url : '/replyList.do',
		type : 'GET',
		data : {'userId':userId},
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			var table_html = "";
			var ul_html = "";
			
			for(var i=0;i<data.list.length;i++) {
				//날짜 형식 포맷
				var bDate = moment(data.list[i].bDate).format('YYYY-MM-DD HH:MM');
				var url = "location.href=\"/boardSelectDetail.do?bNo="+data.list[i].bNo+"&sName="+data.list[i].sName+"&cNo="+data.list[i].cNo+"&writer="+data.list[i].writer+"\"";

				table_html += "<tr id='reply_tr' onClick="+url+">";
				table_html += "<td id='reply_sName'>"+data.list[i].sName+"</td>";
				table_html += "<td id='reply_title'>"+data.list[i].title+"</td>";
				table_html += "<td id='reply_rContent'>"+data.list[i].rContent+"</td>";
				table_html += "<td id='reply_bDate'>"+bDate+"</td>";
				table_html += "<td id='reply_cnt'>"+data.list[i].cnt+"</td>";
				table_html += "</tr>";
			}
			$("#reply_tbody").empty();
			$("#reply_tbody").append(table_html);
		}
	});
}

function like_list(){
	
	var userId = $("#userId").val();
		
	$.ajax({
		url : '/likeList.do',
		type : 'GET',
		data : {'userId':userId},
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			var table_html = "";
			var ul_html = "";
			console.log('like list data ----');
			console.log(data);
			for(var i=0;i<data.list.length;i++) {
				//날짜 형식 포맷
				var bDate = moment(data.list[i].bDate).format('YYYY-MM-DD HH:MM');
				var url = "location.href=\"/boardSelectDetail.do?bNo="+data.list[i].bNo+"&sName="+data.list[i].sName+"&cNo="+data.list[i].cNo+"&writer="+data.list[i].writer+"\"";

				table_html += "<tr id='like_tr' onClick="+url+">";
				table_html += "<td id='like_sName'>"+data.list[i].sName+"</td>";
				table_html += "<td id='like_title'>"+data.list[i].title+"</td>";
				table_html += "<td id='like_writer'>"+data.list[i].writer+"</td>";
				table_html += "<td id='like_bDate'>"+bDate+"</td>";
				table_html += "<td id='like_cnt'>"+data.list[i].cnt+"</td>";
				table_html += "</tr>";
			}
			$("#like_tbody").empty();
			$("#like_tbody").append(table_html);
		}
	});
}

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
							</tbody>
						</table>
						<!-- 페이징 -->
						<div class="pagingBnt">
							  <ul class="pagination" id="writing_page">
							    <c:if test="${pageMaker.prev}"> 
							    <li> 
							        <a href='<c:url value="boardList.do?cName=${cNameCopy}&sName=${sNameCopy}&cNo=${cNoCopy}&page=${pageMaker.startPage-1}"/>'></a>
							    </li>
							    </c:if>
							    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
							    <li>
							        <a href='<c:url value="boardList.do?cName=${cNameCopy}&sName=${sNameCopy}&cNo=${cNoCopy}&page=${pageNum}"/>' class="page active">${pageNum}</a>
							    </li>
							    </c:forEach>
							    <c:if test="${pageMaker.next && pageMaker.endPage >0}">
							    <li>
							        <a href='<c:url value="boardList.do?cName=${cNameCopy}&sName=${sNameCopy}&cNo=${cNoCopy}&page=${pageMaker.endPage+1}"/>' class="button"></a>
							    </li>
							    </c:if>
							</ul>
						</div>
					</div>
					<!-- 작성한 댓글 출력 -->
					<div id="tab2" class="tab_content">
						<table border="1">
							<thead>
								<tr>
								  	<th>카테고리</th>
								    <th>제목</th>
								    <th>댓글 내용</th>
								    <th>작성일</th>
								    <th>조회수</th>
							    </tr>
							</thead>
							<tbody id="reply_tbody">
							</tbody>
						</table>
					</div>
					<!-- 좋아요 한 글 출력 -->
					<div id="tab3" class="tab_content">
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
							<tbody id="like_tbody">
							</tbody>
						</table>	
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