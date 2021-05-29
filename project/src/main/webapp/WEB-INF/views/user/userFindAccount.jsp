<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>suvin's cooking class</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="css/main.css" />
<script type="text/javascript">
$(function(){
	
	var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var id_find_check = "N";
	var pw_find_check = "N";
	
	$("#id_find_btn").click(function(){
		
		if($("#userName").val().length==0) { 
			alert("이름을 입력하세요."); 
			$("#userName").focus(); 
			return false; 
		}
		if($("#id_email").val().length==0) { 
			alert("이메일을 입력하세요."); 
			$("#id_email").focus(); 
			return false; 
		} else if(!emailPattern.test($("#id_email").val())) {
	    	alert("이메일 형식을 확인해주세요.");
	    	$("#id_email").focus(); 
			return false;
	    }
		
		$.ajax({
			url : 'userSelect',
			type : 'GET',
			error : function(xhr, status, msg) {
				console.log("ajax 실패");
				console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
			},
			success : function(data) {
				
				var userId;
				var userName;
				var email;
				
				console.log(data);
				for(var i=0;i<data.length;i++){
					
					if($("#id_email").val() == data[i].email && $("#userName").val() == data[i].userName) {
						id_find_check = "Y";
						email = data[i].email;
						userName = data[i].userName;
						userId = data[i].userId;
					}
				}
				console.log(userName+', '+email+', '+userId);

				if(id_find_check == "N") {
					alert("이름과 이메일을 다시 확인해주세요");
				} else {
					$("#modal_content").text("회원님의 아이디는 "+userId+"입니다.");
					$("#myModal").show();
				}
				
			}
		});
	});
	
	$("#pw_find_btn").click(function(){
		
		if($("#userId").val().length==0) { 
			alert("아이디를 입력하세요."); 
			$("#userId").focus(); 
			return false; 
		}
		if($("#pw_email").val().length==0) { 
			alert("이메일을 입력하세요."); 
			$("#pw_email").focus(); 
			return false; 
		} else if(!emailPattern.test($("#pw_email").val())) {
	    	alert("이메일 형식을 확인해주세요.");
	    	$("#pw_email").focus(); 
			return false;
	    }
		
		$.ajax({
			url : 'userSelect',
			type : 'GET',
			error : function(xhr, status, msg) {
				console.log("ajax 실패");
				console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
			},
			success : function(data) {
				
				var userId;
				var email;
				
				console.log(data);
				for(var i=0;i<data.length;i++){
					
					if($("#userId").val() == data[i].userId && $("#pw_email").val() == data[i].email) {
						pw_find_check = "Y";
						email = data[i].email;
						userName = data[i].userName;
						userId = data[i].userId;
					}
				}
				console.log(userName+', '+email+', '+userId);

				if(pw_find_check == "N") {
					alert("아이디와 이메일을 다시 확인해주세요");
				} else {
					
					// spring security 때문에 csrf 토큰 꼭 hidden으로 보내줘야 post로 전송 가능
					var token = $("input[name='_csrf']").val();
					var header = "X-CSRF-TOKEN";
					
					$.ajax({
						url : 'userTempPw.do',
						type : 'POST',
						data : {'email':email, 'userId':userId},
						beforeSend : function(xhr) {
							xhr.setRequestHeader(header, token);
						},
						error : function(xhr, status, msg) {
							console.log("ajax 실패");
							console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
						},
						success : function(data) {
							console.log(data);
							alert('회원님의 메일로 임시 비밀번호가 전송되었습니다.');
						}
					});
				}
				
			}
		});
	});
});

function close_pop(flag) {
    $('#myModal').hide();
};
</script>
<style>
#userAccount_div {
	margin : 0 5% 0 5%;
}
#id_find_div {
	width : 45%;
	height : auto; 
	min-height : 100px; 
	overflow : auto;
	float : left;
}
#pw_find_div {
	width : 45%;
	height : auto; 
	min-height : 100px; 
	overflow : auto;
	float : right;
}
/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
    background-color: #fefefe;
    margin: 15% auto; /* 15% from the top and centered */
    padding: 20px;
    border: 1px solid #888;
    width: 30%; /* Could be more or less, depending on screen size */                          
}
h3 {
	text-align : center;
}
#click_btn {
	text-align : center;
}
</style>
</head>
<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Main -->
		<div id="main">
			<div class="inner">	
				<!-- Header -->
				<%@ include file="/WEB-INF/views/board/boardHead.jsp"%>
				<!-- Section -->
				<section>
					<header class="major">
						<br><h2>아이디/비밀번호 찾기</h2>
					</header>
					<div id="userAccount_div">
						<div id="id_find_div" class="box">
							<h3>아이디 찾기</h3><br>
					        <div class="form-group">
					            <label >이름</label>
					            <input type="text" class="form-control" name="userName" id="userName" placeholder="name" />
					        </div>
					        <br>
					        <div class="form-group">
					            <label>이메일</label>
					            <input type="text" class="form-control" name="id_email" id="id_email" placeholder="email" />
					        </div>
					        <br>
					        <div id="click_btn">
								<button id="id_find_btn" class="button">ID찾기</button>
					        </div>
						</div>
						<div id="pw_find_div" class="box">
							<h3>비밀번호 찾기</h3><br>
					        <div class="form-group">
					            <label >아이디</label>
					            <input type="text" class="form-control" name="userId" id="userId" placeholder="id" />
					        </div>
					        <br>
					        <div class="form-group">
					            <label>이메일</label>
					            <input type="text" class="form-control" name="pw_email" id="pw_email" placeholder="email" />
					        </div>
					        <br>
					        <div id="click_btn">
								<button id="pw_find_btn" class="button">PW찾기</button>
					        </div>
						</div>
					</div>
				</section>
				 <!-- The Modal -->
			    <div id="myModal" class="modal">
				     <!-- Modal content -->
				     <div class="modal-content">
				               <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">아이디 찾기</span></b></span></p>
				               <p style="text-align: center; line-height: 1.5;" id="modal_content"><br /></p>
				               <p><br /></p>
				           <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
				               <span class="pop_bt" style="font-size: 13pt;" >
				                    닫기
				               </span>
				           </div>
				     </div>
			     </div>
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