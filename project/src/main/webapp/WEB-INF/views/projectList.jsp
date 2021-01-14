<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>

<table border="1">
	<thead>
	  <tr>
	    <th>번호</th>
	    <th>제목</th>
	    <th>본문</th>
	    <th>작성일</th>
	  </tr>
	</thead>
	<tbody>
	<c:forEach var="item" items="${list}">
	  <tr>
	    <td>${item.proId}</td>
	    <td>${item.proTitle}</td>
	    <td>${item.proBody}</td>
	    <td>${item.proDate}</td>
	  </tr>
	</c:forEach>
	</tbody>
</table>

</body>
</html>