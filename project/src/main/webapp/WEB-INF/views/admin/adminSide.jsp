<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<!-- Sidebar -->
<div id="sidebar">
	<div class="inner">
		<!-- Menu -->
		<nav id="menu">
			<header class="major">
				<h2>ADMIN</h2>
			</header>
			<ul>
				<li>
					<a href="${path}/adminAllUserForm.do">회원 관리</a>
				</li>
				<li>
					<span class="opener">게시판 관리</span>
					<ul>
						<li><a href="${path}/adminCategoryForm.do">카테고리</a></li>
						<li><a href="${path}/adminBoardForm.do">게시글</a></li>
						<li><a href="${path}/adminReplyForm.do">댓글</a></li>
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
				<li class="icon solid fa-phone">010-9611-9327</li>
				<li class="icon solid fa-home">https://dailymao.tistory.com/</li>
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