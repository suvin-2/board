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

	// enabled가 1이면 빨간하트 이미지 출력
	board_like();
	// 좋아요 총 개수
	board_like_all_select();
	
	
	// 게시글에 작성된 댓글이 하나도 없을 때
	if($("#rNo").val() == null) {
		$("#reply").html('댓글이 없습니다.');
	}
	
	// 댓글 등록
	$("#replyWriteBtn").click(function() {
		if($("#rContent_insert").val().length == 0) {
			alert("댓글 내용을 입력하세요.");
			$("#rContent_insert").focus(); 
			return false; 
		} else {
			var bNo_insert = $("#bNo_insert").val();
			var rContent = $("#rContent_insert").val();
			var rWriter = $("#rWriter_insert").val();
			var param = {"bNo":bNo_insert, "rContent":rContent, "rWriter":rWriter};
			
			$.ajax({
				url : '/replyInsert.do',
				data : param,
				type : 'get',
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				error : function(xhr, status, msg) {
					console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
				},
				success : function(data) {
					// 페이지 새로고침
					location.href = location.href;
				}
			});
		}
	});
	
});

//댓글 수정폼 rNo : db에서 받아온 rNo
function reply_update_form(rNo,rWriter,rContent) {
	
	
	// 클릭한 수정버튼이 있는 li
	var reply_li_id = $("#reply_li_"+rNo).attr('id');
	var html = "";
	
	html += '<li id="reply_li_'+rNo+'">';
	html += '<p id="reply_writer">'+rWriter+'</p>';
	html += '<input type="text" id="reply_rContent_edit" value="'+rContent+'"/>';
	html += '<br>';
	html += '<div id="reply_btn">';
	html += '<a class="button small" id="reply_'+rNo+'" onclick="reply_update('+rNo+')">저장</a>&nbsp;';
	html += '<a class="button small" onclick="reply_update_cancle()">취소</a>&nbsp;';
	html += '</div>';
	html += '</li>';
	
	$("#reply_li_"+rNo).replaceWith(html);
	$("#reply_rContent_edit").focus();
}

// 댓글 수정
function reply_update(rNo) {
		
	if($("#reply_rContent_edit").val().length == 0) {
		alert("댓글 내용을 입력하세요.");
		$("#reply_rContent_edit").focus(); 
		return false; 
	} else {
		var rContent = $("#reply_rContent_edit").val();
		var param = {"rContent":rContent, "rNo":rNo};
		
		$.ajax({
			url : '/replyUpdate.do',
			data : param,
			type : 'get',
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
			error : function(xhr, status, msg) {
				console.log("ajax 실패");
				console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
			},
			success : function(data) {
				// 페이지 새로고침
				location.href = location.href;
			}
		});
	}
	
}

// 수정 취소
function reply_update_cancle() {
	location.href = location.href;
}

//댓글 삭제
function reply_delete(rNo) {
	
	$.ajax({
		url : '/replyDelete.do/'+rNo,
		type : 'GET',
		dataType : 'json',
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			alert("댓글이 삭제되었습니다.");
			// 페이지 새로고침
			location.href = location.href;
		}
	});
}

// 좋아요 이미지
function board_like() {
	
	var bNo = $("#bNo").val();
	var userId = $("#userId").val();

	$.ajax({
		url : '/boardLikeSelect.do',
		type : 'GET',
		data : {"bNo":bNo, "userId":userId},
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			if(data.enabled == 1) {
				document.getElementById('like').src = "/images/full_love_icon.png";
			}
			
			// 페이지 새로고침
			//location.href = location.href;
		}
	});
}

//좋아요 이미지 클릭
function board_like_click() {

	var bNo = $("#bNo").val();
	var userId = $("#userId").val();
	
	$.ajax({
		url : '/boardLikeSelect.do',
		type : 'GET',
		data : {"bNo":bNo, "userId":userId},
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			// 좋아요를 눌렀을 때 (update 해주기)
			if(data.enabled == 0) {
				
				$.ajax({
					url : '/boardLikeUpdate.do',
					type : 'GET',
					data : {"bNo":bNo, "userId":userId, "enabled":1},
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					error : function(xhr, status, msg) {
						console.log("ajax 실패");
						console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
					},
					success : function(data) {
						
						board_like_all_select();
						document.getElementById('like').src = "/images/full_love_icon.png";
					}
				});
			  // 좋아요를 눌렀다가 취소했을 때 (update 해주기)	
			} else if(data.enabled == 1) {
				
				$.ajax({
					url : '/boardLikeUpdate.do',
					type : 'GET',
					data : {"bNo":bNo, "userId":userId, "enabled":0},
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					error : function(xhr, status, msg) {
						console.log("ajax 실패");
						console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
					},
					success : function(data) {
						board_like_all_select();
						document.getElementById('like').src = "/images/empty_love_icon.png";
					}
				});
			  // enabled가 null 이면 enabled = 1로 insert 해주기
			} else {
				
				$.ajax({
					url : '/boardLikeInsert.do',
					type : 'GET',
					data : {"bNo":bNo, "userId":userId},
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					error : function(xhr, status, msg) {
						console.log("ajax 실패");
						console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
					},
					success : function(data) {
						board_like_all_select();
						document.getElementById('like').src = "/images/full_love_icon.png";
					}
				});
			}
			
		}
	});
}

//좋아요 이미지 총 개수
function board_like_all_select() {

	var bNo = $("#bNo").val();
	
	$.ajax({
		url : '/boardLikeAllSelect.do',
		type : 'GET',
		data : {"bNo":bNo},
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			var like_cnt = data.length;
			$("#like_cnt").html("좋아요 "+like_cnt+"개   ");
			$("#like_cnt").css("vertical-align","6px");
			
		}
	});
}
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

#content {
	border : none;
}

.board_like {
	text-align : right;
}

#like {
	width : 25px;
	height : 25px;
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
						<c:set value="${item.bNo}" var="bNoCopy"/>
						<c:set value="${item.sName}" var="sNameCopy"/>
						<c:set value="${item.writer}" var="writerCopy"/>
						<input type="hidden" id="bNo" value="${item.bNo}">
						<input type="hidden" id="userId" value="<%= userId %>">
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
							<textarea id="content">${item.content}</textarea>
						</div>
						<br><hr>
						<%  
							if(!userId.equals("anonymousUser")) {
						%>
						<!-- 게시글 좋아요 -->
						<div class="board_like">
							<span id="like_cnt"></span><img src="/images/empty_love_icon.png" id="like" onclick="board_like_click()">
						</div><br>
						<%
							}
						%>
						
						<!-- 댓글 (select) -->
						<div id="reply" class="box">
							<ol class="replyList">
								<c:forEach items="${replyList}" var="replyList">
								<c:set value="${item.cNo}" var="cNoCopy"/>
								<input type="hidden" id="rNo" value="${replyList.rNo}">
									<li id="reply_li_${replyList.rNo}">
												<p id="reply_writer">${replyList.rWriter}</p>
												<p id="reply_content">${replyList.rContent}</p>
												<span id="reply_date"><fmt:formatDate value="${replyList.rDate}" pattern="yyyy-MM-dd HH:mm" /></span>
												<c:set var="userId" value="<%= userId %>"/>
												<c:if test="${replyList.rWriter eq userId}">
													<div id="reply_btn">
														<a class="button small" id="reply_${replyList.rNo}" onclick="reply_update_form(${replyList.rNo},'${replyList.rWriter}','${replyList.rContent}')">수정</a>&nbsp;
														<a class="button small" onclick="reply_delete(${replyList.rNo})">삭제</a>
													</div>
												</c:if>
											</li>
								</c:forEach>   
							</ol>
							<div class="pagingBnt">
								  <ul class="pagination" id="paging_ul">
								    <c:if test="${pageMaker.prev}"> 
								    <li> 
								        <a href='<c:url value="${path}/boardSelectDetail.do?bNo=${bNoCopy}&sName=${sNameCopy}&cNo=${cNoCopy}&writer=${writerCopy}&page=${pageMaker.startPage-1}"/>' class="button"></a>
								    </li>
								    </c:if>
								    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
								    <li>
								        <a href='<c:url value="${path}/boardSelectDetail.do?bNo=${bNoCopy}&sName=${sNameCopy}&cNo=${cNoCopy}&writer=${writerCopy}&page=${pageNum}"/>' class="page">${pageNum}</a>
								    </li>
								    </c:forEach>
								    <c:if test="${pageMaker.next && pageMaker.endPage>0}">
								    <li>
								        <a href='<c:url value="${path}/boardSelectDetail.do?bNo=${bNoCopy}&sName=${sNameCopy}&cNo=${cNoCopy}&writer=${writerCopy}&page=${pageMaker.endPage+1}"/>' class="button"></a>
								    </li>
								    </c:if>
								</ul>
							</div>
						</div>
						
						<%  
							if(!userId.equals("anonymousUser")) {
						%>
							<!-- 댓글 (insert) -->
							<form name="replyForm" method="post">
							<input type="hidden" id="bNo_insert" name="bNo" value="${item.bNo}" />
							<input type="hidden" id="rWriter_insert" name="rWriter" value="<%= userId %>" />
								<div class="box">
									<p id="reply_insert_writer"><%= userId %></p>
									<div class="reply_insert_box">
										<div class="reply_insert_content">
											<input type="text" id="rContent_insert" name="rContent" maxlength="300" placeholder="최대 300자까지 입력가능합니다.">
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
<script type="text/javascript">
// 내용 textarea 스크롤 없애기
var txtArea = $("#content");
if (txtArea) {
    txtArea.each(function(){
        $(this).height(this.scrollHeight);
    });
}
</script>
<script src="js/jquery.min.js"></script>
<script src="js/browser.min.js"></script>
<script src="js/breakpoints.min.js"></script>
<script src="js/util.js"></script>
<script src="js/main.js"></script>
</body>
</html>