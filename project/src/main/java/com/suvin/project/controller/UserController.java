package com.suvin.project.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suvin.project.service.UserService;
import com.suvin.project.vo.UserVO;

@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Resource(name = "userService")
	private UserService service;

	// 로그인 화면
	@RequestMapping(value="/userLoginForm")
	public String userLoginForm() throws Exception {
		return "/user/userLogin";
	}
	
	// 회원 로그인
//	@RequestMapping(value="/userLogin")
//	public UserVO userLogin(String userId) throws Exception {
//		return null;
//	}
	
	// 회원가입 화면
	@RequestMapping(value="/userJoin")
	public String userJoin() throws Exception {
		return "/user/userJoin";
	}
	
	// 로그인 실패 시 화면
	@RequestMapping(value="/loginError")
	public String userLoginFales(HttpServletResponse response) throws Exception {
		logger.info("로그인 실패로 loginError controller in");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('로그인 실패');</script>");
		out.flush();
		
		return "/user/userLogin";
	}
	
	// 회원가입 시 아이디 중복 체크(ajax)
	@RequestMapping(value="/userIdCheck/{id}", method= RequestMethod.GET)
	@ResponseBody
	public UserVO userIdCheck(@PathVariable("id") String userId) throws Exception {
		logger.info("user id check controller in (ajax) id : "+userId);
		
		return service.userIdCheck(userId);
	}
	
	// 회원가입 시 이메일 중복 체크(ajax) 이메일 dot 뒤에 잘릴 때 :.+ 추가로 입력해주면 됨
	@RequestMapping(value="/userEmailCheck/{email}", method= RequestMethod.GET)
	@ResponseBody
	public UserVO userEmailCheck(@PathVariable("email") String email) throws Exception {
		logger.info("user Email check controller in (ajax) email : "+email);
		System.out.println("user controller email check : "+service.userEmailCheck(email));
		return service.userEmailCheck(email);
	}
	
	// 회원가입 시 전화번호 중복 체크(ajax)
	@RequestMapping(value="/userTelCheck/{tel}", method= RequestMethod.GET)
	@ResponseBody
	public UserVO userTelCheck(@PathVariable("tel") String tel) throws Exception {
		logger.info("user Tel check controller in (ajax) tel : "+tel);
		
		return service.userTelCheck(tel);
	}

	
	// 회원가입
	@RequestMapping(value="/userInsert.do")
	public String userInsert(@ModelAttribute("userVO") UserVO vo, Model model,HttpServletResponse response) throws Exception {
		
		String encodePw = bcryptPasswordEncoder.encode(vo.getUserPw());
		vo.setUserPw(encodePw);
		
		// 회원 등록 전 alert 창 띄우기
		if(vo != null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('회원가입이 완료되었습니다');</script>");
			out.flush();
			service.userInsert(vo);
		}
		return "/user/userLogin";
	}

	// 회원수정 화면
	@RequestMapping(value="/userInfoForm.do")
	public String userInfoForm() throws Exception {
		return "/user/userInfo";
	}
	
	// 회원 정보 조회
	@ResponseBody
	@RequestMapping(value="/userInfoSelect/{userId}", method= RequestMethod.GET)
	public UserVO userInfoSelect(@PathVariable("userId") String userId, UserVO vo, Model model) throws Exception {
		vo.getUserId(userId);
		return service.userInfoSelect(vo);
	}
	
	// 회원 정보 수정
	@RequestMapping(value="/userInfo.do")
	public String userInfo(@ModelAttribute("userVO") UserVO vo, Model model,HttpServletResponse response) throws Exception {
		
		String encodePw = bcryptPasswordEncoder.encode(vo.getUserPw());
		vo.setUserPw(encodePw);
		
		if(vo != null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('정보 수정이 완료되었습니다');</script>");
			out.flush();
			service.userUpdate(vo);
		}
		return "/user/userInfo";
	}
	
}
