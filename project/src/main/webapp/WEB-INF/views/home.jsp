<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="board/boardHeader.jsp" %>
<title>suvin's cooking class</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
</head>
<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
	
		<!-- Main -->
			<div id="main">
				<div class="inner">	
					<!-- Banner -->
						<section id="banner">
							<div class="content">
								<header>
									<h1>Hi, I’m Editorial<br />
									by HTML5 UP</h1>
									<p>A free and fully responsive site template</p>
								</header>
								<p>Aenean ornare velit lacus, ac varius enim ullamcorper eu. Proin aliquam facilisis ante interdum congue. Integer mollis, nisl amet convallis, porttitor magna ullamcorper, amet egestas mauris. Ut magna finibus nisi nec lacinia. Nam maximus erat id euismod egestas. Pellentesque sapien ac quam. Lorem ipsum dolor sit nullam.</p>
								<ul class="actions">
									<li><a href="#" class="button big">Learn More</a></li>
								</ul>
							</div>
							<span class="image object">
								<img src="images/pic10.jpg" alt="" />
							</span>
						</section>
	
					<!-- Section -->
						<section>
							<header class="major">
								<h2>Erat lacinia</h2>
							</header>
							<div class="features">
								<article>
									<span class="icon fa-gem"></span>
									<div class="content">
										<h3>Portitor ullamcorper</h3>
										<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
									</div>
								</article>
								<article>
									<span class="icon solid fa-paper-plane"></span>
									<div class="content">
										<h3>Sapien veroeros</h3>
										<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
									</div>
								</article>
								<article>
									<span class="icon solid fa-rocket"></span>
									<div class="content">
										<h3>Quam lorem ipsum</h3>
										<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
									</div>
								</article>
								<article>
									<span class="icon solid fa-signal"></span>
									<div class="content">
										<h3>Sed magna finibus</h3>
										<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
									</div>
								</article>
							</div>
						</section>
	
					<!-- Section -->
						<section>
							<header class="major">
								<h2>Ipsum sed dolor</h2>
							</header>
							<div class="posts">
								<article>
									<a href="#" class="image"><img src="images/pic01.jpg" alt="" /></a>
									<h3>Interdum aenean</h3>
									<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
									<ul class="actions">
										<li><a href="#" class="button">More</a></li>
									</ul>
								</article>
								<article>
									<a href="#" class="image"><img src="images/pic02.jpg" alt="" /></a>
									<h3>Nulla amet dolore</h3>
									<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
									<ul class="actions">
										<li><a href="#" class="button">More</a></li>
									</ul>
								</article>
							</div>
						</section>
	
				</div>
			</div>
			<!-- side var -->
				<aside>
		           <jsp:include page = "board/boardSide.jsp" /> 
		        </aside>
	</div>

<!-- Scripts -->
<script src="js/jquery.min.js"></script>
<script src="js/browser.min.js"></script>
<script src="js/breakpoints.min.js"></script>
<script src="js/util.js"></script>
<script src="js/main.js"></script>
</body>
</html>