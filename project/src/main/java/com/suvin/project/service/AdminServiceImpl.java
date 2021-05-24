package com.suvin.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.suvin.project.dao.AdminDAO;
import com.suvin.project.dao.BoardDAO;
import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.ReplyVO;
import com.suvin.project.vo.UserVO;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO dao;

	@Override
	@Transactional
	public List<BoardVO> boardSelect(BoardVO vo) throws Exception {
		return dao.boardSelect(vo);
	}
	
	@Override
	public List<BoardVO> boardCategorySelect(Criteria cri) throws Exception {
		return dao.boardCategorySelect(cri);
	}

	@Override
	public List<UserVO> newUserList(UserVO vo) throws Exception {
		return dao.newUserList(vo);
	}

	@Override
	public List<BoardVO> boardLikeList(BoardVO vo) throws Exception {
		return dao.boardLikeList(vo);
	}

	@Override
	public List<BoardVO> boardLikeCntList(BoardVO vo) throws Exception {
		return dao.boardLikeCntList(vo);
	}

}
