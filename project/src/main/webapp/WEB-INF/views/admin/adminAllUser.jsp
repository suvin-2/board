<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>suvin's cooking class admin page</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<script>
$(function(){
	
});

// 계정 활성화/비활성화 시 메일 전송
function userActivity(userId, email, enabled) {
	 
	 if(enabled == 1) {

		 if(confirm(userId+'님의 계정을 비활성화 하시겠습니까?') == true){
				
				$.ajax({
					url : '/userStopActivity.do',
					type : 'GET',
					data : {'userId':userId},
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					error : function(xhr, status, msg) {
						console.log("ajax 실패");
						console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
					},
					success : function(data) {
						var enabled = data;
						$.ajax({
							url : 'userActivityEmail.do',
							type : 'GET',
							data : {'email':email,'enabled':enabled,'userId':userId},
							error : function(xhr, status, msg) {
								console.log("ajax 실패");
								console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
							},
							success : function(data) {
								console.log(data);
								alert(userId+'님에게 활동중지 관련 메일이 전송되었습니다.');
								// 페이지 새로고침
								location.href = location.href;
							}
						});
					}
				});
				
			} else {
				alert('계정이 비활성화 되지 않았습니다.');
			}
	 } else {

		 if(confirm(userId+'님의 계정을 활성화 하시겠습니까?') == true){
				
				$.ajax({
					url : '/userResumeActivity.do',
					type : 'GET',
					data : {'userId':userId},
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					error : function(xhr, status, msg) {
						console.log("ajax 실패");
						console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
					},
					success : function(data) {
						var enabled = data;
						$.ajax({
							url : 'userActivityEmail.do',
							type : 'GET',
							data : {'email':email,'enabled':enabled,'userId':userId},
							error : function(xhr, status, msg) {
								console.log("ajax 실패");
								console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
							},
							success : function(data) {
								console.log(data);
								alert(userId+'님에게 활동재개 관련 메일이 전송되었습니다.');
								// 페이지 새로고침
								location.href = location.href;
							}
						});
					}
				});
				
			} else {
				alert('계정이 활성화 되지 않았습니다.');
			}
	 }
	 
}
</script>
<style>
table th {
	text-align : center;
}
table td {
	text-align : center;
}
</style>
</head>
<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- side var -->
		<jsp:include page="adminSide.jsp" flush="false"/>
		<!-- Main -->
			<div id="main">
				<div class="inner">	
					<!-- Header -->
					<%@ include file="/WEB-INF/views/board/boardHead.jsp"%>
					<!-- Section -->
					<section>
						<header class="major">
							<h2>전체 회원</h2>
						</header>
						<div id="all_user">
							<table border="1">
								<thead>
									<tr>
									  	<th>아이디</th>
									    <th>이름</th>
									    <th>생년월일</th>
									    <th>성별</th>
									    <th>이메일</th>
									    <th>전화번호</th>
									    <th>가입일</th>
									    <th>활동중지</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${list}">
									<fmt:formatDate var="joinDate" value="${item.joinDate}" pattern="yyyy-MM-dd HH:MM"/>
									<fmt:parseDate value='${item.birthday}' var='birthday' pattern='yyyy-MM-dd HH:mm:ss.S'/>
									<fmt:formatDate var="birthday" value="${birthday}" pattern="yyyy-MM-dd"/>
										<tr>
										    <td id="userId">${item.userId}</td>
										    <td id="userName">${item.userName}</td>
										    <td id="birthday">${birthday}</td>
										    <c:choose>
										    	<c:when test="${item.gender eq 'F'}">
										    		<td id="gender">여자</td>
										    	</c:when>
										    	<c:when test="${item.gender eq 'M'}">
										    		<td id="gender">남자</td>
										    	</c:when>
										    </c:choose>
										    <td id="email">${item.email}</td>
										    <td id="tel">${item.tel}</td>
										    <td id="joinDate">${joinDate}</td>
										    <c:choose>
										    	<c:when test="${item.enabled eq 1}">
										    		<td><input type="button" class="button" id="stop_activity_btn" onclick="userActivity('${item.userId}','${item.email}',${item.enabled})" value="활동중지"></td>
										    	</c:when>
										    	<c:when test="${item.enabled eq 0}">
										    		<td><input type="button" class="button primary" id="resumex_activity_btn" onclick="userActivity('${item.userId}','${item.email}',${item.enabled})" value="활동재개"></td>
										    	</c:when>
										    </c:choose>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="pagingBnt">
							  <ul class="pagination">
							    <c:if test="${pageMaker.prev}"> 
							    <li> 
							        <a href='<c:url value="adminAllUserForm.do?page=${pageMaker.startPage-1}"/>' class="button"></a>
							    </li>
							    </c:if>
							    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
							    <li>
							        <a href='<c:url value="adminAllUserForm.do?page=${pageNum}"/>' class="page active">${pageNum}</a>
							    </li>
							    </c:forEach>
							    <c:if test="${pageMaker.next && pageMaker.endPage>0}">
							    <li>
							        <a href='<c:url value="adminAllUserForm.do?page=${pageMaker.endPage+1}"/>' class="button"></a>
							    </li>
							    </c:if>
							</ul>
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