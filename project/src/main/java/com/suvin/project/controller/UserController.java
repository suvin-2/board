package com.suvin.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@RequestMapping(value="/userLogin")
	public String userLogin() throws Exception {
		return "/user/userLogin";
	}
	
	
	@RequestMapping(value="/userLoginFales")
	public String userLoginFales(String error) throws Exception {
		logger.info("error : " + error);
		return "/user/userLoginFales";
	}
	
}
