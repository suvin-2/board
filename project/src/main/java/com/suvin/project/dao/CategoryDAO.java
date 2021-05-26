package com.suvin.project.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.suvin.project.vo.CategoryVO;

@Repository
public class CategoryDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 카테고리 조회
	public List<CategoryVO> categorySelect(CategoryVO vo) throws Exception {
		return mybatis.selectList("CategoryDAO.categorySelect",vo);
	}
	
	// 카테고리 대분류 조회(중복없이)
	public List<CategoryVO> cNameSelect(CategoryVO vo) throws Exception {
		return mybatis.selectList("CategoryDAO.cNameSelect",vo);
	}
	
	// 카테고리 대분류 중복체크
	public List<CategoryVO> cNameDuplicationSelect(CategoryVO vo) throws Exception {
		return mybatis.selectList("CategoryDAO.cNameDuplicationSelect",vo);
	}
	
	// 새로운 카테고리 등록
	public int newCategoryInsert(Map<String, Object> map) throws Exception {
		return mybatis.insert("CategoryDAO.newCategoryInsert",map);
	}
	
}
