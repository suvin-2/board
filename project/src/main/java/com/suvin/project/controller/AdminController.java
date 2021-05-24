package com.suvin.project.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suvin.project.service.AdminService;
import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.PageMaker;
import com.suvin.project.vo.UserVO;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Resource(name="adminService")
	private AdminService service;
	
	// admin main 화면
	@RequestMapping(value="/adminMainForm.do")
	public String adminMain() throws Exception {
		return "/admin/adminMain";
	}
	
	// 신규 회원 조회 (ajax)
	@ResponseBody
	@RequestMapping(value="/newUserList.do")
	public List<UserVO> newUserList(UserVO vo) throws Exception {
		return service.newUserList(vo);
	}
	
	// 좋아요 1개 이상인 글 전체 조회 (ajax)
	@ResponseBody
	@RequestMapping(value="/boardLikeList.do")
	public List<BoardVO> likeList(BoardVO vo) throws Exception {
		return service.boardLikeList(vo);
	}
	
	// 좋아요 많은 순서대로 정렬한 bNo List (ajax)
	@ResponseBody
	@RequestMapping(value="/boardLikeCntList.do")
	public List<BoardVO> boardLikeCntList(BoardVO vo) throws Exception {
		return service.boardLikeCntList(vo);
	}
	
	// 전체 회원 조회 & 페이징
	@RequestMapping(value="/adminAllUserForm.do")
	public ModelAndView adminAllUserForm(Criteria cri) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/adminAllUser");
		mv.addObject("list", service.allUserList(cri));
		System.out.println("admin controller 전체 회원 조회 vo :"+service.allUserList(cri));
		// 페이징
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.userCount());
		mv.addObject("pageMaker", pageMaker);
        
		return mv;
	}
	
	// 회원 계정 비활성화
	@ResponseBody
	@RequestMapping(value="/userStopActivity.do")
	public int userStopActivity(UserVO vo) throws Exception {
		return service.userStopActivity(vo);
	}
	
	// 회원 계정 활성화
	@ResponseBody
	@RequestMapping(value="/userResumeActivity.do")
	public int userResumeActivity(UserVO vo) throws Exception {
		return service.userResumeActivity(vo);
	}
	
	
	// 회원 계정 활성화 관련 메일 전송
	@ResponseBody
	@RequestMapping(value="/userActivityEmail.do", method= RequestMethod.GET)
	public String userActivityEmail(UserVO vo) throws Exception {
		
		System.out.println("admin controller 메일 전송 method in --------------");
		
		String userId = vo.getUserId();
		String email = vo.getEmail();
		int enabled = vo.getEnabled();
		
		// 이메일 보내기
        String setFrom = "lsbinnn7@gmail.com";
        String toMail = email;
        String resume_title = "회원 계정 활성화 관련 이메일입니다.";
        String resume_content = 
                "항상 홈페이지를 이용해주셔서 감사합니다." +
                "<br><br>" + 
                userId +"님의 계정은 관리자에 의해 활성화 되었습니다." + 
                "<br>" + 
                "감사합니다.";
        String stop_title = "회원 계정 비활성화 관련 이메일입니다.";
        String stop_content = 
                "항상 홈페이지를 이용해주셔서 감사합니다." +
                "<br><br>" + 
                userId +"님의 계정은 관리자에 의해 비활성화 되었습니다." + 
                "<br>" + 
                "해당 계정의 활성화를 원하시면 본 메일로 답신주세요.";
        
        
        if(enabled == 1) {
        	System.out.println("계정 비활성화 메일~~");
    		try {
                
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
                helper.setFrom(setFrom);
                helper.setTo(toMail);
                helper.setSubject(stop_title);
                helper.setText(stop_content,true);
                mailSender.send(message);
                
            } catch(Exception e) {
                e.printStackTrace();
            }
        } else {
        	System.out.println("계정 활성화 메일~~");
        	try {
                
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
                helper.setFrom(setFrom);
                helper.setTo(toMail);
                helper.setSubject(resume_title);
                helper.setText(resume_content,true);
                mailSender.send(message);
                
            } catch(Exception e) {
                e.printStackTrace();
            }
        }
        
        String result = "mail send ok";
		return result;
	}
	
	// 회원 계정 비활성화 체크
	@ResponseBody
	@RequestMapping(value="/userStopActivityCheck.do")
	public List<UserVO> userStopActivityCheck(UserVO vo) throws Exception {
		return service.userStopActivityCheck(vo);
	}
}
