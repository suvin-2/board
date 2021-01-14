package com.suvin.project.dao;

import java.util.List;

import com.suvin.project.vo.ProjectVO;

public interface ProjectDAO {

	List<ProjectVO> selectProjectList() throws Exception;
}
