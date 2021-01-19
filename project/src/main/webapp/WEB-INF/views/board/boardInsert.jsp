<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board insert</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
$(function(){
	$("#submit").click(function(){
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

</script>
</head>
<body>

<h3>글 등록</h3>
<c:url var="insert" value="/boardInsert.do" />
<form:form commandName="boardVO" action="${insert}" name="boardVO" method="post">
	<table>
		<tbody>
			<tr>
			   <th>제목</th>
			   <td><form:input path="title" id="title" size="20" maxlength="20" /></td>
			</tr>
			<tr>
			   <th>작성자</th>
			   <td><form:input path="writer" id="writer" size="20" maxlength="20" /></td>
			</tr>
			<tr>
			   <th>내용</th>
			   <td><form:textarea path="content" id="content" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" id="submit" value="등록"/></td>
			</tr>
		</tbody>
	</table>
</form:form>
</body>
</html>