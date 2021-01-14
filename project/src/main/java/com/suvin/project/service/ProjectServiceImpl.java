package com.suvin.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.suvin.project.dao.ProjectDAO;
import com.suvin.project.vo.ProjectVO;

@Service("projectService")
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	private ProjectDAO dao;

	@Override
	@Transactional
	public List<ProjectVO> selectProjectList() throws Exception {
		return dao.selectProjectList();
	}
	

}
