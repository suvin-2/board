package com.suvin.project.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suvin.project.service.CategoryService;
import com.suvin.project.vo.CategoryVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class CategoryController {
	
	@Resource(name = "categoryService")
	private CategoryService service;
	
	private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);

	// 카테고리(대분류) 전체 조회
	@ResponseBody
	@RequestMapping(value = "/categoryList.do")
	public List<CategoryVO> categorySelect(CategoryVO vo, Model model) throws Exception {
		
		List<CategoryVO> list = service.categorySelect(vo);
		logger.info(list.toString());
		//System.out.println("category list : " + list);
		
		return list;
	}
	
}
