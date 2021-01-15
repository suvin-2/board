package com.suvin.project.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.suvin.project.service.BoardService;
import com.suvin.project.vo.BoardVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService service;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	// url mapping
	// 기본, 루트 페이지 -> home메서드 호출
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		// 모델(서블릿의 request 객체를 대체한 것)
		model.addAttribute("serverTime", formattedDate );
		
		// home.jsp로 포워딩
        // servlet-context.xml
        // <beans:property name="prefix" value="/WEB-INF/views/" />
        // <beans:property name="suffix" value=".jsp" />
        // 디렉토리(접두어)와 jsp(접미어)확장자를 제외하고 이름만 작성하도록 세팅
		return "home";
	}
	
	// 게시판 전체 글 목록
	@RequestMapping(value = "/boardList.do")
	public String projectList(Model model) throws Exception {
		
		List<BoardVO> list = service.selectBoardList();
		logger.info(list.toString());
		model.addAttribute("list",list);
		return "/board/boardList";
	}
	
	// 게시판 글 등록폼 
	@RequestMapping(value = "/boardInsertForm.do")
	public String boardInsertForm(@ModelAttribute("boardVO") BoardVO vo, Model model) throws Exception{
		return "board/boardInsert";
	}
	
	// 게시판 글 등록
	@RequestMapping(value = "/boardInsert.do")
	public String boardInsert(@ModelAttribute("boardVO") BoardVO vo, Model model) {
		service.boardInsert(vo);
		return "redirect:/boardList.do";
	}
	
}
