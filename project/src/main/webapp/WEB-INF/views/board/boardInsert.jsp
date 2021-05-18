<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board insert</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<%  String sName = request.getParameter("sName"); 
	String cNo = request.getParameter("cNo"); 
	System.out.println("boardInsert.jsp 넘어온 sName : " + sName);
%>
<script type="text/javascript">
$(function(){

	// 카테고리 seleced
	$("#category").val("<%=cNo%>").prop("selected",true);

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
	
	// 선택된 카테고리 확인 (sName)
	$("#category").change(function(){
		
		var cNoType = $(this).val();
		console.log($(this).val()); //value값 가져오기
		// string -> number 변환
		cNoType = Number(cNoType);
		
		console.log($("#category option:selected").text()); //text값 가져오기
		console.log($("#category option:selected").val()); //text값 가져오기
	});
	
	function cNoSelected() {
		
		console.log('sName : '+<%= sName %>);
		console.log('cNoSelect : '+$("#category").text());
		
		<%-- if($("#cNoSelect").val()=="<%= sName %>") {
			$("#cNoSelect").attr("selected","selected");
		} --%>
	}
	
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
						<header class="major">
							<h2>글 등록</h2>
						</header>
						<c:url var="insert" value="/boardInsert.do" />
						<form:form commandName="boardVO" action="${insert}" name="boardVO" method="post">
						<form:input type="hidden" path="writer" id="writer" value="<%= userId %>"/>
							<table border="1">
								<tbody>
									<tr>
									   <th>카테고리</th>
									   <td>
									   		<form:select path="cNo" id="category" name="category" required="required">
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
											   			<form:option id="cNoSelect" value="${cNo}" label="${item.sName}" />
											   		</c:if>
										   		</c:forEach>
										   	</form:select>
									   </td>
									</tr>
									<tr>
									   <th>제목</th>
									   <td colspan="3"><form:input path="title" id="title" size="20" maxlength="1000" /></td>
									</tr>
									<tr>
									   <th>작성자</th>
									   <td colspan="3"><input type="text" id="writer_print" size="20" value="<%= userId %>" readonly/></td>
									</tr>
									<tr>
									   <th>내용</th>
									   <td colspan="3"><form:textarea path="content" id="content" /></td>
									</tr>
								</tbody>
							</table>
							<div align="center">
								<input type="submit" id="submit" class="button primary" value="등록"/>
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
