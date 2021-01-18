<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board update</title>
</head>
<body>

<h3>글 수정</h3>
<c:url var="update" value="${path}/boardUpdate.do" />
<form:form commandName="boardVO" action="${update}" name="boardVO" method="post">
<form:input type = "hidden" path="bNo" id="bNo" value="${item.bNo}"/>
	<table>
		<tbody>
			<tr>
			   <th>제목</th>
			   <td><form:input path="title" id="title" size="20" maxlength="20" />${item.title}</td>
			</tr>
			<tr>
			   <th>작성자</th>
			   <td><form:input path="writer" id="writer" size="20" maxlength="20" /></td>
			</tr>
			<tr>
			   <th>내용</th>
			   <td><form:textarea path="content" id="content" />${item.content}</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="수정"/></td>
			</tr>
		</tbody>
	</table>
</form:form>
</body>
</html>