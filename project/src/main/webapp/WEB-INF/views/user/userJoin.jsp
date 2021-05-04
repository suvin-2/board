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
	
	$("#fCheck").click(function(){
		
		var birthday;
		var yyyy = document.getElementById("yyyy").value;
		var mm = document.getElementById("mm").value;
		var dd = document.getElementById("dd").value;
		
		console.log('yyyy:'+yyyy+' mm:'+mm+' dd:'+dd);
		birthday = yyyy+mm+dd;
		document.getElementById("birthday").value = birthday;
		
		console.log('birthday 대입 후 : ' + document.getElementById("birthday").value);
		
		
		if($("#userId").val().length==0) { 
			alert("ID를 입력하세요."); 
			$("#userId").focus(); 
			return false; 
		}
		if($("#userPw1").val().length==0) { 
			alert("비밀번호를 입력하세요."); 
			$("#userPw1").focus(); 
			return false; 
		}
		if($("#userPw2").val().length==0) { 
			alert("비밀번호를 재확인하세요."); 
			$("#userPw2").focus(); 
			return false; 
		}
		if($("#userPw1").val() != $("#userPw2").val()) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#userPw2").focus(); 
			return false; 
		}
		
		if($("#email").val().length==0) { 
			alert("이메일을 입력하세요."); 
			$("#email").focus(); 
			return false; 
		}
		if($("#tel").val().length==0) { 
			alert("휴대전화를 입력하세요."); 
			$("#tel").focus(); 
			return false; 
		}
		
	});
	
	$("#submit").click(function(){
		
		var birthday;
		var yyyy = document.getElementById("yyyy").value;
		var mm = document.getElementById("mm").value;
		var dd = document.getElementById("dd").value;
		
		console.log('yyyy:'+yyyy+' mm:'+mm+' dd:'+dd);
		birthday = yyyy+mm+dd;
		document.getElementById("birthday").value = birthday;
		
		console.log('birthday 대입 후 : ' + document.getElementById("birthday").value);
		
		if($("#userId").val().length==0) { 
			alert("ID를 입력하세요."); 
			$("#userId").focus(); 
			return false; 
		}
		if($("#userPw1").val().length==0) { 
			alert("비밀번호를 입력하세요."); 
			$("#userPw1").focus(); 
			return false; 
		}
		if($("#userPw2").val().length==0) { 
			alert("비밀번호를 재확인하세요."); 
			$("#userPw2").focus(); 
			return false; 
		} else if($("#userPw1").val() =! $("#userPw2").val()) {
			alert("비밀번호가 일치하지 않습니다.");
		}
		
		
		if($("#email").val().length==0) { 
			alert("이메일을 입력하세요."); 
			$("#email").focus(); 
			return false; 
		}
		if($("#tel").val().length==0) { 
			alert("휴대전화를 입력하세요."); 
			$("#tel").focus(); 
			return false; 
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

/* 에러메세지 */
.error_next_box {
    margin-top: 9px;
    font-size: 12px;
    color: red;    
    display: none;
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
					                    <span class="error_next_box"></span>
					                </div>
					                <!-- PW1 -->
					                <div>
					                    <h4>비밀번호</h4>
					                    <div>
					                    	<input type="password" id="userPw1" name="userPw" class="int" maxlength="20">
					                        <span id="alertTxt">사용불가</span>
					                    </div>
					                    <span class="error_next_box"></span>
					                </div>
					                <!-- PW2 -->
					                <div>
					                    <h4>비밀번호 재확인</h4>
					                    <input type="password" id="userPw2" class="int" maxlength="20">
					                    <span class="error_next_box"></span>
					                </div>
					                
					                <!-- NAME -->
					                <div>
					                    <h4>이름</h4>
					                    <input type="text" id="userName" name="userName" class="int" maxlength="20">
					                    <span class="error_next_box"></span>
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
					                    <span class="error_next_box"></span>    
					                </div>
					
					                <!-- GENDER -->
					                <div>
					                    <h4>성별</h4>
				                        <select id="gender" name="gender" class="sel">
				                            <option>성별</option>
				                            <option value="F">여자</option>
				                            <option value="M">남자</option>
				                        </select>  
					                    <span class="error_next_box">필수 정보입니다.</span>
					                </div>
					
					                <!-- EMAIL -->
					                <div>
					                    <h4>이메일</h4>
				                        <input type="text" id="email" name="email" class="int" maxlength="100" placeholder="선택입력">
					                    <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>    
					                </div>
					
					                <!-- MOBILE -->
					                <div>
					                    <h4>전화번호</h4>
				                        <input type="text" id="tel" name="tel" class="int" maxlength="16" placeholder="전화번호 입력">
					                    <span class="error_next_box"></span>    
					                </div>
					                
					                <!-- JOIN BTN-->
					                <center>
					                	<input type="submit" id="submit" class="button" value="가입하기"/>
					                	<input type="button" id="fCheck" class="button primary" value="함수확인">
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