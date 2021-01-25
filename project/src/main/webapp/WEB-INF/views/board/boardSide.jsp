<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page session="false" %>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
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
								<li><a href="/">Homepage</a></li>
								<li><a href="/boardList.do">자유게시판</a></li>
								<li>
									<span class="opener">베이킹</span>
									<ul>
										<li><a href="/categoryList.do">케이크</a></li>
										<li><a href="#">빵</a></li>
										<li><a href="#">쿠키</a></li>
									</ul>
								</li>
								<li>
									<span class="opener">한식/일식/중식/양식</span>
									<ul>
										<li><a href="#">한식</a></li>
										<li><a href="#">일식</a></li>
										<li><a href="#">중식</a></li>
										<li><a href="#">양식</a></li>
									</ul>
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
	
	</div>

<!-- Scripts -->
<script src="js/jquery.min.js"></script>
<script src="js/browser.min.js"></script>
<script src="js/breakpoints.min.js"></script>
<script src="js/util.js"></script>
<script src="js/main.js"></script>
</body>
</html>