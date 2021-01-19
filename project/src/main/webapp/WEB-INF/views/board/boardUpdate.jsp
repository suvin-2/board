<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head profile="http://www.w3.org/2005/10/profile">
<meta charset="UTF-8">
<title>board update</title>

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
				$('input:text[name="title"]').val(data.title);
				$('textarea[name="content"]:visible').val(data.content);
				$('input:text[name="writer"]').val(data.writer);
				$("#writer").attr("disabled",true);
			}
		});
	}

</script> 
</head>
<body>

<h3>글 수정</h3>
<c:url var="update" value="${path}/boardUpdate.do" />
<form:form commandName="boardVO" action="${update}" name="boardVO" method="post">
	<table>
		<tbody>
			<tr>
			   <th>제목</th>
			   <td><form:input path="title" name="title" id="title" size="20" maxlength="20" /></td>
			</tr>
			<tr>
			   <th>작성자</th>
			   <td><form:input path="writer" name="writer" id="writer" size="20" maxlength="20" disabled="disabled"/></td>
			</tr>
			<tr>
			   <th>내용</th>
			   <td><form:textarea path="content" name="content" id="content" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="수정"/></td>
			</tr>
		</tbody>
	</table>
</form:form>
</body>
</html>