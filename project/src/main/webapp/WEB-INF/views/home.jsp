<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>suvin's cooking class</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<style>
#title {
	text-align : left;
}
#pTitle {
	text-align : left;
}
</style>
</head>
<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- side var -->
		<jsp:include page="board/boardSide.jsp" flush="false"/>
		<!-- Main -->
		<div id="main">
			<div class="inner">	
				<!-- Header -->
				<%@ include file="/WEB-INF/views/board/boardHead.jsp"%>
				<!-- Banner -->
				<section id="banner">
					<div class="content">
						<header>
							<h1>Cooking Class<br />
							by suvin</h1>
							<p>요리가 생활이 되는 쉬운 레시피</p>
						</header>
						<p>
							매일 SNS에 올리고 싶은 센스 넘치는 플레이팅, 당장이라도 입에 넣고 싶은 음식들, 
							직접 만든 내 요리들을 모두가 맛볼 수 있도록 나만의 꿀팁 대방출!<br>
							여러 회원들의 레시피로 요리해보세요 :)
						</p>
					</div>
					<span class="image object">
						<img src="images/waffles.jpg" alt="" />
					</span>
				</section>
				<hr><br>
				<!-- Section -->
				<section>
					<div class="features">
						<article>
							<span class="icon solid style2 major fa-hashtag"></span>
							<div class="content">
								<h3>다양한 레시피</h3>
								<p>여러분이 정성껏 만든 음식의 레시피를 자랑하세요!<br>다양한 레시피들로 새로운 요리를 만들어보세요 :)</p>
							</div>
						</article>
						<article>
							<span class="icon solid major fa-pencil-alt"></span>
							<div class="content">
								<h3>자유게시판</h3>
								<p>요리뿐 아니라 서로의 일상을 소통할 수 있어요.<br>여러분의 취미생활은 무엇인가요?</p>
							</div>
						</article>
					</div>
				</section><br><br>
				<!-- Section -->
				<section>
					<header class="major">
						<h2>전체글</h2>
					</header>
						<!-- 카페 내 전체 글 -->
						<table border="1">
							<thead>
							    <tr>
							    	<th>No.</th>
								    <th>제목</th>
								    <th>카테고리</th>
								  	<th>작성자</th>
								    <th>작성일</th>
								    <th>조회수</th>
							    </tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}" begin="0" end="9">
							<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
							<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
							  <tr onClick = "location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}&writer=${item.writer}'">
							    <td id="rownum">${item.pRank}</td>
							    <td id="title">${item.title}</td>
							    <td id="cName">${item.cName}</td>
							    <td id="writer">${item.writer}</td>
							    <td id="bDate">${bDate}</td>
							    <td id="cnt">${item.cnt}</td>
							  </tr>
							</c:forEach>
							</tbody>
						</table>
				</section>
				<br>
				<div class="content">
					<span class="image object">
						<img src="images/table_deco.jpg" alt="" style="width:100%;" />
					</span>
				</div>
				<br><br>
				<!-- Section -->
				<section>
					<header class="major">
						<h2>실시간 인기글</h2>
					</header>
					<article>
						<table border="1">
							<thead>
							    <tr>
							    	<th>No.</th>
								    <th>제목</th>
								    <th>카테고리</th>
								  	<th>작성자</th>
								    <th>작성일</th>
								    <th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${pList}">
								<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
								<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
								<c:set value="${item.cNo}" var="cNo1"/>
								    <tr onClick = "location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}&writer=${item.writer}'">
									    <td id="pNo">${item.pRank}</td>
									    <td id="pTitle">${item.title}</td>
									    <td id="pcName">${item.cName}</td>
									    <td id="pWriter">${item.writer}</td>
									    <td id="pbDate">${bDate}</td>
									    <td id="pCnt">${item.cnt}</td>
								    </tr>
								</c:forEach>
							</tbody>
						</table>
					</article>
				</section>
				
				<!-- Section -->
				<section>
					<header class="major">
						<h2>Gallery</h2>
					</header>
					<div class="posts">
						<article>
							<a class="image"><img src="images/food1.jpg" alt="" /></a>
						</article>
						<article>
							<a class="image"><img src="images/food2.jpg" alt="" /></a>
						</article>
						<article>
							<a class="image"><img src="images/food3.jpg" alt="" /></a>
						</article>
						<article>
							<a class="image"><img src="images/food4.jpg" alt="" /></a>
						</article>
						<article>
							<a class="image"><img src="images/food5.jpg" alt="" /></a>
						</article>
						<article>
							<a class="image"><img src="images/food6.jpg" alt="" /></a>
						</article>
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