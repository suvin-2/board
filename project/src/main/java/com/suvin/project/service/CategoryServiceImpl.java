package com.suvin.project.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suvin.project.dao.CategoryDAO;
import com.suvin.project.vo.CategoryVO;

@Service("categoryService")
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDAO dao;

	@Override
	public List<CategoryVO> categorySelect(CategoryVO vo) throws Exception {
		return dao.categorySelect(vo);
	}

	@Override
	public List<CategoryVO> cNameSelect(CategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.cNameSelect(vo);
	}

	@Override
	public List<CategoryVO> cNameDuplicationSelect(CategoryVO vo) throws Exception {
		return dao.cNameDuplicationSelect(vo);
	}

	@Override
	public int newCategoryInsert(Map<String, Object> map) throws Exception {
		return dao.newCategoryInsert(map);
	}

	@Override
	public int cNameDelete(CategoryVO vo) throws Exception {
		return dao.cNameDelete(vo);
	}

	@Override
	public int sNameDelete(CategoryVO vo) throws Exception {
		return dao.sNameDelete(vo);
	}

	@Override
	public int categoryUpdate(Map<String, Object> map) throws Exception {
		return dao.categoryUpdate(map);
	}
}
