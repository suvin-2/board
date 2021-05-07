package com.suvin.project.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suvin.project.service.BoardService;
import com.suvin.project.service.CategoryService;
import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.CategoryVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.PageMaker;


/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService service;
	@Resource(name = "categoryService")
	private CategoryService cService;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	// url mapping
	// 기본, 루트 페이지 -> home메서드 호출
	/*
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(BoardVO vo, Locale locale, Model model) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);*/
		
		/*
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		// 모델(서블릿의 request 객체를 대체한 것)
		model.addAttribute("serverTime", formattedDate );
		*/
		/*List<BoardVO> list = service.boardSelect(vo);
		logger.info(list.toString());
		model.addAttribute("list",list);
		
		// home.jsp로 포워딩
        // servlet-context.xml
        // <beans:property name="prefix" value="/WEB-INF/views/" />
        // <beans:property name="suffix" value=".jsp" />
        // 디렉토리(접두어)와 jsp(접미어)확장자를 제외하고 이름만 작성하도록 세팅
		return "home";
	}
	*/
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(BoardVO vo, CategoryVO cVo, Locale locale, Model model) throws Exception {
		
		logger.info("Welcome home! The client locale is {}.", locale);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("home");
		mv.addObject("list",service.boardSelect(vo));
		
		return mv;
	}
	
	/*
	// 게시판 카테고리 별 글 목록
	@RequestMapping(value = "/boardList.do")
	public String boardSelect(BoardVO vo, Model model) throws Exception {
		List<BoardVO> list = service.boardCategorySelect(vo);
		logger.info(list.toString());
		model.addAttribute("list",list);
		
		return "/board/boardList";
	}
	*/
	
	// 게시판 카테고리 별 글 목록
	@RequestMapping(value = "/boardList.do")
	public ModelAndView boardSelect(Criteria cri, Model model) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/boardList");
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount(cri));
		mv.addObject("list",service.boardCategorySelect(cri));
		mv.addObject("pageMaker", pageMaker);
		
		return mv;
	}
	
	/*
	// 게시글 단건조회 폼 
	@RequestMapping(value = "/boardDetailForm.do")
	public String boardDetailForm(@ModelAttribute("boardVO") BoardVO vo, Model model) throws Exception{
		System.out.println("board detail form in ");
		return "board/boardDetail";
	}
	*/
	
	// 게시글 단건 조회 (detail)
	@RequestMapping(value = "/boardSelectDetail.do", method= RequestMethod.GET)
	public ModelAndView boardSelectDetail(BoardVO vo, Criteria cri, Model model) throws Exception {
		//vo.getbNo(bNo);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/boardDetail");
		// 조회수 up
		service.boardUpdateCnt(vo);
		
		List<BoardVO> list = service.boardSelectDetail(vo);	
		mv.addObject("list",list);
		
		PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        mv.addObject("page",cri.getPage());
        mv.addObject("pageMaker", pageMaker);
		
		return mv;
	}
	
	// 게시글 단건 조회(ajax) boardUpdate.jsp 에서 사용
	@ResponseBody
	@RequestMapping(value = "/boardListOne/{bNo}", method= RequestMethod.GET)
	public BoardVO boardSelectOne(@PathVariable("bNo") int bNo, BoardVO vo, Model model) throws Exception {
		logger.info(vo.toString());
		vo.getbNo(bNo);
		return service.boardSelectOne(vo);
	}
	
	// 게시글 등록 폼 
	@RequestMapping(value = "/boardInsertForm.do")
	public String boardInsertForm(@ModelAttribute("boardVO") BoardVO vo, CategoryVO cVo, Model model) throws Exception{
		List<CategoryVO> list = cService.categorySelect(cVo);
		model.addAttribute("list",list);
		return "board/boardInsert";
	}
	
	// 게시글 등록
	@RequestMapping(value = "/boardInsert.do")
	public String boardInsert(@ModelAttribute("boardVO") BoardVO vo, Model model) throws Exception {
		service.boardInsert(vo);
		System.out.println("boardController insert 된 값 : " + vo);
		return "redirect:/boardSelectDetail.do?bNo="+vo.getbNo();
	}
	
	// 게시글 수정 폼 
	
	@RequestMapping(value = "/boardUpdateForm.do")
	public String boardUpdateForm(@ModelAttribute("boardVO") BoardVO vo, CategoryVO cVo, Model model) throws Exception{
		
		List<CategoryVO> list = cService.categorySelect(cVo);
		model.addAttribute("list",list);
		return "board/boardUpdate";
	}
	
	
	// 게시글 수정
	@RequestMapping(value = "/boardUpdate.do")
	public String boardUpdate(@ModelAttribute("boardVO") BoardVO vo, Model model) {
		service.boardUpdate(vo);
		return "redirect:/boardSelectDetail.do?bNo="+vo.getbNo();
	}
	
	// 게시글 삭제
	@RequestMapping(value = "/boardDelete.do")
	public String boardDelete(int bNo) {
		service.boardDelete(bNo);
		return "redirect:/boardList.do";
	}
	
}
