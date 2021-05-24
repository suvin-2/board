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
	//new_user_list();
});

//카테고리 조회
function category_select(){
	
	// 카테고리 조회(category controller)
	$.ajax({
		url : '/categoryList.do',
		type : 'GET',
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			console.log(data);
			
			var unique_cName = [];
			var j=0;
			var k=1;
			// cName 중복제거
			for(var i=0;i<data.length-1;i++){
				if(data[i].cName != data[i+1].cName){
					unique_cName[0] = data[0].cName;
					j++;
					unique_cName[j] = data[i+1].cName;
				}
			}
			
			// 카테고리 category_tbody에 append
			for(var i=0;i<unique_cName.length;i++){
				$("#category_tbody").append("<tr id='category_tr"+i+"'></tr>");
				$("#category_tr"+i).append("<td></td>");
				for(var j=0;j<data.length;j++){
					if(unique_cName[i] == data[j].cName) {
						$("#cName"+i).append("<option value='"+data[j].cName+"' id='"+k+"'>"+data[j].sName+"</option>");
						k++;
					}
				}
			}
			
			
		}
	});
	
}
</script>
<style type="text/css">
#title {
	text-align : left;
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
					<!-- 카테고리 수정/삭제 -->
					<section>
						<header class="major">
							<h2>카테고리 관리</h2>
						</header>
						<div class="box">
							<div>
								<p style="text-align:center;">카테고리 수정/삭제</p>
								<table>
									<tr>
										<th>카테고리 대분류</th>
										<th>카테고리 소분류</th>
									</tr>
									<tbody id="category_tbody"></tbody>
								</table>
							</div>
							<!-- 
							<div>
								<p style="text-align:center;">카테고리 수정 후</p>
								<table>
									<tr>
										<th>카테고리 대분류</th>
										<th>카테고리 소분류</th>
									</tr>
									<tbody id="update_after_tbody"></tbody>
								</table>
							</div>
							 -->
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