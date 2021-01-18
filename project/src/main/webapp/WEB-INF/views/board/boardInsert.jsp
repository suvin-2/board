<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board insert</title>
<script>
function check(form) {
	
	var title = form.title.value;
	var writer = form.writer.value;
	var content = form.content.value;
	
	if (title.trim() == '' || title.trim() == null){
		alert("제목을 입력해주세요");
		return false;
	}
	if (writer.trim() == '' || writer.trim() == null){
		alert("작성자를 입력해주세요");
		return false;
	}
	if (content.trim() == '' || content.trim() == null){
		alert("내용을 입력해주세요");
		return false;
	}
	
	form.submit();
}
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
				<td colspan="2"><input type="submit" value="등록" onclick="check()"/></td>
			</tr>
		</tbody>
	</table>
</form:form>
</body>
</html>