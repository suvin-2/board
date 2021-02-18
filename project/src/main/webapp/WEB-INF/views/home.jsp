<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					<jsp:include page="board/boardHead.jsp" flush="false"/>
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
								<h2>전체글</h2>
							</header>
								<!-- 카페 내 전체 글 -->
								<table border="1">
									<thead>
									  <tr>
									  	<th>순번</th>
									    <th>제목</th>
									    <th>카테고리</th>
									    <th>작성일</th>
									  </tr>
									</thead>
									<tbody>
									<c:forEach var="item" items="${list}" begin="0" end="9">
									<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
									<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
									  <tr onClick = "location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}'">
									    <td id="bNo">${item.bNo}</td>
									    <td id="title">${item.title}</td>
									    <td id="cName">${item.cName}</td>
									    <td id="bDate">${bDate}</td>
									  </tr>
									</c:forEach>
									</tbody>
								</table>
						</section>
	
					<!-- Section -->
						<section>
							<header class="major">
								<h2>인기 카테고리</h2>
							</header>
							<div class="posts">
								<article>
									<h3>한식</h3>
									<table border="1">
											<thead>
											  <tr>
											    <th>제목</th>
											    <th>작성일</th>
											  </tr>
											</thead>
											<tbody>
											<c:forEach var="item" items="${list}">
											<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
											<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
											<c:if test="${item.sName eq '한식'}">
											<c:set value="${item.cNo}" var="cNo1"/>
											  <tr onClick = "location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}'">
											    <td id="title">${item.title}</td>
											    <td id="bDate">${bDate}</td>
											    <td><input type="hidden" id="cName1" value="${item.cName}"/></td>
											    <td><input type="hidden" id="sName1" value="${item.sName}"/></td>
											  </tr> 
											</c:if>
											</c:forEach>
											</tbody>
										</table>
										<ul class="actions">
											<li><button class="button" onclick="category1()">More</button></li>
										</ul>
								</article>
								<article>
									<h3>중식</h3>
									<table border="1">
											<thead>
											  <tr>
											    <th>제목</th>
											    <th>작성일</th>
											  </tr>
											</thead>
											<tbody>
											<c:forEach var="item" items="${list}">
											<!-- 날짜 포맷 변환 (taglib 추가해야함) -->
											<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
											<c:if test="${item.sName eq '중식'}">
											<c:set value="${item.cNo}" var="cNo2"/>
											  <tr onClick = "location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}'">
											    <td id="title">${item.title}</td>
											    <td id="bDate">${bDate}</td>
											    <td><input type="hidden" id="cName2" value="${item.cName}"/></td>
											    <td><input type="hidden" id="sName2" value="${item.sName}"/></td>
											  </tr>
											</c:if>
											</c:forEach>
											</tbody>
										</table>
										<ul class="actions">
											<li><button class="button" onclick="category2()">More</button></li>
										</ul>
								</article>
								<article>
									<h3 id="title3"><a name="Title3" id="Title3">빵</a></h3>
									<table border="1">
											<thead>
											  <tr>
											    <th>제목</th>
											    <th>작성일</th>
											  </tr>
											</thead>
											<tbody>
											<c:forEach var="item" items="${list}">
											<!-- 날짜 포맷 변환 (taglib 추가해야함) --> 
											<fmt:formatDate var="bDate" value="${item.bDate}" pattern="yyyy-MM-dd HH:MM"/>
											<c:if test="${item.sName eq '빵'}">
											<c:set value="${item.cNo}" var="cNo3"/>
											<c:set var="listCopy" value="${list}"/>
											  <tr onClick = "location.href='${path}/boardSelectDetail.do?bNo=${item.bNo}&sName=${item.sName}'">
											    <td id="title">${item.title}</td>
											    <td id="bDate">${bDate}</td>
											    <td><input type="hidden" id="cName3" value="${item.cName}"/></td>
											    <td><input type="hidden" id="sName3" value="${item.sName}"/></td>
											  </tr>
											</c:if>
											</c:forEach>
											</tbody>
										</table>
										<ul class="actions">
											<li><button class="button" onclick="category3()">More</button></li>
										</ul>
								</article>
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
	
	var cName2 = $("#cName2").val();
	var sName2 = $("#sName2").val();
	
	var cName3 = $("#cName3").val();
	var sName3 = $("#sName3").val();
	
	function category1(){
		location.href = "${path}/boardList.do?cName="+cName1+"&sName="+sName1+"&cNo="+${cNo1};
	}
	
	function category2(){
		location.href = "${path}/boardList.do?cName="+cName2+"&sName="+sName2+"&cNo="+${cNo2};
	}
	
	function category3(){
		console.log("cno3 : " + ${cNo3})
		location.href = "${path}/boardList.do?cName="+cName3+"&sName="+sName3+"&cNo="+${cNo3};
	}
</script>
<script src="js/jquery.min.js"></script>
<script src="js/browser.min.js"></script>
<script src="js/breakpoints.min.js"></script>
<script src="js/util.js"></script>
<script src="js/main.js"></script>
</body>
</html>