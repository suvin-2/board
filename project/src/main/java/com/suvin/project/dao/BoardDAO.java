package com.suvin.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.ReplyVO;

@Repository
public class BoardDAO {
	

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
	
	// 총 글 개수(페이징 처리에 사용)
	public int listCount(Criteria cri) {
		return mybatis.selectOne("BoardDAO.listCount",cri);
	}
	
	// 게시글 카테고리 별 조회 (페이징 처리)
	public List<BoardVO> boardSearchList(Criteria cri) throws Exception {
		return mybatis.selectList("BoardDAO.boardSearchList",cri);
	}
	
	// 총 글 개수(페이징 처리에 사용)
	public int boardSearchCount(Criteria cri) {
		return mybatis.selectOne("BoardDAO.boardSearchCount",cri);
	}
	
	// 게시글 등록
	public int boardInsert(BoardVO vo) {
		return mybatis.insert("BoardDAO.boardInsert",vo);
	}
	
	// 게시글 수정
	public int boardUpdate(BoardVO vo) {
		return mybatis.update("BoardDAO.boardUpdate",vo);
	}
	
	// 게시글 삭제
	public int boardDelete(int bNo) {
		return mybatis.delete("BoardDAO.boardDelete",bNo);
	}
	
	// 게시글 단건 조회(ajax) boardUpdate.jsp 에서 사용
	public BoardVO boardSelectOne(BoardVO vo) {
		return mybatis.selectOne("BoardDAO.boardSelectOne",vo);
	}
	
	// 게시글 단건 조회
	public List<BoardVO> boardSelectDetail(BoardVO vo) throws Exception {
		return  mybatis.selectList("BoardDAO.boardSelectOne",vo);
	}
	
	// 조회수 update
	public int boardUpdateCnt(BoardVO vo) {
		return mybatis.update("BoardDAO.boardUpdateCnt",vo);
	}
	
	// 댓글 조회
	public List<ReplyVO> replySelect(Criteria cri) {
		return mybatis.selectList("BoardDAO.replySelect",cri);
	}
	
	// 댓글 등록
	public int replyInsert(ReplyVO vo) {
		return mybatis.insert("BoardDAO.replyInsert",vo);
	}
	
	// 댓글 수정
	public int replyUpdate(ReplyVO vo) {
		return mybatis.update("BoardDAO.replyUpdate",vo);
	}
	
	// 댓글 삭제
	public int replyDelete(int rNo) {
		return mybatis.update("BoardDAO.replyDelete",rNo);
	}
	
	// 게시글 별 댓글  count
	public int boardReplyCount(Criteria cri) throws Exception {
		return mybatis.selectOne("BoardDAO.boardReplyCount",cri);
	}
	
	// 게시글 좋아요 여부 조회
	public BoardVO boardLikeSelect(BoardVO vo) {
		return mybatis.selectOne("BoardDAO.boardLikeSelect",vo);
	}
	
	// 게시글 좋아요 첫 클릭
	public int boardLikeInsert(BoardVO vo) {
		return mybatis.insert("BoardDAO.boardLikeInsert",vo);
	}
	
	// 게시글 좋아요 클릭/클릭취소
	public int boardLikeUpdate(BoardVO vo) {
		return mybatis.update("BoardDAO.boardLikeUpdate",vo);
	}
	
	// 게시글 좋아요 총 개수
	public List<BoardVO> boardLikeAllSelect(BoardVO vo) {
		return mybatis.selectList("BoardDAO.boardLikeAllSelect",vo);
	}
	
}
