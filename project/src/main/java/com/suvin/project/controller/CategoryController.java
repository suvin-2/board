package com.suvin.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

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
	
	// 카테고리(대분류) 전체 조회
	@ResponseBody
	@RequestMapping(value = "/cNameDuplicationSelect.do")
	public List<CategoryVO> cNameDuplicationSelect(CategoryVO vo) throws Exception {
		System.out.println("넘어온 cName : "+vo);
		return service.cNameDuplicationSelect(vo);
	}
	
	// 카테고리 추가
	@ResponseBody
	@RequestMapping(value = "/newCategoryInsert", method = {RequestMethod.GET, RequestMethod.POST}, consumes = "application/json")
	public int newCategoryInsert(@RequestBody List<Map<String,String>> list) throws Exception {
				
		System.out.println("넘어온 list : "+list);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		
		return service.newCategoryInsert(map);
	}
	
	// cName 삭제
	@ResponseBody
	@RequestMapping(value = "/cNameDelete.do")
	public int cNameDelete(CategoryVO vo) throws Exception {
		return service.cNameDelete(vo);
	}
	
	// sName 삭제
	@ResponseBody
	@RequestMapping(value = "/sNameDelete.do")
	public int sNameDelete(CategoryVO vo) throws Exception {
		return service.sNameDelete(vo);
	}
	
	// 카테고리 수정
	@ResponseBody
	@RequestMapping(value = "/categoryUpdate", method = {RequestMethod.GET, RequestMethod.POST}, consumes = "application/json")
	public int categoryUpdate(@RequestBody List<Map<String,String>> list) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		
		return service.categoryUpdate(map);
	}
}
