package com.suvin.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.ReplyVO;
import com.suvin.project.vo.UserVO;

@Repository
public class AdminDAO {
	

	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 게시글 전체 조회
	public List<BoardVO> boardSelect(BoardVO vo) throws Exception {
		return mybatis.selectList("BoardDAO.boardSelect",vo);
	}

	// 게시글 카테고리 별 조회 (페이징 처리)
	public List<BoardVO> boardCategorySelect(Criteria cri) throws Exception {
		return mybatis.selectList("BoardDAO.boardCategorySelect",cri);
	}
	
	// 전체 회원 조회
	public List<UserVO> newUserList(UserVO vo) throws Exception {
		return mybatis.selectList("AdminDAO.newUserList",vo);
	}
}
