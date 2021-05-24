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
$(function(){
	
	category_select();
	
	$("#categorySelect").change(function(){
		
		var html = "";
		var opt_list = $('select').find('option');
		
		var select_sName = $('#categorySelect option:selected').text();
		var select_cName = $('#categorySelect option:selected').val();
		
		for(var i=0;i<opt_list.length;i++){
			if(select_sName == opt_list[i].text){
				// 선택한 값의 id(cNo)
				var select_cNo = opt_list[i].id;
			}
		}
		
		if(select_cName == 'allCategory') {
			category_select();
			// 페이지 새로고침
			location.href = location.href;
			// board controller에 있는 method 사용함
		} else {
			$.ajax({
				url : '/adminBoardSelect.do',
				type : 'GET',
				data : {'cName':select_cName,'sName':select_sName,'cNo':select_cNo},
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				error : function(xhr, status, msg) {
					console.log("ajax 실패");
					console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
				},
				success : function(data) {
					
					if(data.list.length == 0) {
						$("#paging_ul").empty();
						$("#all_user").empty();
						$("#all_user").append("<div class='box'><p style='text-align:center;'>작성된 글이 없습니다.</p></div>");
						
					} else {
						
						for(var j=0;j<data.list.length;j++){
							if(select_cName == data.list[j].cName && select_sName == data.list[j].sName){
								
								var url = "location.href=\"/boardSelectDetail.do?bNo="+data.list[j].bNo+"&sName="+data.list[j].sName+"&cNo="+data.list[j].cNo+"&writer="+data.list[j].writer+"\"";
								var bDate = moment(data.list[j].bDate).format('YYYY-MM-DD HH:MM');
								var param = '\''+data.list[j].writer+"',"+data.list[j].bNo;
								
								html += "<tr>";
								html += "<td onClick='"+url+"'>"+data.list[j].sName+"</td>";
								html += "<td onClick='"+url+"' id='title'>"+data.list[j].title+"</td>";
								html += "<td onClick='"+url+"'>"+data.list[j].writer+"</td>";
								html += "<td onClick='"+url+"'>"+bDate+"</td>";
								html += "<td onClick='"+url+"'>"+data.list[j].cnt+"</td>";
								html += "<td><input type='button' value='삭제' onClick=\"adminBoardDelete("+param+")\" /></td>";
								html += "</tr>";
							}
						}
						$("#boardList_tbody").empty();
						$("#boardList_tbody").append(html);
						
						var startPage = data.pageMaker.startPage-1;
						var endPage = data.pageMaker.endPage+1;
						var ul_html = "";
						
						if(data.pageMaker.prev){
							ul_html += "<li>";
							ul_html += "<a href='<c:url value='adminBoardSelect.do?cName="+data.pageMaker.cri.cName+"&sName="+data.pageMaker.cri.sName+"&page="+startPage+"'/>'  class='button'></a>";
							ul_html += "</li>";
						}
						
						for(var pageNum=data.pageMaker.startPage;pageNum<=data.pageMaker.endPage;pageNum++) {
							ul_html += "<li>";
							ul_html += "<a href='<c:url value='adminBoardSelect.do?cName="+data.pageMaker.cri.cName+"&sName="+data.pageMaker.cri.sName+"&page="+pageNum+"'/>' class='page'>"+pageNum+"</a>";
							ul_html += "</li>";
						}
						
						if(data.pageMaker.next && data.pageMaker.endPage>0){
							ul_html += "<li>";
							ul_html += "<a href='<c:url value='adminBoardSelect.do?cName="+data.pageMaker.cri.cName+"&sName="+data.pageMaker.cri.sName+"&page="+endPage+"'/>'  class='button'></a>";
							ul_html += "</li>";
						}
						
						$("#paging_ul").empty();
						$("#paging_ul").append(ul_html);
					}
				}
					
			});
		}
		
	});

});
// 게시글 삭제
function adminBoardDelete(userId, bNo) {
	 
	if(confirm(userId+'님의 게시글을 삭제하시겠습니까?') == true){
	
			$.ajax({
				url : '/adminBoardDelete.do/'+bNo,
				type : 'GET',
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				error : function(xhr, status, msg) {
					console.log("ajax 실패");
					console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
				},
				success : function(data) {
					alert('게시글이 삭제되었습니다.');
					// 페이지 새로고침
					location.href = location.href;
				}
			});
			
	} else {
		alert('게시글이 삭제되지 않았습니다.');
	}
}

function category_select(){
	
	// 카테고리 조회(category controller)
	$.ajax({
		url : '/categoryList.do',
		type : 'GET',
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			console.log(data);
			
			var unique_cName = [];
			var j=0;
			var k=1;
			// cName 중복제거
			for(var i=0;i<data.length-1;i++){
				if(data[i].cName != data[i+1].cName){
					unique_cName[0] = data[0].cName;
					j++;
					unique_cName[j] = data[i+1].cName;
				}
			}
			$("#categorySelect").append("<option value='allCategory'>카테고리 선택</option>");
			// 카테고리 select에 append
			for(var i=0;i<unique_cName.length;i++){
				$("#categorySelect").append("<optgroup id='cName"+i+"' label='"+unique_cName[i]+"'></optgroup>");
				for(var j=0;j<data.length;j++){
					if(unique_cName[i] == data[j].cName) {
						$("#cName"+i).append("<option value='"+data[j].cName+"' id='"+k+"'>"+data[j].sName+"</option>");
						k++;
					}
				}
				
			}
			
		}
	});
	
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
							<h2>전체 게시글</h2>
						</header>
						<div id="category_div">
								<select id="categorySelect">
								</select>
							</div>
						<div id="all_user">
							<table border="1">
								<thead>
									<tr>
									  	<th>카테고리</th>
									    <th>제목</th>
									    <th>작성자</th>
									    <th>작성일</th>
									    <th>조회수</th>
									    <th>삭제</th>
									</tr>
								</thead>
								<tbody id="boardList_tbody">
									<c:forEach var="item" items="${list}">
									<c:set value="location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}&cNo=${item.cNo}&writer=${item.writer}'" var="url"/>
									<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
									<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
										<tr>
										    <td id="sName" onClick = "${url}">${item.sName}</td>
										    <td id="title" onClick = "${url}">${item.title}</td>
										    <td id="writer" onClick = "${url}">${item.writer}</td>
										    <td id="bDate" onClick = "${url}">${bDate}</td>
										    <td id="cnt" onClick = "${url}">${item.cnt}</td>
										    <td id="boardDeleteBnt"><input type="button" value="삭제" onclick="adminBoardDelete('${item.writer}',${item.bNo})"></td>
										</tr>
								    </c:forEach>
								</tbody>
							</table>
						</div>
						<div class="pagingBnt">
							  <ul class="pagination" id="paging_ul">
							    <c:if test="${pageMaker.prev}"> 
							    <li> 
							        <a href='<c:url value="adminBoardForm.do?page=${pageMaker.startPage-1}"/>' class="button"></a>
							    </li>
							    </c:if>
							    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
							    <li>
							        <a href='<c:url value="adminBoardForm.do?page=${pageNum}"/>' class="page">${pageNum}</a>
							    </li>
							    </c:forEach>
							    <c:if test="${pageMaker.next && pageMaker.endPage>0}">
							    <li>
							        <a href='<c:url value="adminBoardForm.do?page=${pageMaker.endPage+1}"/>' class="button"></a>
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