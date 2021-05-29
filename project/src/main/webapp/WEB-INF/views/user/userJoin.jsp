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
	
	var idPattern = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
    var pwPattern = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
    var namePattern = /^[가-힣a-zA-Z]+$/;
    var yearPattern = /^[0-9_]{4}$/;
	var datePattern = /^[0-9_]{2}$/;
	var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var isPhoneNum = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
	
	var idCheck = "N";
	var emailCheck = "N";
	var telCheck = "N";
	
	var auth_code;
	
	$("#submit").click(function(){
				
		birthday = yyyy.value+mm.value+dd.value;
		document.getElementById("birthday").value = birthday;
		
		if(idCheck == "N") {
			alert("아이디 중복확인을 해주세요.");
	    	$("#userId").focus(); 
			return false;
		}
		
		if(telCheck == "N") {
			alert("전화번호 중복확인을 해주세요.");
	    	$("#tel").focus(); 
			return false;
		}
		
		if(emailCheck == "N") {
			alert("이메일 인증을 해주세요.");
	    	$("#email").focus(); 
			return false;
		}
		
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

	    // 성별 유효성 체크
	    if(gender.value == "성별") {
        	alert("성별을 선택하세요.");
	    	$("#gender").focus(); 
			return false;
        }
	    
		// 생년월일 유효성 체크
	    if(yyyy.value == "") {
	        alert("태어난 년도 4자리를 입력하세요.");
	    	$("#yyyy").focus(); 
			return false;
	    }

        if(mm.value == "월") {
        	alert("태어난 월을 선택하세요.");
	    	$("#mm").focus(); 
			return false;
        }
        
        if(dd.value == "") {
            alert("태어난 일(날짜) 2자리를 정확하게 입력하세요.");
	    	$("#dd").focus(); 
			return false;
        }

	    if(!datePattern.test(dd.value)) {
	        alert("태어난 일(날짜) 2자리로 입력해주세요.(ex)07)");
	    	$("#dd").focus(); 
			return false;
	    }
		
		if(Number(dd.value)<1 || Number(dd.value)>31) {
		    alert("태어난 일(날짜) 2자리를 다시 확인해주세요.");
			$("#dd").focus(); 
			return false;
		}
		
	    if(Number(yyyy.value) < 1920) {
	        alert("태어난 년도를 다시 확인해주세요.");
	    	$("#yyyy").focus(); 
			return false;
	    }
	    
	    if(Number(yyyy.value) > 2022) {
	        alert("태어난 년도를 다시 확인해주세요.");
	    	$("#yyyy").focus(); 
			return false;
	    }

	});
	
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
	
	// 아이디 중복 체크
	$("#userIdCheck").click(function() {
		
		if($("#userId").val().length == 0) { 
			alert("ID를 입력하세요.");
			$("#userId").focus(); 
			idCheck = "N";
			return false; 
		} else if(!idPattern.test($("#userId").val())) {
			alert("아이디는 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다."); 
			$("#userId").focus(); 
			idCheck = "N";
			return false;
	    } else if($("#userId").val().length != 0) {
	    	var userId = userId_jsp.value;
			
			$.ajax({
				url : '${pageContext.request.contextPath}/userIdCheck/'+userId,
				type : 'GET',
				error : function(xhr, status, msg) {
					console.log("ajax 실패");
					console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
				},
				success : function(data) {
					if(userId == data.userId) {
						alert("이미 등록된 아이디입니다. 새로운 아이디를 입력하세요.");
						idCheck = "N";
						$("#userId").focus(); 
						
					} else if(userId != data.userId) {
						alert("사용 가능한 아이디입니다.");
						idCheck = "Y";
						document.getElementById('userId').readOnly = true;
					}
				}
			});
		}
	});
	
	// 이메일 인증
	$("#userEmailCheck").click(function() {
		
		if(emailCheck == "N") {
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
		    	// 입력한 이메일
		    	var full_email = email_jsp.value;
		    	// dot(.) 앞까지 자른 이메일
		    	var email = full_email.split('.');
		    	
		    	$.ajax({
					url : "/userEmailCheck/"+email,
					type : "get",
					error : function(xhr, status, msg) {
						console.log("ajax 실패");
						console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
					},
					success : function(data) {
						
						if(full_email == data.email) {
							alert("이미 등록된 이메일입니다. 다른 이메일을 입력하세요.");
							emailCheck = "N";
							$("#email").focus(); 
							
						} else if(full_email != data.email) {						
							$.ajax({
								url : '/userEmailAuthNumber/'+email,
								type : 'GET',
								error : function(xhr, status, msg) {
									console.log("ajax 실패");
									console.log("상태값 : "+status+", Http 에러메시지 : "+msg);
								},
								success : function(data) {
									
									auth_code = data;
									document.getElementById('email').readOnly = true;
									alert("인증번호가 메일로 발송되었습니다. 인증번호를 입력해주세요.");
								}
							});
							
						}
						
					}
				});
		    	
		    }
		} else {
			alert("이메일 인증을 완료하였습니다.");
		}
		
	    
	});
	
	// 인증번호 비교 (인증번호를 입력 후 마우스로 다른곳을 클릭하면 실행)
	$("#auth_num").blur(function(){
		if(auth_code == $("#auth_num").val()) {
			$("#auth_result").html("인증번호가 일치합니다.");
			$("#auth_result").css("color","green");
			emailCheck = "Y";
			document.getElementById('auth_num').readOnly = true;
			
		} else {
			$("#auth_result").html("인증번호가 일치하지 않습니다.");
			$("#auth_result").css("color","red");
			emailCheck = "N";
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

#auth_num {
    margin : 0 0 5px;
}

#auth_result {
	margin : 0 0 15px;
}
</style>
</head>
<body class="is-preload" onload="document.userJoinForm.userId.focus();">
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
								<br><h2>회원가입</h2>
							</header>
							<!-- content-->
				            <div id="content">
								<form name="userJoinForm" action="/userInsert.do" method="post">
									<input type="hidden"  name="${_csrf.parameterName}" value="${_csrf.token}"/>
									<input type="hidden" id="birthday" name="birthday">
					                <!-- ID -->
					                <div>
				                        <h4>아이디</h4>
				                        <div id="id_wrap">
					                        <div id="id_input">
					                        	<input type="text" id="userId" name="userId" class="int" maxlength="20" placeholder="아이디 입력">
					                        </div>
					                        <div id="id_btn">
					                        	<input type="button" id="userIdCheck" class="button" value="중복확인"/>
					                        </div>
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
					                        	<input type="text" id="yyyy" name="yyyy" class="int" maxlength="4" placeholder="년(4자)">
					                        </div>
					                        <!-- BIRTH_MM -->
					                        <div id="bir_mm">
				                                <select id="mm" name="mm" class="sel">
				                                    <option>월</option>
				                                    <option value="01">1</option>
				                                    <option value="02">2</option>
				                                    <option value="03">3</option>
				                                    <option value="04">4</option>
				                                    <option value="05">5</option>
				                                    <option value="06">6</option>
				                                    <option value="07">7</option>
				                                    <option value="08">8</option>
				                                    <option value="09">9</option>                                    
				                                    <option value="10">10</option>
				                                    <option value="11">11</option>
				                                    <option value="12">12</option>
				                                </select>
					                        </div>
					                        <!-- BIRTH_DD -->
					                        <div id="bir_dd">
				                                <input type="text" id="dd" name="dd" class="int" maxlength="2" placeholder="일">
					                        </div>					
					                    </div>
					                </div>
					                <!-- GENDER -->
					                <div>
					                    <h4>성별</h4>
				                        <select id="gender" name="gender" class="sel">
				                            <option>성별</option>
				                            <option value="F">여자</option>
				                            <option value="M">남자</option>
				                        </select>  
					                </div>
					                <!-- EMAIL -->
					                <div>
					                    <h4>이메일</h4>
					                    <input type="text" id="email" name="email" class="int" maxlength="100" placeholder="이메일 입력">
					                    <div id="id_wrap">
					                        <div id="id_input">
					                        	<input type="text" id="auth_num" name="auth_num" class="int" placeholder="인증번호 입력">
					                        	<p id="auth_result"></p>
					                        </div>
					                        <div id="id_btn">
					                        	<input type="button" id="userEmailCheck" class="button" value="이메일 인증"/>
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
					                	<input type="submit" id="submit" class="button" value="가입하기"/>
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