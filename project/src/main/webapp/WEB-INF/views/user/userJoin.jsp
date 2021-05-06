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
	
	$("#submit").click(function(){
		
		var userId = document.querySelector('#userId');

		var userPw1 = document.querySelector('#userPw1');
		var pwMsg = document.querySelector('#alertTxt');

		var userPw2 = document.querySelector('#userPw2');
		var pwMsgArea = document.querySelector('.int_pass');

		var userName = document.querySelector('#userName');

		var gender = document.querySelector('#gender');

		var email = document.querySelector('#email');

		var tel = document.querySelector('#tel');

		var error = document.querySelectorAll('.error_next_box');
		
		var birthday;
		var yyyy = document.getElementById("yyyy").value;
		var mm = document.getElementById("mm").value;
		var dd = document.getElementById("dd").value;
		
		console.log('yyyy:'+yyyy+', mm:'+mm+', dd:'+dd);
		
		birthday = yyyy+mm+dd;
		document.getElementById("birthday").value = birthday;
		
		console.log('birthday 대입 후 : ' + document.getElementById("birthday").value);
		console.log('tel : '+tel.value);
		
		// id 유효성 체크
		var idPattern = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
		
		if($("#userId").val().length == 0) { 
			alert("ID를 입력하세요.");
			$("#userId").focus(); 
			return false; 
		}
		if(!idPattern.test(userId.value)) {
			alert("아이디는 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다."); 
			$("#userId").focus(); 
			return false;
	    }
		
		// pw 유효성 체크
	    var pwPattern = /^[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]{8,16}$/;
	    var pwPattern = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	    
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
	    var namePattern = /^[가-힣a-zA-Z]+$/;
	    
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

	    if(yyyy == "") {
	        alert("태어난 년도 4자리를 입력하세요.");
	    	$("#yyyy").focus(); 
			return false;
	    }

        if(mm == "월") {
        	alert("태어난 월을 선택하세요.");
	    	$("#mm").focus(); 
			return false;
        }
        
        if(dd == "") {
            alert("태어난 일(날짜) 2자리를 정확하게 입력하세요.");
	    	$("#dd").focus(); 
			return false;
        }

        var yearPattern = /^[0-9_]{4}$/;
   		var datePattern = /^[0-9_]{2}$/;
    	
	    if(!datePattern.test(dd)) {
	        alert("태어난 일(날짜) 2자리로 입력해주세요.(ex)07)");
	    	$("#dd").focus(); 
			return false;
	    }
		
		if(Number(dd)<1 || Number(dd)>31) {
		    alert("태어난 일(날짜) 2자리를 다시 확인해주세요.");
			$("#dd").focus(); 
			return false;
		}
		
	    if(Number(yyyy) < 1920) {
	        alert("태어난 년도를 다시 확인해주세요.");
	    	$("#yyyy").focus(); 
			return false;
	    }
	    
	    if(Number(yyyy) > 2022) {
	        alert("태어난 년도를 다시 확인해주세요.");
	    	$("#yyyy").focus(); 
			return false;
	    }

	    // 이메일 유휴성 체크
	    var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	    if(email.value === ""){ 
	    	alert("이메일을 입력하세요.");
	    	$("#email").focus(); 
			return false;
	    }
	    
	    if(!emailPattern.test(email.value)) {
	    	alert("이메일을 다시 확인해주세요.");
	    	$("#email").focus(); 
			return false;
	    }

		// 전화번호 유호성 체크
	    var isPhoneNum = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

	    if(tel.value === "") {
	    	alert("휴대폰 번호를 입력하세요.");
	    	$("#tel").focus(); 
			return false;
	    }
	    
	    if(!isPhoneNum.test(tel.value)) {
	        alert("형식에 맞지 않는 번호입니다.");
	    	$("#tel").focus(); 
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
<body class="is-preload" onload="document.userJoinForm.userId.focus();">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Main -->
			<div id="main">
				<div class="inner">	
					<!-- Header -->
					<jsp:include page="../board/boardHead.jsp" flush="false"/>	
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
				                        <input type="text" id="userId" name="userId" class="int" maxlength="20">
					                    <span class="error_next_box" id="idMsg"></span>
					                </div>
					                <!-- PW1 -->
					                <div>
					                    <h4>비밀번호</h4>
					                    <div>
					                    	<input type="password" id="userPw1" name="userPw" class="int" maxlength="20">
					                        <span id="alertTxt">사용불가</span>
					                    </div>
					                    
					                </div>
					                <!-- PW2 -->
					                <div>
					                    <h4>비밀번호 재확인</h4>
					                    <input type="password" id="userPw2" class="int" maxlength="20">
					                    
					                </div>
					                
					                <!-- NAME -->
					                <div>
					                    <h4>이름</h4>
					                    <input type="text" id="userName" name="userName" class="int" maxlength="20">
					                    
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
				                        <input type="text" id="email" name="email" class="int" maxlength="100" placeholder="선택입력">
					                        
					                </div>
					
					                <!-- MOBILE -->
					                <div>
					                    <h4>휴대폰 번호</h4>
				                        <input type="text" id="tel" name="tel" class="int" maxlength="16" placeholder="전화번호 입력">
					                        
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