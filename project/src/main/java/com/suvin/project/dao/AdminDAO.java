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
	
	// 글 개수 (chart)
	public List<BoardVO> BoardCntChart(BoardVO vo) {
		return mybatis.selectList("AdminDAO.BoardCntChart",vo);
	}
	
	// 댓글 개수 (chart)
	public List<ReplyVO> ReplyCntChart(ReplyVO vo) {
		return mybatis.selectList("AdminDAO.ReplyCntChart",vo);
	}

	// 게시글 카테고리 별 조회 (페이징 처리)
	public List<BoardVO> boardCategorySelect(Criteria cri) throws Exception {
		return mybatis.selectList("BoardDAO.boardCategorySelect",cri);
	}
	
	// admin main.jsp ------------------------------------------------------
	// 신규 회원 조회
	public List<UserVO> newUserList(UserVO vo) throws Exception {
		return mybatis.selectList("AdminDAO.newUserList",vo);
	}
	
	// 좋아요 1개 이상인 글 전체 조회
	public List<BoardVO> boardLikeList(BoardVO vo) throws Exception {
		return mybatis.selectList("AdminDAO.boardLikeList",vo);
	}
	
	// 좋아요 많은 순서대로 정렬한 bNo List
	public List<BoardVO> boardLikeCntList(BoardVO vo) throws Exception {
		return mybatis.selectList("AdminDAO.boardLikeCntList",vo);
	}
	
	// admin all user.jsp ------------------------------------------------------
	// 전체 회원 count
	public int userCount() throws Exception {
		return mybatis.selectOne("AdminDAO.userCount");
	}
	
	// 전체 회원 조회 & 페이징
	public List<UserVO> allUserList(Criteria cri) throws Exception {
		return mybatis.selectList("AdminDAO.allUserList",cri);
	}
	
	// 회원 계정 비활성화
	public int userStopActivity(UserVO vo) throws Exception {
		return mybatis.update("AdminDAO.userStopActivity",vo);
	}
	
	// 회원 계정 활성화
	public int userResumeActivity(UserVO vo) throws Exception {
		return mybatis.update("AdminDAO.userResumeActivity",vo);
	}
	
	// 회원 계정 비활성화 체크
	public List<UserVO> userStopActivityCheck(UserVO vo) throws Exception {
		return mybatis.selectList("AdminDAO.userStopActivityCheck",vo);
	}
	
	// admin board.jsp ------------------------------------------------------
	// 전체 게시글 count
	public int boardCount() throws Exception {
		return mybatis.selectOne("AdminDAO.boardCount");
	}
	
	// 전체 게시글 조회 & 페이징
	public List<BoardVO> boardList(Criteria cri) throws Exception {
		return mybatis.selectList("AdminDAO.boardList",cri);
	}
	
	// 게시글 삭제
	public int adminBoardDelete(int bNo) {
		return mybatis.delete("AdminDAO.adminBoardDelete",bNo);
	}
	
	// admin reply.jsp ------------------------------------------------------
	// 전체 게시글 count
	public int allReplyCount() throws Exception {
		return mybatis.selectOne("AdminDAO.allReplyCount");
	}
	
	// 전체 게시글 조회 & 페이징
	public List<ReplyVO> allReplyList(Criteria cri) throws Exception {
		return mybatis.selectList("AdminDAO.allReplyList",cri);
	}
	
	// 게시글 삭제
	public int adminReplyDelete(int rNo) {
		return mybatis.delete("AdminDAO.adminReplyDelete",rNo);
	}
}
