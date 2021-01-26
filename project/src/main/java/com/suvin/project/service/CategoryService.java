package com.suvin.project.service;

import java.util.List;

import com.suvin.project.vo.CategoryVO;

public interface CategoryService {

	// 카테고리(대분류) 전체 조회
	public List<CategoryVO> categorySelect(CategoryVO vo) throws Exception;
	
	// 카테고리(대분류) 전체 조회
	public List<CategoryVO> subCategorySelect(CategoryVO vo) throws Exception;
	
}
