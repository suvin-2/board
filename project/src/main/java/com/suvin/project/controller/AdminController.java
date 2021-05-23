package com.suvin.project.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suvin.project.service.AdminService;
import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.UserVO;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Resource(name="adminService")
	private AdminService service;
	
	// admin main 화면
	@RequestMapping(value="/adminMainForm.do")
	public String userLogin() throws Exception {
		return "/admin/adminMain";
	}
	
	// 전체 회원 조회 (ajax)
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
}
