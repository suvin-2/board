<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board list</title>
</head>
<body>
<h3>글 목록</h3>
<table border="1">
	<thead>
	  <tr>
	    <th>번호</th>
	    <th>제목</th>
	    <th>본문</th>
	    <th>작성일</th>
	    <th>조회수</th>
	    <th>작성자</th>
	  </tr>
	</thead>
	<tbody>
	<c:forEach var="item" items="${list}">
	  <tr>
	    <td>${item.bNo}</td>
	    <td>${item.title}</td>
	    <td>${item.content}</td>
	    <td>${item.bDate}</td>
	    <td>${item.cnt}</td>
	    <td>${item.writer}</td>
	  </tr>
	</c:forEach>
	</tbody>
</table>
<br>
<a href="boardInsertForm.do">글쓰기</a>

</body>
</html>