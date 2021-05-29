package com.suvin.project.controller;

import java.io.PrintWriter;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suvin.project.service.UserService;
import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.PageMaker;
import com.suvin.project.vo.UserVO;

@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Resource(name = "userService")
	private UserService service;
	
	// 전체회원 조회(ajax)
	@RequestMapping(value="/userSelect", method= RequestMethod.GET)
	@ResponseBody
	public List<UserVO> allUserSelect(UserVO vo) throws Exception {
		return service.userSelect(vo);
	}

	// 로그인 화면
	@RequestMapping(value="/userLoginForm")
	public String userLoginForm() throws Exception {
		return "/user/userLogin";
	}
	
	// 회원 로그인
	@RequestMapping(value="/user/userLogin")
	public String userLogin(String userId) throws Exception {
		return "home";
	}
	
	// 회원가입 화면
	@RequestMapping(value="/userJoin")
	public String userJoin() throws Exception {
		return "/user/userJoin";
	}
	
	// 회원 계정 찾기
	@RequestMapping(value="/userFindAccountForm")
	public String userPwFind() throws Exception {
		return "/user/userFindAccount";
	}
	
	// 임시 비밀번호 메일전송 (ajax)
	@ResponseBody
	@RequestMapping(value="/userTempPw.do", method= RequestMethod.POST)
	public String userTempPw(UserVO vo) throws Exception {
		String email = vo.getEmail();
		String userId = vo.getUserId();
		
		// 랜덤한 문자열을 담을 StringBuffer
		StringBuffer temp = new StringBuffer();
		// random 클래스 생성
		Random rnd = new Random();
		// 15번 반복하여 랜덤한 문자열 생성
		for (int i = 0; i < 15; i++) {
		    int rIndex = rnd.nextInt(3);
		    switch (rIndex) {
		    case 0:
		        // a-z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
		        break;
		    case 1:
		        // A-Z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
		        break;
		    case 2:
		        // 0-9
		        temp.append((rnd.nextInt(10)));
		        break;
		    }
		}
		
		// randomPw에 StringBuffur형인 랜덤 문자열 담아준 후 vo객체에 담아 service에 보내서 랜덤문자열로 비밀번호를 바꾼다.
		// 메일로 전송할 램덤 문자열 (암호화 전)
		String randomPw = temp.toString();
		// update할 랜덤 문자열 (암호화 후)
		String encodePw = bcryptPasswordEncoder.encode(randomPw);
		vo.setUserPw(encodePw);
		service.userRandomPw(vo);
		
		// 이메일 보내기
        String setFrom = "lsbinnn7@gmail.com";
        String toMail = email;
        String title = userId+"님의 임시 비밀번호 관련 이메일입니다.";
        String content = 
                "홈페이지를 이용해주셔서 감사합니다." +
                "<br><br>" + 
                "임시 비밀번호는 " + randomPw + "입니다." + 
                "<br>" + 
                "해당 임시 비밀번호로 로그인 후 새로운 비밀번호로 변경해주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
		return randomPw;
	}
//	
//	// 로그인 실패 시 화면
//	@RequestMapping(value="/loginError")
//	public String userLoginFales(HttpServletResponse response) throws Exception {
//		logger.info("로그인 실패로 loginError controller in");
//		
//		response.setContentType("text/html; charset=UTF-8");
//		PrintWriter out = response.getWriter();
//		out.println("<script>alert('로그인 실패');</script>");
//		out.flush();
//		
//		return "/user/userLogin";
//	}
//	
	
	// 회원가입 시 아이디 중복 체크(ajax)
	@RequestMapping(value="/userIdCheck/{id}", method= RequestMethod.GET)
	@ResponseBody
	public UserVO userIdCheck(@PathVariable("id") String userId) throws Exception {
		return service.userIdCheck(userId);
	}
	
	// 회원가입 시 이메일 중복 체크(ajax) 이메일 dot 뒤에 잘릴 때 :.+ 추가로 입력해주면 됨
	@RequestMapping(value="/userEmailCheck/{email}", method= RequestMethod.GET)
	@ResponseBody
	public UserVO userEmailCheck(@PathVariable("email") List<String> email) throws Exception {
		return service.userEmailCheck(email.get(0)+"."+email.get(1));
	}

	// 회원가입 시 이메일 인증
	@RequestMapping(value="/userEmailAuthNumber/{email}", method= RequestMethod.GET)
	@ResponseBody
	public String userEmailAuthNumber(@PathVariable("email") List<String> email) throws Exception {
		String fullEmail = email.get(0)+"."+email.get(1);
		
		// 인증번호 난수 생성
		Random random = new Random();
		// 111111~999999 범위
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("인증번호 : "+checkNum);
		
		// 이메일 보내기
        String setFrom = "lsbinnn7@gmail.com";
        String toMail = fullEmail;
        String title = "회원가입 인증 이메일입니다.";
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
		String num = Integer.toString(checkNum);
		
		return num;
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
	
	// 내 작성글
	@RequestMapping(value="/userWritingList.do")
	public ModelAndView userWritingList(Criteria cri) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/user_writing");
		
		List<BoardVO> board_list = service.writingList(cri);	
		mv.addObject("board_list",board_list);
		
		PageMaker board_pageMaker = new PageMaker();
		board_pageMaker.setCri(cri);
		board_pageMaker.setTotalCount(service.writingListCount(cri));
        mv.addObject("board_pageMaker", board_pageMaker);
        
		return mv;
	}
	
	// 내 댓글
	@RequestMapping(value="/userReplyList.do")
	public ModelAndView userReplyList(Criteria cri) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/user/user_reply");
		
		List<BoardVO> reply_list = service.replyList(cri);	
		mv.addObject("reply_list",reply_list);
		
        PageMaker reply_pageMaker = new PageMaker();
        reply_pageMaker.setCri(cri);
        reply_pageMaker.setTotalCount(service.replyListCount(cri));
        mv.addObject("reply_pageMaker", reply_pageMaker);
        
		return mv;
	}
	
	// 내가 좋아요 누른 글
	@RequestMapping(value="/userLikeList.do")
	public ModelAndView userLikeList(Criteria cri) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/user/user_like");
		
		List<BoardVO> like_list = service.likeList(cri);	
		mv.addObject("like_list",like_list);
		
		PageMaker like_pageMaker = new PageMaker();
        like_pageMaker.setCri(cri);
        like_pageMaker.setTotalCount(service.likeListCount(cri));
        mv.addObject("like_pageMaker", like_pageMaker);
        
		return mv;
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
