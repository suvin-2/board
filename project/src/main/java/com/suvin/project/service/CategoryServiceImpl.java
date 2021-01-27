package com.suvin.project.service;

import java.util.List;

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
}
