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
	public List<BoardVO> BoardCntChart(BoardVO vo) {
		return dao.BoardCntChart(vo);
	}
	@Override
	public List<ReplyVO> ReplyCntChart(ReplyVO vo) {
		return dao.ReplyCntChart(vo);
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

	@Override
	public int userCount() throws Exception {
		return dao.userCount(); 
	}
	
	@Override
	public List<UserVO> allUserList(Criteria cri) throws Exception {
		return dao.allUserList(cri);
	}

	@Override
	public int userStopActivity(UserVO vo) throws Exception {
		return dao.userStopActivity(vo);
	}
	
	@Override
	public int userResumeActivity(UserVO vo) throws Exception {
		return dao.userResumeActivity(vo);
	}

	@Override
	public List<UserVO> userStopActivityCheck(UserVO vo) throws Exception {
		return dao.userStopActivityCheck(vo);
	}

	@Override
	public int boardCount() throws Exception {
		return dao.boardCount();
	}

	@Override
	public List<BoardVO> boardList(Criteria cri) throws Exception {
		return dao.boardList(cri);
	}

	@Override
	public int adminBoardDelete(int bNo) {
		return dao.adminBoardDelete(bNo);
	}

	@Override
	public int allReplyCount() throws Exception {
		return dao.allReplyCount();
	}

	@Override
	public List<ReplyVO> allReplyList(Criteria cri) throws Exception {
		return dao.allReplyList(cri);
	}

	@Override
	public int adminReplyDelete(int rNo) {
		return dao.adminReplyDelete(rNo);
	}

	

}
