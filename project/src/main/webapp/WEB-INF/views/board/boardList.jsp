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
	    <th>수정</th>
	    <th>삭제</th>
	  </tr>
	</thead>
	<tbody>
	<c:forEach var="item" items="${list}">
	  <tr>
	    <td id="bNo">${item.bNo}</td>
	    <td id="title">${item.title}</td>
	    <td id="content">${item.content}</td>
	    <td id="bDate">${item.bDate}</td>
	    <td id="cnt">${item.cnt}</td>
	    <td id="writer">${item.writer}</td>
	    <td><a href="${path}/boardUpdateForm.do?bNo=${item.bNo}">수정</a></td>
	    <td><a href="${path}/boardDelete.do?bNo=${item.bNo}" onclick="return confirm('게시글을 삭제하시겠습니까?');">삭제</a></td>
	  </tr>
	</c:forEach>
	</tbody>
</table>
<br>
<a href="boardInsertForm.do">글쓰기</a>
</body>
</html>