package com.suvin.project.dao;

import java.util.List;

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
}
