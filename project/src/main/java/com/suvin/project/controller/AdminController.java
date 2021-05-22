package com.suvin.project.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.suvin.project.service.AdminService;
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
	
	// 전체 회원 조회
	@RequestMapping(value="/newUserList.do")
	public List<UserVO> newUserList(UserVO vo) throws Exception {
		return service.newUserList(vo);
	}
}
