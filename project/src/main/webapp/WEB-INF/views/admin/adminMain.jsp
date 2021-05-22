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
					<!-- 방문자 통계 -->
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
					
					<!-- 새글/새댓글 통계 -->
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
							<h2>신규 가입자(최근 10명)</h2>
						</header>
							<div id="new_user_table">
								<!-- 신규 가입자(최근 10명) -->
								<table border="1">
									<thead>
									  <tr>
									  	<th>아이디</th>
									    <th>이름</th>
									    <th>이메일</th>
									    <th>전화번호</th>
									    <th>가입일</th>
									  </tr>
									</thead>
									<tbody>
									<%-- 
									<c:forEach var="item" items="${list}" begin="0" end="9">
									<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
									<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
									  <tr onClick = "location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}&writer=${item.writer}'">
									    <td id="bNo">${item.bNo}</td>
									    <td id="title">${item.title}</td>
									    <td id="cName">${item.cName}</td>
									    <td id="bDate">${bDate}</td>
									  </tr>
									</c:forEach>
									 --%>
									</tbody>
								</table>
							</div>
					</section>
					<hr>
					<section>
						<header class="major">
							<h2>좋아요 TOP5</h2>
						</header>
							<div id="like_top5">
								<!-- 좋아요 TOP5 -->
								<table border="1">
									<thead>
									  <tr>
									  	<th>카테고리</th>
									    <th>제목</th>
									    <th>작성자</th>
									    <th>작성일</th>
									    <th>조회수</th>
									  </tr>
									</thead>
									<tbody>
									<%-- 
									<c:forEach var="item" items="${list}" begin="0" end="9">
									<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
									<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
									  <tr onClick = "location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}&writer=${item.writer}'">
									    <td id="bNo">${item.bNo}</td>
									    <td id="title">${item.title}</td>
									    <td id="cName">${item.cName}</td>
									    <td id="bDate">${bDate}</td>
									  </tr>
									</c:forEach>
									 --%>
									</tbody>
								</table>
							</div>
					</section>
				</div>
			</div>
	</div>
<!-- Scripts -->
<script>

// 인기 카테고리 more 버튼 클릭 시 페이지 이동
var cName1 = $("#cName1").val();
var sName1 = $("#sName1").val();


function category1(){
	//location.href = "${path}/boardList.do?cName="+cName1+"&sName="+sName1+"&cNo="+${cNo1};
}
	
</script>
<script src="js/jquery.min.js"></script>
<script src="js/browser.min.js"></script>
<script src="js/breakpoints.min.js"></script>
<script src="js/util.js"></script>
<script src="js/main.js"></script>
</body>
</html>