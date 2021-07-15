package com.suvin.project.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.suvin.project.vo.ReplyVO;
import com.suvin.project.vo.UserVO;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Resource(name="adminService")
	private AdminService service;
	
	// admin main.jsp ------------------------------------------------------
	// admin main 화면, 게시글/댓글 통계 데이터 같이 보냄
	@RequestMapping(value="/adminMainForm.do")
	public ModelAndView adminMain(BoardVO bVo, ReplyVO rVo) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		//원하는 데이터 포맷 지정
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY-MM-dd"); 
		// 오늘 날짜
		Date now = new Date();
		String strNowDate = simpleDateFormat.format(now);
		
		bVo.setsDate(strNowDate);
		rVo.setsDate(strNowDate);
		
		List<BoardVO> bList = service.BoardCntChart(bVo);
		List<ReplyVO> rList = service.ReplyCntChart(rVo);
		System.out.println("날짜 포맷 전 : "+bList.get(0).getsDate().substring(0,8));
		System.out.println("날짜 포맷 후 : "+simpleDateFormat.parse(bList.get(0).getsDate().substring(0,8)));
		
		String str ="";
		String cntChart = "";
		int num = 0;
		//str += "['날짜','게시글','댓글'],";

		for(int i=0;i<bList.size();i++) {
			str += "['";
			str += bList.get(i).getsDate().substring(0,8);
			str += "',";
			str += bList.get(i).getCnt();
			str += ",";
			str += rList.get(i).getCnt();
			str += "]";
			
			num++;
			if(num<bList.size()) {
				str += ",";
			}
		}
		
		int n = 0;
		
		for(int i=0;i<bList.size();i++) {
			cntChart += "{date:'20";
			cntChart += bList.get(i).getsDate().substring(0,8);
			cntChart += "', value1:";
			cntChart += bList.get(i).getCnt();
			cntChart += ", value2:";
			cntChart += rList.get(i).getCnt();
			cntChart += "}";
			
			n++;
			if(n<bList.size()) {
				cntChart += ",";
			}
		}
		
		System.out.println("str : "+str);
		System.out.println("cntChart : "+cntChart);
		mv.setViewName("/admin/adminMain");
		mv.addObject("str",str);
		mv.addObject("cntChart",cntChart);
		
		return mv;
	}
	
	
	// 게시글 개수, 댓글 개수
	// jsp에서 date type의 데이터를 받을 땐 @DateTimeFormat를 설정해줘야함
	@ResponseBody
	@RequestMapping(value = "/boardCntReplyCnt.do")
	public ModelAndView boardCntReplyCnt(BoardVO bVo, ReplyVO rVo) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		
		//원하는 데이터 포맷 지정
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY-MM-dd"); 
		// 오늘 날짜
		Date now = new Date();
		String strNowDate = simpleDateFormat.format(now);
		
		bVo.setsDate(strNowDate);
		rVo.setsDate(strNowDate);
		
		List<BoardVO> bList = service.BoardCntChart(bVo);
		List<ReplyVO> rList = service.ReplyCntChart(rVo);
		
		HashMap map = new HashMap();
		
		String str ="[";
		int num = 0;
		//str += "['날짜','게시글','댓글'],";

		for(int i=0;i<bList.size();i++) {
			str += "['";
			str += bList.get(i).getsDate();
			str += "',";
			str += bList.get(i).getCnt();
			str += ",";
			str += rList.get(i).getCnt();
			str += "]";
			
			num++;
			if(num<bList.size()) {
				str += ",";
			}
		}
		str += "]";
		System.out.println("str : "+str);
		mv.addObject("str",str);
		
//		map.put("bList",bList);
//		map.put("rList",rList);

//		String json = null;
//		try {
//			json = new ObjectMapper().writeValueAsString(str);
//		} catch (JsonProcessingException e) {
//			e.printStackTrace();
//		}
		
		return mv;
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
	
	// admin all user.jsp ------------------------------------------------------
	// 전체 회원 조회 & 페이징
	@RequestMapping(value="/adminAllUserForm.do")
	public ModelAndView adminAllUserForm(Criteria cri) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/adminAllUser");
		mv.addObject("list", service.allUserList(cri));
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

		String userId = vo.getUserId();
		String email = vo.getEmail();
		String enabled = vo.getEnabled();
		
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
        
        
        if(enabled == "1") {
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
	
	// admin board.jsp ------------------------------------------------------
	// 전체 게시글 조회 & 페이징
	@RequestMapping(value="/adminBoardForm.do")
	public ModelAndView adminBoardForm(Criteria cri) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/adminBoard");
		
		// 페이징
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.boardCount());
		mv.addObject("list", service.boardList(cri));
		mv.addObject("pageMaker", pageMaker);

		return mv;
	}
	
	// 게시글 삭제(ajax)
	@ResponseBody
	@RequestMapping(value = "/adminBoardDelete.do/{bNo}", method = RequestMethod.GET)
	public int adminBoardDelete(@ModelAttribute("bNo") int bNo) throws Exception {
		return service.adminBoardDelete(bNo);
	}
	
	// admin reply.jsp ------------------------------------------------------
	// 전체 댓글 조회 & 페이징
	@RequestMapping(value="/adminReplyForm.do")
	public ModelAndView allReplyList(Criteria cri) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/adminReply");
		
		// 페이징
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.allReplyCount());
		mv.addObject("list", service.allReplyList(cri));
		mv.addObject("pageMaker", pageMaker);
	
		return mv;
	}
	
	// 댓글 삭제(ajax)
	@ResponseBody
	@RequestMapping(value = "/adminReplyDelete.do/{rNo}", method = RequestMethod.GET)
	public int adminReplyDelete(@ModelAttribute("rNo") int rNo) throws Exception {
		return service.adminReplyDelete(rNo);
	}
	
	// admin category.jsp ------------------------------------------------------
	// admin category 화면
	@RequestMapping(value="/adminCategoryForm.do")
	public String adminCategoryForm() throws Exception {
		return "/admin/adminCategory";
	}
}
