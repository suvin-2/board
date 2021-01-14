package com.suvin.project.service;

import java.util.List;

import com.suvin.project.vo.ProjectVO;

public interface ProjectService {

	List<ProjectVO> selectProjectList() throws Exception;
}
