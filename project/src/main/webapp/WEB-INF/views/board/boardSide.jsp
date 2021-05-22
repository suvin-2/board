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
	
	// boardInfo() 함수를 즉시 실행
	$(function(){
		
		categoryInfo();
		console.log(list);
	});
	
	var list = [];
	// cName만 담긴 리스트
	var cNameList = new Array();			// JSON.stringify(data);
	// sName만 담긴 리스트
	var sNameList = [];
	// cName 중복 제거한 값만 담긴 리스트
	var finalData = [];
	
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
				for(i in data) {
					list[i] = data[i];
					cNameList[i] = data[i].cName;
				}
				console.log(list);
				console.log("cName List : "+cNameList);
				
				// cName 중복제거
				$.each(cNameList,function(i,value){
					if(finalData.indexOf(value) == -1) {
						finalData.push(value);
					}
				});
				
				for(var i=0;i<finalData.length;i++) {
					$("#sideLi").append("<span id='cName' style='font-weight : bold;'>"+finalData[i]+"</span>");
					for(var j=0;j<cNameList.length;j++) {
						if(finalData[i] == list[j].cName) {
							$("#sideLi").append("<a href='${path}/boardList.do?cName="+list[j].cName+"&sName="+list[j].sName+"&cNo="+list[j].cNo+"' id='sName'>"+list[j].sName+"</a>");
						}
					}
				}
				// class opener가 안먹음...
				/*
				for(var i=0;i<finalData.length;i++) {
					$("#sideUl").append("<li id='sideLi"+i+"'></li>");
					console.log($("#sideLi"+i).text());
					
					$("#sideLi"+i).append("<span id='cName' class='opener'>"+finalData[i]+"</span>");
					$("#sideLi"+i).append("<ul id='chidUl"+i+"'></ul>");
					
					for(var j=0;j<cNameList.length;j++) {
						if(finalData[i] == list[j].cName) {
							$("#chidUl"+i).append("<li><a href='${path}/boardList.do?cName="+list[j].cName+"&sName="+list[j].sName+"&cNo="+list[j].cNo+"' id='sName'>"+list[j].sName+"</a></li>");
						}
					}
				}
				*/
			}
		});
	}
	
</script> 
</head>
<body>
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
							<!-- 
							<ul id="sideUl">
							</ul>
							 -->
							
							<ul>
								<li id="sideLi">
								</li>
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
<!-- Scripts -->
<script src="js/jquery.min.js"></script>
<script src="js/browser.min.js"></script>
<script src="js/breakpoints.min.js"></script>
<script src="js/util.js"></script>
<script src="js/main.js"></script>
</body>
</html>