package com.suvin.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	// 로그인 화면
	@RequestMapping(value="/adminMain")
	public String userLogin() throws Exception {
		return "/admin/adminMain";
	}
}
