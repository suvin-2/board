package com.suvin.project.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.suvin.project.vo.CategoryVO;

public interface CategoryService {

	// 카테고리 전체 조회
	public List<CategoryVO> categorySelect(CategoryVO vo) throws Exception;
	
	// 카테고리 대분류 조회(중복없이)
	public List<CategoryVO> cNameSelect(CategoryVO vo) throws Exception;
	
	// 카테고리 대분류 중복체크
	public List<CategoryVO> cNameDuplicationSelect(CategoryVO vo) throws Exception;
	
	// 새로운 카테고리 등록
	public int newCategoryInsert(Map<String, Object> map) throws Exception;
	
	// cName 삭제
	public int cNameDelete(CategoryVO vo) throws Exception;
	
	// sName 삭제
	public int sNameDelete(CategoryVO vo) throws Exception;
	
	// 카테고리 수정
	public int categoryUpdate(Map<String, Object> map) throws Exception;
}
