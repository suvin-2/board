package com.suvin.project.security;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

// 로그인 실패 대응 로직
@Service
public class UserLoginFailHandler implements AuthenticationFailureHandler {
	
	private String loginidname;
    private String loginpwdname;
    private String errormsgname;
    private String defaultFailureUrl;
    
//    public UserLoginFailHandler() {
//		this.defaultFailureUrl = "/login";
//	}

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
				
		loginidname = request.getParameter(loginidname);
		loginpwdname = request.getParameter(loginpwdname);
		
		System.out.println("----- 로그인 실패 로직 in -----");
		System.out.println("----- loginidname : "+loginidname+", loginpwdname : "+loginpwdname);
		System.out.println("----- error msg : "+exception.getMessage());
		
		if (exception instanceof AuthenticationServiceException) {
			request.setAttribute("loginFailMsg", "존재하지 않는 회원입니다.");
		
		} else if(exception instanceof BadCredentialsException) {
			request.setAttribute("loginFailMsg", "아이디 또는 비밀번호가 틀립니다.");
			
		} else if(exception instanceof LockedException) {
			request.setAttribute("loginFailMsg", "잠긴 계정입니다.");
			
		} else if(exception instanceof DisabledException) {
			request.setAttribute("loginFailMsg", "비활성화된 계정입니다.");
			
		} else if(exception instanceof AccountExpiredException) {
			request.setAttribute("loginFailMsg", "만료된 계정입니다.");
			
		} else if(exception instanceof CredentialsExpiredException) {
			request.setAttribute("loginFailMsg", "비밀번호가 만료되었습니다.");
		}
		System.out.println("로그인 실패 로직 response : "+response);
		// 로그인 페이지로 다시 포워딩
//		RequestDispatcher dispatcher = request.getRequestDispatcher("/userLoginForm");
//		dispatcher.forward(request, response);
		System.out.println("----- defaultFailureUrl : "+defaultFailureUrl);
		request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
	}

	public String getLoginidname() {
		return loginidname;
	}

	public void setLoginidname(String loginidname) {
		this.loginidname = loginidname;
	}

	public String getLoginpwdname() {
		return loginpwdname;
	}

	public void setLoginpwdname(String loginpwdname) {
		this.loginpwdname = loginpwdname;
	}

	public String getErrormsgname() {
		return errormsgname;
	}

	public void setErrormsgname(String errormsgname) {
		this.errormsgname = errormsgname;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}

}
