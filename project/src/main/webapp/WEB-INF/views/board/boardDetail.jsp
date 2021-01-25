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
<script type="text/javascript">

	var bNo = "<%= request.getParameter("bNo") %>";
	 
	console.log("bNo : "+bNo);

	
	// boardInfo() 함수를 즉시 실행
	$(function(){
		
		boardInfo();
		
	});
	
	// 수정할 게시글 내용 가지고 오는 ajax
	function boardInfo(){
		$.ajax({
			url : 'boardListOne/'+ bNo, 
			type : 'GET',
			dataType : 'json',
			error : function(xhr, status, msg) {
				alert("상태값 : "+status+", Http 에러메시지 : "+msg);
			},
			success : function(data) {
				console.log(data);
				
				$('#title').val(data.title);
				$('#writer').val(data.writer);
				$('#bDate').val(data.bDate);
				$('#cnt').val(data.cnt);
				$('#content').val(data.content);
				
			}
		});
	}

	console.log("Ltitle : " + $('#Ltitle').val() );
</script> 
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
						<table border="1">
							  <tr>
							    <th id="Ltitle">제목</th>
							    <th colspan="3"><p id="title"></p></th>
							  </tr>
							  <tr>
							    <th>작성자</th>
							    <td><p id="writer"></p></td>
							  </tr>
							  <tr>
							    <th>작성일</th>
							    <td><p id="bDate"></p></td>
							    <th>조회수</th>
							    <td><p id="cnt"></p></td>
							  </tr>
							  <tr>
							    <th>내용</th>
							    <td><p id="content"></p></td>
							  </tr>
						</table>
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