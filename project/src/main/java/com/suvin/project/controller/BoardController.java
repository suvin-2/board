package com.suvin.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.suvin.project.service.BoardService;
import com.suvin.project.service.CategoryService;
import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.CategoryVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.PageMaker;
import com.suvin.project.vo.ReplyVO;

@Controller
public class BoardController {
	
	@Resource(name = "boardService")
	private BoardService service;
	@Resource(name = "categoryService")
	private CategoryService cService;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// url mapping
	// 기본, 루트 페이지 -> home메서드 호출
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale) throws Exception {
		
		logger.info("Welcome home! The client locale is {}.", locale);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("home");
		mv.addObject("list",service.boardSelect());
		mv.addObject("pList",service.boardPopularList());
		
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
		mv.addObject("count",service.boardReplyCount(cri));
		mv.addObject("list",service.boardCategorySelect(cri));
		mv.addObject("pageMaker", pageMaker);
		
		return mv;
	}
	
	// 게시글, 댓글, 작성자 검색
	@RequestMapping(value = "/boardSearchList.do", method= {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView boardSearchList(Criteria cri, @RequestParam(defaultValue="") String keyword) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/boardSearchList");
		cri.getKeyword(keyword);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.boardSearchCount(cri));
		mv.addObject("list",service.boardSearchList(cri));
		mv.addObject("pageMaker", pageMaker);
		
		return mv;
	}
	
	// 게시판 카테고리 별 글 목록 (관리자용)
	@ResponseBody
	@RequestMapping(value = "/adminBoardSelect.do")
	public Map<String, Object> adminBoardSelect(Criteria cri, Model model) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount(cri));
		map.put("list", service.boardCategorySelect(cri));
		map.put("pageMaker", pageMaker);
		
		return map;
	}
	
	
	// 게시글 단건 조회 (detail)
	@RequestMapping(value = "/boardSelectDetail.do", method= RequestMethod.GET)
	public ModelAndView boardSelectDetail(BoardVO vo, Criteria cri, Model model) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/boardDetail");
		// 조회수 up
		service.boardUpdateCnt(vo);		
		List<BoardVO> list = service.boardSelectDetail(vo);	
		mv.addObject("list",list);
		
		// 댓글 select
		List<ReplyVO> replyList = service.replySelect(cri);
		mv.addObject("replyList",replyList);
		
		PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(cri);
        pageMaker.setTotalCount(service.boardReplyCount(cri));
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
	public String boardInsert(@ModelAttribute("boardVO") BoardVO vo) throws Exception {
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
	public String boardUpdate(@ModelAttribute("boardVO") BoardVO vo) {
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
//	
//	// 내 작성글 목록 (ajax)
//	@ResponseBody
//	@RequestMapping(value = "/writingList.do", method = RequestMethod.GET)
//	public HashMap<String, Object> writingList(Criteria cri, Model model) throws Exception {
//		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		
//		PageMaker pageMaker = new PageMaker();
//		pageMaker.setCri(cri);
//		pageMaker.setTotalCount(service.writingListCount(cri));
//		map.put("list", service.writingList(cri));
//		map.put("pageMaker", pageMaker);
//		
//		return map;
//	}
//	
//	// 내 작성 댓글 목록 (ajax)
//	@ResponseBody
//	@RequestMapping(value = "/replyList.do", method = RequestMethod.GET)
//	public HashMap<String, Object> replyList(Criteria cri, Model model) throws Exception {
//		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		
//		PageMaker pageMaker = new PageMaker();
//		pageMaker.setCri(cri);
//		pageMaker.setTotalCount(service.replyListCount(cri));
//		map.put("list", service.replyList(cri));
//		map.put("pageMaker", pageMaker);
//		
//		return map;
//	}
//	
//	// 내가 좋아요 한 글 목록 (ajax)
//	@ResponseBody
//	@RequestMapping(value = "/likeList.do", method = RequestMethod.GET)
//	public HashMap<String, Object> likeList(Criteria cri, Model model) throws Exception {
//		
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		
//		PageMaker pageMaker = new PageMaker();
//		pageMaker.setCri(cri);
//		pageMaker.setTotalCount(service.likeListCount(cri));
//		map.put("list", service.likeList(cri));
//		map.put("pageMaker", pageMaker);
//		
//		return map;
//	}
}
