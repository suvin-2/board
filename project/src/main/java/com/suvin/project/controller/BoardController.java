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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.suvin.project.service.BoardService;
import com.suvin.project.service.CategoryService;
import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.CategoryVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.PageMaker;
import com.suvin.project.vo.ReplyVO;


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
		
		// 댓글 select
		List<ReplyVO> replyList = service.replySelect(vo.getbNo());
		mv.addObject("replyList",replyList);
		
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
		return "redirect:/boardSelectDetail.do?bNo="+vo.getbNo()+"&writer="+vo.getWriter();
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
	public String boardDelete(@ModelAttribute("bNo") int bNo, @ModelAttribute("cName") String cName, @ModelAttribute("sName") String sName, @ModelAttribute("cNo") String cNo) {
		service.boardDelete(bNo);
		return "redirect:/boardList.do";
	}

	// 댓글 등록(ajax)
	@ResponseBody
	@RequestMapping(value = "/replyInsert.do", method = RequestMethod.GET)
	public int replyInsert(ReplyVO vo, @ModelAttribute("bNo") int bNo, @ModelAttribute("rContent") String rContent, @ModelAttribute("rWriter") String rWiter) throws Exception {
		return service.replyInsert(vo);
	}
	
	// 댓글 수정(ajax)
	@ResponseBody
	@RequestMapping(value = "/replyUpdate.do", method = RequestMethod.GET)
	public int replyUpdate(ReplyVO vo, @ModelAttribute("rNo") int rNo, @ModelAttribute("rContent") String rContent) throws Exception {
		return service.replyUpdate(vo);
	}
	
	// 댓글 삭제(ajax)
	@ResponseBody
	@RequestMapping(value = "/replyDelete.do/{rNo}", method = RequestMethod.GET)
	public int replyDelete(@ModelAttribute("rNo") int rNo) throws Exception {
		return service.replyDelete(rNo);
	}
	
	// 게시글 좋아요 여부 체크(ajax)
	@ResponseBody
	@RequestMapping(value = "/boardLikeSelect.do", method = RequestMethod.GET)
	public BoardVO boardLikeSelect(BoardVO vo, @ModelAttribute("bNo") int bNo, @ModelAttribute("userId") String userId) throws Exception {
		return service.boardLikeSelect(vo);
	}
	
	// 게시글 좋아요 첫 클릭(ajax)
	@ResponseBody
	@RequestMapping(value = "/boardLikeInsert.do", method = RequestMethod.GET)
	public int boardLikeInsert(BoardVO vo, @ModelAttribute("bNo") int bNo, @ModelAttribute("userId") String userId) throws Exception {
		return service.boardLikeInsert(vo);
	}
	
	// 게시글 좋아요 클릭/클릭 취소(ajax)
	@ResponseBody
	@RequestMapping(value = "/boardLikeUpdate.do", method = RequestMethod.GET)
	public int boardLikeUpdate(BoardVO vo, @ModelAttribute("bNo") int bNo, @ModelAttribute("userId") String userId, @ModelAttribute("enabled") String enabled) throws Exception {
		return service.boardLikeUpdate(vo);
	}
	
	// 게시글 좋아요 총 개수(ajax)
	@ResponseBody
	@RequestMapping(value = "/boardLikeAllSelect.do", method = RequestMethod.GET)
	public List<BoardVO> boardLikeAllSelect(BoardVO vo, @ModelAttribute("bNo") int bNo) throws Exception {
		return service.boardLikeAllSelect(vo);
	}
}
