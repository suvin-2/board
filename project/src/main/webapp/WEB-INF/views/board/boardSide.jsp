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
		}
	});
}
function boardSearch(){
	if($("#keyword").val() == "") {
		alert("검석어를 입력하세요.");
	} else {
		searchForm.submit();
	}
}
</script> 
<style>
#keyword {
	display : inline;
	width : 80%
}
#search_btn {
	vertical-align : -5px;
	margin : 0 0 0 10px;
}
</style>
</head>
<body>
	<!-- Sidebar -->
	<div id="sidebar">
		<div class="inner">
			<section class="alt">
				<form name="searchForm" method="get" action="/boardSearchList.do">
					<div id="search_btn">
						<input type="text" id="keyword" name="keyword" value="${keyword}" placeholder="게시글, 댓글, 작성자 검색" />
						<img src="/images/search_icon.png" id="search_btn" onclick="boardSearch()">
					</div>
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
				<p>
					안녕하세요 관리자입니다.<br>
					제 사이트에 방문해 주셔서 감사합니다.<br>
					궁금한 점이나 문의사항이 있으시면 <br>
					아래의 메일로 회신 부탁드립니다.
				</p>
				<ul class="contact">
					<li class="icon solid fa-envelope"><a href="mailto:﻿lsbinnn7@gmail.com">lsbinnn7@gmail.com</a></li>
					<li class="icon solid fa-phone">010-0000-0000</li>
					<li class="icon solid fa-home"><a href="https://dailymao.tistory.com/">https://dailymao.tistory.com/</a></li>
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