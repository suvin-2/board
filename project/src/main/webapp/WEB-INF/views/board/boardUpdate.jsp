<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head profile="http://www.w3.org/2005/10/profile">
<meta charset="UTF-8">
<title>suvin's cooking class</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<script type="text/javascript">

	var bNo = "<%= request.getParameter("bNo") %>";
	 
	console.log("bNo : "+bNo);

	// boardInfo() 함수를 즉시 실행
	$(function(){
		
		boardInfo();
		console.log($("#category option:selected").text());
		console.log($("#category option:selected").val());
		
		$("#submit").click(function(){
			if($("#category option:selected").text()=='카테고리 선택') { 
				alert("카테고리를 선택하세요."); 
				$("#category").focus(); 
				return false; 
			}
			if($("#title").val().length==0) { 
				alert("제목을 입력하세요."); 
				$("#title").focus(); 
				return false; 
			}
			if($("#writer").val().length==0) { 
				alert("작성자를 입력하세요."); 
				$("#writer").focus(); 
				return false; 
			}
			if($("#content").val().length==0) { 
				alert("내용을 입력하세요."); 
				$("#content").focus(); 
				return false; 
			}
		});
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
				console.log(data.sName);
				$('input:text[name="title"]').val(data.title);
				$('textarea[name="content"]:visible').val(data.content);
				$('input:text[name="writer"]').val(data.writer);
				$("#writer").attr("disabled",true);
			}
		});
	}

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
						<header class="major">
							<h2>글 수정</h2>
						</header>
						<c:url var="update" value="${path}/boardUpdate.do" />
						<form:form commandName="boardVO" action="${update}" name="boardVO" method="post">
						<form:input type="hidden" path="bNo" id="bNo" value="${item.bNo}"/>
							<table border="1">
							<tbody>
								<tr>
								   <th>카테고리</th>
								   <td>
								   		<form:select path="cNo" id="category" name="category">
									   		<option value="">카테고리 선택</option>
									   		<!-- cName 중복제거 -->
								    		<c:set var="cList" value=""/>
									   		<c:forEach var="item" items="${list}" varStatus="status">
									   			<c:if test="${item.cName ne cList}">
								   					<c:set var="cList" value="${item.cName}"/>
											   		<optgroup label="${cList}" id="cName"></optgroup>
									   			</c:if>
									   			<c:if test="${item.cName eq cList}">
									   				<c:set var="cNo" value="${item.cNo}"/>
									   				<fmt:parseNumber var="cNo" value="${item.cNo}" type="number" />
										   			<form:option value="${cNo}" label="${item.sName}" />
										   		</c:if>
									   		</c:forEach>
									   	</form:select>
								   </td>
								</tr>
								<tr>
								   <th>제목</th>
								   <td colspan="3"><form:input path="title" name="title" id="title" size="20" maxlength="20" /></td>
								</tr>
								<tr>
								   <th>작성자</th>
								   <td colspan="3"><form:input path="writer" name="writer" id="writer" size="20" maxlength="20" disabled="disabled"/></td>
								</tr>
								<tr>
								   <th>내용</th>
								   <td colspan="3"><form:textarea path="content" name="content" id="content" /></td>
								</tr>
							</tbody>
						</table>
						<div align="center">
							<input type="submit" id="submit" value="수정"/>
							<input type="button" id="back" onclick="history.back()" value="돌아가기"/>
						</div>
						</form:form>
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