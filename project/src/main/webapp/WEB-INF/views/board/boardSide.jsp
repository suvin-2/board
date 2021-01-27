<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	
	var cName = $('#cName');
	
	// boardInfo() 함수를 즉시 실행
	$(function(){
		
		categoryInfo();
	});
	
	// 수정할 게시글 내용 가지고 오는 ajax
	function categoryInfo(){
		$.ajax({
			url : '/categoryList.do', 
			type : 'GET',
			dataType : 'json',
			error : function(xhr, status, msg) {
				alert("상태값 : "+status+", Http 에러메시지 : "+msg);
			},
			success : function(data) {
				console.log(data);
				console.log(data[1]);
				var list = JSON.stringify(data);
				console.log(list);
				
				var cList = {};
				data.forEach(function(item){
					var cName = cList[item.cName] = cList[item.cName] || {};
					cList[item.sName] = true;
				});
				
				console.log(JSON.stringify(cList,null,4));
				console.log(cList);
			}
		});
	}
	
</script> 
</head>
<body>
	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
			<div id="sidebar">
				<div class="inner">
						<section id="search" class="alt">
							<form method="post" action="#">
								<input type="text" name="query" id="query" placeholder="Search" />
							</form>
						</section>
					<!-- Menu -->
						<nav id="menu">
							<header class="major">
								<h2>Menu</h2>
							</header>
							<ul>
							<c:forEach var="cNameList" items="${cNameList}">
								<li>
									<span class="opener" id="cName">${cNameList.cName}</span>
									<c:forEach var="sNameList" items="${sNameList}">
										<c:if test="${cNameList.cName eq sNameList.cName}">
										<ul>
											<li><a href="${path}/boardList.do?sName=${sNameList.sName}" id="sName">${sNameList.sName}</a></li>
										</ul>
										</c:if>
									</c:forEach>
								</li>
							</c:forEach>
							</ul>
						</nav>
	
					<!-- Section -->
						<section>
							<header class="major">
								<h2>Get in touch</h2>
							</header>
							<p>Sed varius enim lorem ullamcorper dolore aliquam aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin sed aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
							<ul class="contact">
								<li class="icon solid fa-envelope"><a href="#">lsbinnn7@gmail.com</a></li>
								<li class="icon solid fa-phone">010-0000-0000</li>
								<li class="icon solid fa-home">https://www.tistory.com/</li>
							</ul>
						</section>
	
					<!-- Footer -->
						<footer id="footer">
							<p class="copyright">&copy; Untitled. All rights reserved. Demo Images: <a href="https://unsplash.com">Unsplash</a>. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
						</footer>
	
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