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
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/material.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<script>
$(function(){
	new_user_list();
	board_like_list();
	drawChart();	
});

// 차트 그리기
function drawChart() {
	
	// Themes begin
	am4core.useTheme(am4themes_material);
	am4core.useTheme(am4themes_animated);
	// Themes end

	// Create chart instance
	var chart = am4core.create("chartdiv", am4charts.XYChart);

	// Add data
	chart.data = [${cntChart}];
	console.log(${cntChart});
	
	// Set input format for the dates
	chart.dateFormatter.inputDateFormat = "yyyy-MM-dd";

	// Create axes
	var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
	var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

	// Create series
	var series = chart.series.push(new am4charts.LineSeries());
	series.dataFields.valueY = "value1";
	series.dataFields.dateX = "date";
	series.tooltipText = "[bold]게시글 :[/] {value1}"
	series.strokeWidth = 2;
	series.minBulletDistance = 15;
	
	// Create series
	var series2 = chart.series.push(new am4charts.LineSeries());
	series2.dataFields.valueY = "value2";
	series2.dataFields.dateX = "date";
	series2.tooltipText = "[bold]댓글 :[/] {value2}"
	series2.strokeWidth = 2;
	series2.minBulletDistance = 15;

	// Drop-shaped tooltips
	series.tooltip.background.cornerRadius = 20;
	series.tooltip.background.strokeOpacity = 0;
	series.tooltip.pointerOrientation = "vertical";
	series.tooltip.label.minWidth = 40;
	series.tooltip.label.minHeight = 40;
	series.tooltip.label.textAlign = "middle";
	series.tooltip.label.textValign = "middle";
	
	// Drop-shaped tooltips
	series2.tooltip.background.cornerRadius = 20;
	series2.tooltip.background.strokeOpacity = 0;
	series2.tooltip.pointerOrientation = "vertical";
	series2.tooltip.label.minWidth = 40;
	series2.tooltip.label.minHeight = 40;
	series2.tooltip.label.textAlign = "middle";
	series2.tooltip.label.textValign = "middle";

	// Make bullets grow on hover
	var bullet = series.bullets.push(new am4charts.CircleBullet());
	bullet.circle.strokeWidth = 2;
	bullet.circle.radius = 4;
	bullet.circle.fill = am4core.color("#fff");

	// Make bullets grow on hover
	var bullet2 = series2.bullets.push(new am4charts.CircleBullet());
	bullet2.circle.strokeWidth = 2;
	bullet2.circle.radius = 4;
	bullet2.circle.fill = am4core.color("#fff");
	
	var bullethover = bullet.states.create("hover");
	bullethover.properties.scale = 1.3;
	
	// Make a panning cursor
	chart.cursor = new am4charts.XYCursor();
	chart.cursor.behavior = "panXY";
	chart.cursor.xAxis = dateAxis;

	// Create vertical scrollbar and place it before the value axis
	chart.scrollbarY = new am4core.Scrollbar();
	chart.scrollbarY.parent = chart.leftAxesContainer;
	chart.scrollbarY.toBack();

	// Create a horizontal scrollbar with previe and place it underneath the date axis
	chart.scrollbarX = new am4charts.XYChartScrollbar();
	chart.scrollbarX.series.push(series);
	chart.scrollbarX.series.push(series2);
	chart.scrollbarX.parent = chart.bottomAxesContainer;
	
	dateAxis.start = 0.79;
	dateAxis.keepSelection = true;
}

//신규 가입자(최근 10명)
function new_user_list() {
	
	$.ajax({
		url : '/newUserList.do',
		type : 'GET',
		dataType : 'json',
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			var j=0;
			var today = moment().format('YYYY-MM-DD');
			var joinDate_format = moment(data[0].joinDate).format('YYYY-MM-DD');
			if(today == joinDate_format) {
				if(data.length < 10){
					for(var i=0;i<data.length;i++) {
						j=i+1;
						$("#new_user_tbody").append("<tr id='new_user_tr_"+i+"'></tr>");
						$("#new_user_tr_"+i).append("<td>"+j+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].userId+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].userName+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].email+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].tel+"</td>");
						$("#new_user_tr_"+i).append("<td>"+moment(data[i].joinDate).format('YYYY-MM-DD')+"</td>");
					}
				} else if(data.length >= 10){
					for(var i=0;i<10;i++) {
						j=i+1;
						$("#new_user_tbody").append("<tr id='new_user_tr_"+i+"'></tr>");
						$("#new_user_tr_"+i).append("<td>"+j+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].userId+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].userName+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].email+"</td>");
						$("#new_user_tr_"+i).append("<td>"+data[i].tel+"</td>");
						$("#new_user_tr_"+i).append("<td>"+moment(data[i].joinDate).format('YYYY-MM-DD')+"</td>");
					}
				}
			} else {
				$("#new_user").empty();
				$("#new_user").append("<div class='box'><p style='text-align: center;'>신규 가입자가 없습니다.</p></div>");
			}
			
		}
	});
}

function board_like_list() {
	$.ajax({
		url : '/boardLikeList.do',
		type : 'GET',
		dataType : 'json',
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			
			var uniqueList = [];
			var j = 0;
			
			// 중복제거
			for(var i=0;i<data.length-1;i++) {
				if(data[i].bNo != data[i+1].bNo) {
					uniqueList[0] = data[0];
					j++;
					uniqueList[j] = data[i+1];
				}
			}
			
			$.ajax({
				url : '/boardLikeCntList.do',
				type : 'GET',
				dataType : 'json',
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				error : function(xhr, status, msg) {
					console.log("ajax 실패");
					console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
				},
				success : function(data) {
					
					// 좋아요 많은 순서대로 정렬한 bNo List
					var sortList = [];
					for(var i=0;i<data.length;i++){
						for(var j=0;j<uniqueList.length;j++) {
							if(data[i].bNo == uniqueList[j].bNo) {
								sortList[i] = uniqueList[j];
							}
						}
					}
					
					
					if(data.length > 0){
						if(sortList.length < 5){
							for(var i=0;i<sortList.length;i++) {
								var url1 = "location.href=\"/boardSelectDetail.do?bNo="+sortList[i].bNo+"&sName="+sortList[i].sName+"&cNo="+sortList[i].cNo+"&writer="+sortList[i].writer+"\"";

								j=i+1;
								$("#like_top5_tbody").append("<tr id='like_top5_tr_"+i+"' onClick="+url1+"></tr>");
								$("#like_top5_tr_"+i).append("<td>"+j+"</td>");
								$("#like_top5_tr_"+i).append("<td>"+sortList[i].sName+"</td>");
								$("#like_top5_tr_"+i).append("<td id='title'>"+sortList[i].title+"</td>");
								$("#like_top5_tr_"+i).append("<td>"+sortList[i].writer+"</td>");
								$("#like_top5_tr_"+i).append("<td>"+moment(sortList[i].bDate).format('YYYY-MM-DD')+"</td>");
								$("#like_top5_tr_"+i).append("<td>"+sortList[i].cnt+"</td>");
							}
						} else if(sortList.length >= 5){
							for(var i=0;i<5;i++) {
								var url2 = "location.href=\"/boardSelectDetail.do?bNo="+sortList[i].bNo+"&sName="+sortList[i].sName+"&cNo="+sortList[i].cNo+"&writer="+sortList[i].writer+"\"";

								j=i+1;
								$("#like_top5_tbody").append("<tr id='like_top5_tr_"+i+"' onClick="+url2+"></tr>");
								$("#like_top5_tr_"+i).append("<td>"+j+"</td>");
								$("#like_top5_tr_"+i).append("<td>"+sortList[i].sName+"</td>");
								$("#like_top5_tr_"+i).append("<td id='title'>"+sortList[i].title+"</td>");
								$("#like_top5_tr_"+i).append("<td>"+sortList[i].writer+"</td>");
								$("#like_top5_tr_"+i).append("<td>"+moment(sortList[i].bDate).format('YYYY-MM-DD')+"</td>");
								$("#like_top5_tr_"+i).append("<td>"+sortList[i].cnt+"</td>");
							}
						}
					} else {
						$("#like_top5").empty();
						$("#like_top5").append("<div class='box'><p style='text-align: center;'>좋아요를 받은 게시글이 없습니다.</p></div>");
					}
				}
			});
		}
	});
}
</script>
<style type="text/css">
#title {
	text-align : left;
}
#chart-container {
	float: right;
	position: center;
	left: -50;
}
canvas {
    float: right;
    width: 40%;
    position: right;
    left: -30%;
}
#chartdiv {
  width: 100%;
  height: 500px;
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
					<!-- 새글/새댓글 통계 -->
					<section>
						<header class="major">
							<h2>게시글/댓글 등록 현황</h2>
						</header>
						<div class="box">
							<div id="chartdiv"></div>
						</div>
					</section>
	
					<!-- Section -->
					<section>
						<header class="major">
							<h2>신규 가입자(최근 10명)</h2>
						</header>
							<div id="new_user">
								<!-- 신규 가입자(최근 10명) -->
								<table border="1">
									<thead>
									  <tr>
									  	<th>NO.</th>
									  	<th>아이디</th>
									    <th>이름</th>
									    <th>이메일</th>
									    <th>전화번호</th>
									    <th>가입일</th>
									  </tr>
									</thead>
									<tbody id="new_user_tbody">
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
									  	<th>NO.</th>
									  	<th>카테고리</th>
									    <th>제목</th>
									    <th>작성자</th>
									    <th>작성일</th>
									    <th>조회수</th>
									  </tr>
									</thead>
									<tbody id="like_top5_tbody">
									</tbody>
								</table>
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