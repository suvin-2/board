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
<script>
$(function(){
	category_select();
});

//카테고리 조회
function category_select(){
	
	// 카테고리 조회(category controller)
	$.ajax({
		url : '/categoryList.do',
		type : 'GET',
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			console.log(data);
			
			var unique_cName = [];
			var j=0;
			var k=1;
			// cName 중복제거
			for(var i=0;i<data.length-1;i++){
				if(data[i].cName != data[i+1].cName){
					unique_cName[0] = data[0].cName;
					j++;
					unique_cName[j] = data[i+1].cName;
				}
			}
			
			// 카테고리 category_tbody에 append
			for(var i=0;i<unique_cName.length;i++){
				$("#update_before_tbody").append("<tr><td style='font-weight:bold;' id='before_cName"+i+"'>"+unique_cName[i]+"</td></tr>");
				for(var j=0;j<data.length;j++){
					if(unique_cName[i] == data[j].cName) {
						$("#update_before_tbody").append("<tr><td id='"+k+"' onClick=\"category_update_form('"+data[j].cName+"',"+k+")\">"+data[j].sName+"</td></tr>");
						k++;
					}
				}
			}
			
			$("#category_update_div").hide();
			$("#category_add_div").hide();
			
		}
	});
}
// 카테고리 수정/삭제 폼 (k는 cno이긴한데 sName은 못알아내고 cName은 알아낼 수 있음)
function category_update_form(cName, k){
	
	$("#category_update_div").show();
	$("#category_add_div").hide();
	
	console.log('cName : '+cName+', k : '+k);
	
	// 카테고리 다시 조회(category controller)
	$.ajax({
		url : '/categoryList.do',
		type : 'GET',
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			
			var table_html = "";
			var div_html = "";
			var UD_cnt = 1;
			
			table_html += "<tr>";
			table_html += "<th>대분류</th>";
			table_html += "<td><input type='text' id='UD_cName' value='"+cName+"'></td>";
			table_html += "<td><input type='button' value='삭제' class='button primary' onclick=\"category_delete('"+cName+"','대분류',"+k+")\"></td>";
			table_html += "</tr>";
			for(var i=0;i<data.length;i++){
				if(cName == data[i].cName){
					
					console.log(data[i].sName);
					table_html += "<tr class='update_sName_value'>";
					table_html += "<th>소분류</th>";
					table_html += "<td><input type='text' id='UD_sName"+UD_cnt+"' value='"+data[i].sName+"'></td>";
					table_html += "<td><input type='button' value='삭제' class='button primary' onclick=\"category_delete('"+cName+"','"+data[i].sName+"',"+UD_cnt+")\"></td>";
					table_html += "</tr>";
					UD_cnt++;
				}
			}
			
			div_html += "<input type='button' class='button primary' value='소분류 추가' onclick='update_sName_add()'>&nbsp;";
			div_html += "<input type='button' class='button' value='수정' onclick='category_update()'>";
			
			$("#category_update_tbody").empty();
			$("#category_update_tbody").append(table_html);
			$("#category_update_btn").empty();
			$("#category_update_btn").append(div_html);
			
		}
	});
}

//카테고리 sName 추가
function update_sName_add(){
	
	var tr_html = "";
	var cnt = $(".update_sName_value").length+1;
	
	
	tr_html += "<tr class='update_sName_value'>"
	tr_html += "<th>소분류</th>";
	tr_html += "<td><input type='text' id='UD_sName"+cnt+"'></td>";
	tr_html += "<td><img src='/images/minus.png' onclick='update_sName_minus()'></td>";
	tr_html += "</tr>";
	$("#category_update_tbody").append(tr_html);
	
}

//카테고리 sName 삭제
function update_sName_minus(){
	$("#category_update_table > tbody:last > tr:last").remove();
}

// 카테고리 수정 (cName, sName 위치)
function category_update(UD_cnt){
	
	var cName = $("#UD_cName").val();
	var sName = [];
	for(var i=1;i<UD_cnt;i++){
		sName[i] = $("#UD_sName"+i).val();
	}
	
	if(cName == "") {
		alert('카테고리 대분류를 입력해주세요.');
		$("#UD_cName").focus();
		return false;
	}
	for(var i=1;i<UD_cnt;i++){
		if(sName[i] == "") {
			alert('카테고리 소분류를 입력해주세요.');
			$("#UD_sName"+i).focus();
			return false;
		}
	}
	
}

//카테고리 삭제
function category_delete(cName, sName, cnt){
	// cName 클릭 시 confirm로 대분류 삭제 시 대분류에 포함된 소분류 전체 삭제 된다고 알리기
	// sName 삭제 시 sName 개수 1개 이하로 남으면 소분류는 더이상 삭제 불가라고 alert로 알리기

	if(sName == '대분류') {
		if(confirm('대분류 삭제 시, 대분류에 포함된 모든 소분류도 함께 삭제됩니다. 선택한 '+cName+'을(를) 삭제하시겠습니까?') == true){
			
			$.ajax({
				url : '/cNameDelete.do',
				type : 'GET',
				data : {"cName":cName},
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				error : function(xhr, status, msg) {
					console.log("ajax 실패");
					console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
				},
				success : function(data) {
					alert(cName+'이(가) 삭제되었습니다.');
					location.href = location.href;
				}
			});
			
		} else {
			alert(cName+'이(가) 삭제되지 않았습니다.');
		}
	} else {
		if(confirm('선택한 '+sName+'을(를) 삭제하시겠습니까?') == true){
			
			$.ajax({
				url : '/cNameDuplicationSelect.do',
				type : 'GET',
				data : {"cName":cName},
				contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
				error : function(xhr, status, msg) {
					console.log("ajax 실패");
					console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
				},
				success : function(data) {
					if(data.length < 2) {
						alert('소분류가 1개 이상은 존재해야합니다.');
					} else {
						$.ajax({
							url : '/sNameDelete.do',
							type : 'GET',
							data : {"cName":cName,"sName":sName},
							contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
							error : function(xhr, status, msg) {
								console.log("ajax 실패");
								console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
							},
							success : function(data) {
								alert(sName+'이(가) 삭제되었습니다.');
								location.href = location.href;
							}
						});
					}
				}
			});
					
		} else {
			alert(sName+'이(가) 삭제되지 않았습니다.');
		}
	}
	console.log('cName value : '+cName+', sName : '+sName);
}

// 카테고리 추가 등록까지 완료 ------------------------------------------------------------------
// 카테고리 추가 폼
function category_add_form(){
	
	$("#category_update_div").hide();
	$("#category_add_div").show();
}

// 카테고리 sName 추가
var cnt = 0;
function add_sName_add(){
	
	var tr_html = "";
	var div_html = "";
	cnt++;
	
	tr_html += "<tr id='sName_add_tr_"+cnt+"' class='add_sName_value'>"
	tr_html += "<th>소분류</th>";
	tr_html += "<td><input type='text' id='add_sName"+cnt+"'></td>";
	tr_html += "<td><img src='/images/minus.png' onclick='add_sName_minus()'></td>";
	tr_html += "</tr>";
	$("#category_add_tbody").append(tr_html);
}

// 카테고리 sName 삭제
function add_sName_minus(){
	$("#category_add_table > tbody:last > tr:last").remove();
}

//카테고리 추가
function category_add(){
	console.log('빈칸체크, 카테고리 대분류 중복체크 해야함');
	
	var cName = $("#add_cName").val();
	// 추가한 소분류 개수
	var add_sName_cnt = $(".add_sName_value").length;
	
	// 카테고리 빈칸 체크 ---
	if($("#add_cName").val() == ""){
		alert('카테고리 대분류를 입력하세요.');
		$("#add_cName").focus();
		return false;
	}
	if($("#add_sName0").val() == ""){
		alert('카테고리 소분류를 입력하세요.');
		$("#add_sName0").focus();
		return false;
	}
	
	if(add_sName_cnt > 0){
		for(var i=1;i<=add_sName_cnt;i++) {
			if($("#add_sName"+i).val() == ""){
				alert('카테고리 소분류를 입력하세요.');
				$("#add_sName"+i).focus();
				return false;
			}
		}
	}
	
	// cName 중복 확인
	$.ajax({
		url : '/cNameDuplicationSelect.do',
		type : 'GET',
		data : {"cName":cName},
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
		error : function(xhr, status, msg) {
			console.log("ajax 실패");
			console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
		},
		success : function(data) {
			var insert_data = [];
			if(data.length > 0){
				alert('이미 등록된 대분류입니다. 새로운 값을 입력하세요.');
				$("#add_cName").focus();
			} else {
				if(add_sName_cnt > 0){
					for(var i=0;i<=add_sName_cnt;i++) {
						insert_data.push({"cName":cName, "sName":$("#add_sName"+i).val()});
					}
				} else {
					insert_data.push({"cName":cName, "sName":$("#add_sName0").val()});
				}
				
				console.log(insert_data);
				//var insert_data_json = JSON.stringify(insert_data);
				//console.log(insert_data_json);
				
				// spring security 때문에 csrf 토큰 꼭 hidden으로 보내줘야 post로 전송 가능
				var token = $("input[name='_csrf']").val();
				var header = "X-CSRF-TOKEN";
				// category insert 하기
				$.ajax({
					url : '/newCategoryInsert',
					type : 'POST',
					dataType : 'json',
					data : JSON.stringify(insert_data),
					contentType : 'application/json',
					beforeSend : function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					error : function(xhr, status, msg) {
						console.log("ajax 실패");
						console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
					},
					success : function(data) {
						alert('카테고리 등록이 완료되었습니다.');
						location.href = location.href;
					}
				});
				
			}
		}
	});
	
}
</script>
<style type="text/css">
#title {
	text-align : left;
}
#update_before_div {
	display : inline-block;
	width : 48%;
}
#update_after_div {
	float : right;
	display : inline-block;
	width : 48%;
}
#add_category_btn{
	text-align : center;
}
#add_sName_btn{
	text-align : center;
}
#category_update_btn{
	text-align : center;
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
					<!-- 카테고리 수정/삭제 -->
					<section>
						<header class="major">
							<h2>카테고리 관리</h2>
						</header>
						<div class="box">
						<p style="color:darkgray;">※ 수정/삭제 시 해당 카테고리(소분류)를 클릭해주세요.</p>
							<div id="update_before_div">
								<!-- <p style="text-align:center;">카테고리</p> -->
								<table>
									<thead>
										<tr>
											<th>카테고리</th>
										</tr>
									</thead>
									<tbody id="update_before_tbody"></tbody>
								</table>
								<div id="add_category_btn">
									<input type="button" class="button" value="추가하기" onclick="category_add_form()">
								</div>
							</div>
							
							<div id="update_after_div">
								<div id="category_update_div">
									<table id="category_update_table">
										<thead>
											<tr><th colspan="3">카테고리 수정/삭제</th></tr>
										</thead>
										<tbody id="category_update_tbody">
										</tbody>
									</table>
									<div id="category_update_btn">
									<!-- 
										<input type="button" class="button primary" value="소분류 추가" onclick="update_sName_add()">
										<input type="button" class="button" value="수정" onclick="category_update()">
										 -->
									</div>
								</div>
								<div id="category_add_div">
									<table id="category_add_table">
										<thead>
											<tr><th colspan="3">카테고리 추가</th></tr>
										</thead>
										<tbody id="category_add_tbody">
											<tr>
												<th>대분류</th>
												<td colspan="2"><input type="text" id="add_cName"></td>
											</tr>
											<tr>
												<th>소분류</th>
												<td colspan="2"><input type="text" id="add_sName0"></td>
											</tr>
										</tbody>
									</table>
									<div id="add_sName_btn">
										<input type="button" class="button" value="소분류 추가" onclick="add_sName_add()">
										<input type="button" class="button primary" value="카테고리 등록" onclick="category_add()">
									</div>
								</div>
							</div>
							
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