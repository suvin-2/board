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
	new_user_list();
});

//신규 가입자(최근 10명)
function new_user_list() {
	
	$.ajax({
		url : '/newUserList.do',
		type : 'GET',
		dataType : 'json',
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			var j=0;
			var today = moment().format('YYYY-MM-DD');
			var joinDate_format = moment(data[0].joinDate).format('YYYY-MM-DD');
			if(today == joinDate_format) {
				if(data.length < 10){
					for(var i=0;i<data.length;i++) {
						j=i+1;
						$("#new_user_tbody").append("<tr id='new_user_tr_"+i+"'></tr>");
						$("#new_user_tr_"+i).append("<td>"+j+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].userId+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].userName+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].email+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].tel+"</td>");
						$("#new_user_tr_"+i).append("<td>"+moment(data[i].joinDate).format('YYYY-MM-DD')+"</td>");
					}
				} else if(data.length >= 10){
					for(var i=0;i<10;i++) {
						j=i+1;
						$("#new_user_tbody").append("<tr id='new_user_tr_"+i+"'></tr>");
						$("#new_user_tr_"+i).append("<td>"+j+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].userId+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].userName+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].email+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].tel+"</td>");
						$("#new_user_tr_"+i).append("<td>"+moment(data[i].joinDate).format('YYYY-MM-DD')+"</td>");
					}
				}
			} else {
				$("#new_user").empty();
				$("#new_user").append("<div class='box'><p style='text-align: center;'>신규 가입자가 없습니다.</p></div>");
			}
			
		}
	});
}
</script>
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
							<h2>신규 가입자(최근 10명)</h2>
						</header>
							<div id="new_user">
								<!-- 신규 가입자(최근 10명) -->
								<table border="1">
									<thead>
									  <tr>
									  	<th>NO.</th>
									  	<th>아이디</th>
									    <th>이름</th>
									    <th>이메일</th>
									    <th>전화번호</th>
									    <th>가입일</th>
									  </tr>
									</thead>
									<tbody id="new_user_tbody">
									</tbody>
								</table>
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