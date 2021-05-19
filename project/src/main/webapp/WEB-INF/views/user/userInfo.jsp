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
<script type="text/javascript">
$(function(){
	
	var userId = "<%= request.getParameter("userId") %>";
	console.log('ID : '+userId);
	
	var userId_jsp = document.querySelector("#userId");
	var userPw1 = document.querySelector('#userPw1');
	var pwMsg = document.querySelector('#alertTxt');
	var userPw2 = document.querySelector('#userPw2');
	var pwMsgArea = document.querySelector('.int_pass');
	var userName = document.querySelector('#userName');
	var gender = document.querySelector('#gender');
	var email_jsp = document.querySelector('#email');
	var tel_jsp = document.querySelector('#tel');
	
	var birthday;
	var yyyy = document.querySelector("#yyyy");
	var mm = document.querySelector("#mm");
	var dd = document.querySelector("#dd");
	
    var pwPattern = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
    var namePattern = /^[가-힣a-zA-Z]+$/;

	var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var isPhoneNum = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
	
	var emailCheck = "N";
	var telCheck = "N";
	
	var email_check = document.querySelector("#email_check");
	var tel_check = document.querySelector("#tel_check");
	
	userInfo();

	$("#submit").click(function(){
		
		// pw 유효성 체크
	    if(userPw1.value == "") {
	    	alert("비밀번호를 입력하세요.");
	    	$("#userPw1").focus(); 
			return false;
	    }
	    
	    if(!pwPattern.test(userPw1.value)) {
	    	alert("비밀번호는 8~20자 영문 소문자(대문자), 숫자, 특수문자를 사용하세요.");
	    	$("#userPw1").focus(); 
			return false;
	    }
	
	    if(userPw2.value != userPw1.value) {
	    	alert("비밀번호가 일치하지 않습니다.");
	    	$("#userPw2").focus(); 
			return false;
	    }
	    
	    if(userPw2.value == "") {
	    	alert("비밀번호 재확인을하세요.");
	    	$("#userPw2").focus(); 
			return false;
	    }
	    
	    if(telCheck == "N") {
			alert("전화번호 중복확인을 해주세요.");
	    	$("#tel").focus(); 
			return false;
		}
		
	    // 이름 유효성 체크
	    if(userName.value == "") {
	    	alert("이름을 입력하세요.");
	    	$("#userName").focus(); 
			return false;
	    }
	    
	    if(!namePattern.test(userName.value) || userName.value.indexOf(" ") > -1) {
	    	alert("이름은 한글 또는 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)");
	    	$("#userName").focus(); 
			return false;
	    }

	});
	
	function userInfo() {
		$.ajax({
			url : 'userInfoSelect/'+userId, 
			type : 'GET',
			dataType : 'json',
			contentType : 'application/json; charset=UTF-8',
			error : function(xhr, status, msg) {
				console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
			},
			success : function(data) {
				console.log(data);
				userId_jsp.value = data.userId;
				userName.value = data.userName;
				birthday = data.birthday;
				yyyy.value = birthday.substr(0,4);
				mm.value = birthday.substr(5,2);
				dd.value = birthday.substr(8,2);
				if(data.gender == "F") {
					gender.value = "여자";
				} else if(data.gender =="M") {
					gender.value ="남자";
				}
				email_jsp.value = data.email;
				tel_jsp.value = data.tel;
				// 중복체크하기위해
				email_check.value = data.email;
				tel_check.value = data.tel;
			}
		});
	}
	
	// 휴대폰 번호 input 태그에 자동으로 하이픈(-) 넣기
	$('#tel').keydown(function(event) {
	    var key = event.charCode || event.keyCode || 0;
	    $text = $(this); 
	    if (key !== 8 && key !== 9) {
	        if ($text.val().length === 3) {
	            $text.val($text.val() + '-');
	        }
	        if ($text.val().length === 8) {
	            $text.val($text.val() + '-');
	        }
	    }
	 
	    return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));           
	});

	// 이메일 체크
	$("#userEmailCheck").click(function() {
		
	    // 이메일 유휴성 체크
	    if(email_jsp.value === ""){ 
	    	alert("이메일을 입력하세요.");
	    	$("#email").focus(); 
	    	emailCheck = "N";
			return false;
	    } else if(!emailPattern.test(email_jsp.value)) {
	    	alert("이메일 형식을 확인해주세요.");
	    	$("#email").focus(); 
	    	emailCheck = "N";
			return false;
	    } else {
	    	var email = email_jsp.value;
	    	console.log('입력한 이메일 : '+email);
	    	
	    	if(email == email_check.value) {
	    		alert('이메일을 변경하지 않았습니다.');
	    		emailCheck = "Y";
	    		document.getElementById('email').readOnly = true;
	    	} else {

	    		$.ajax({
					url : '/userEmailCheck',
					type : 'get',
					data : {"email":email},
					dataType : 'json',
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
					error : function(xhr, status, msg) {
						console.log("ajax 실패");
						console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
					},
					success : function(data) {
						if(email === data.email) {
							alert("이미 등록된 이메일입니다. 다른 이메일을 입력하세요.");
							emailCheck = "N";
							$("#userId").focus(); 
							
						} else if(email != data.email) {
							alert("사용 가능한 이메일입니다.");
							emailCheck = "Y";
							console.log('중복확인 후 emailCheck : ' + emailCheck);
							document.getElementById('email').readOnly = true;
						}
					}
				});
	    		
	    	}
	    	
	    }
	});
	
	// 전화번호 중복 체크
	$("#userTelCheck").click(function() {
		
		// 전화번호 유호성 체크
	    if(tel_jsp.value === "") {
	    	alert("휴대폰 번호를 입력하세요.");
	    	$("#tel").focus(); 
	    	telCheck = "N";
			return false;
	    } else if(!isPhoneNum.test(tel_jsp.value)) {
	        alert("형식에 맞지 않는 번호입니다.");
	    	$("#tel").focus(); 
	    	telCheck = "N";
			return false;
	    } else if($("#tel").val().length != 0) {
	    	var tel = tel_jsp.value;
			console.log('입력한 Tel : ' + tel);
			
			if(tel == tel_check.value) {
	    		alert('전화번호를 변경하지 않았습니다.');
	    		telCheck = "Y";
	    		document.getElementById('tel').readOnly = true;
	    	} else {
				$.ajax({
					url : 'userTelCheck/'+tel,
					type : 'GET',
					error : function(xhr, status, msg) {
						console.log("ajax 실패");
						console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
					},
					success : function(data) {
						if(tel == data.tel) {
							telCheck = "N";
							alert("이미 등록된 전화번호입니다.");
							$("#tel").focus(); 
							
						} else if(tel != data.tel) {
							telCheck = "Y";
							alert("사용 가능한 전화번호입니다.");
							document.getElementById('tel').readOnly = true;
						}
					}
				});
	    	}
		}
	});
});

</script>
<style>
#content {
    position: absolute;
    left: 50%;
    transform: translate(-50%);
    width: 460px;
}

input {
    margin : 0 0 15px;
}

#id_wrap {
    display: table;
    width: 100%;
}

#id_input {
    display: table-cell;
    width: 380px;
}

#id_btn {
    display: table-cell;
    width: 150px;
    padding-left: 50px;
}

#bir_wrap {
    display: table;
    width: 100%;
}

#bir_yy {
    display: table-cell;
    width: 147px;
}

#bir_mm {
    display: table-cell;
    width: 147px;
    vertical-align: middle;
}

#bir_dd {
    display: table-cell;
    width: 147px;
}

#bir_mm, #bir_dd {
    padding-left: 10px;
}

select {
    width: 100%;
    height: 29px;
    font-size: 15px;
    background: #fff url(https://static.nid.naver.com/images/join/pc/sel_arr_2x.gif) 100% 50% no-repeat;
    background-size: 20px 8px;
    -webkit-appearance: none;
    display: inline-block;
    text-align: start;
    border: none;
    cursor: default;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
    margin : 0 0 15px;
}

#alertTxt {
    position: absolute;
    top: 19px;
    right: 38px;
    font-size: 12px;
    color: red;
    display: none;
}
</style>
</head>
<body class="is-preload" onload="document.userInfoForm.userId.focus();">
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
								<br><h2>내 정보 수정</h2>
							</header>
							<!-- content-->
				            <div id="content">
								<form name="userInfoForm" action="/userInfo.do" method="post">
									<input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/>
									<input type="hidden" id="birthday" name="birthday">
									<input type="hidden" id="email_check">
									<input type="hidden" id="tel_check">
					                <!-- ID -->
					                <div>
				                        <h4>아이디</h4>
				                        <div>
				                        	<input type="text" id="userId" name="userId" class="int" maxlength="20" readonly>
				                        </div>
					                </div>
					                <!-- PW1 -->
					                <div>
					                    <h4>비밀번호</h4>
					                    <div>
					                    	<input type="password" id="userPw1" name="userPw" class="int" maxlength="20" placeholder="비밀번호 입력">
					                    </div>
					                </div>
					                <!-- PW2 -->
					                <div>
					                    <h4>비밀번호 재확인</h4>
					                    <input type="password" id="userPw2" class="int" maxlength="20" placeholder="비밀번호 재입력">
					                </div>
					                <!-- NAME -->
					                <div>
					                    <h4>이름</h4>
					                    <input type="text" id="userName" name="userName" class="int" maxlength="20" placeholder="이름 입력">
					                </div>
					                <!-- BIRTH -->
					                <div>
					                    <h4>생년월일</h4>
					                    <div id="bir_wrap">
					                        <!-- BIRTH_YY -->
					                        <div id="bir_yy">
					                        	<input type="text" id="yyyy" name="yyyy" class="int" maxlength="4" placeholder="년(4자)" readonly>
					                        </div>
					                        <!-- BIRTH_MM -->
					                        <div id="bir_mm">
				                                <input type="text" id="mm" name="mm" class="int" maxlength="2" placeholder="월" readonly>
					                        </div>
					                        <!-- BIRTH_DD -->
					                        <div id="bir_dd">
				                                <input type="text" id="dd" name="dd" class="int" maxlength="2" placeholder="일" readonly>
					                        </div>					
					                    </div>
					                </div>
					                <!-- GENDER -->
					                <div>
					                    <h4>성별</h4>
					                    <input type="text" id="gender" name="gender" class="int" maxlength="2" placeholder="성별" readonly>
					                </div>
					                <!-- EMAIL -->
					                <div>
					                    <h4>이메일</h4>
					                    <div id="id_wrap">
					                        <div id="id_input">
					                        	<input type="text" id="email" name="email" class="int" maxlength="100" placeholder="이메일 입력">
					                        </div>
					                        <div id="id_btn">
					                        	<input type="button" id="userEmailCheck" class="button" value="중복확인"/>
					                        </div>
				                        </div>
					                </div>
					                <!-- MOBILE -->
					                <div>
					                    <h4>휴대폰 번호</h4>
					                    <div id="id_wrap">
					                        <div id="id_input">
					                        	<input type="text" id="tel" name="tel" class="int" maxlength="16" placeholder="전화번호 입력">
					                        </div>
					                        <div id="id_btn">
					                        	<input type="button" id="userTelCheck" class="button" value="중복확인"/>
					                        </div>
				                        </div>
					                </div>
					                <!-- JOIN BTN-->
					                <center>
					                	<input type="submit" id="submit" class="button" value="수정하기"/>
					                	<input type="button" id="back" onclick="history.back()" value="돌아가기"/>
					                </center>
					        	</form>
				            </div> 
				            <!-- content-->
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