package com.suvin.project.service;

import java.util.List;


import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.ReplyVO;

public interface BoardService {

	// 게시글 전체 조회
	public List<BoardVO> boardSelect() throws Exception;
	
	// 인기글 (메인화면)
	public List<BoardVO> boardPopularList() throws Exception;
		
	// 게시글 카테고리 별 조회 페이징 테스트
	public List<BoardVO> boardCategorySelect(Criteria cri) throws Exception;
	
	// 총 글 개수(페이징 처리에 사용)
	public int listCount(Criteria cri) throws Exception;
	
	// 게시글 카테고리 별 조회 (페이징 처리)
	public List<BoardVO> boardSearchList(Criteria cri) throws Exception;
	
	// 총 글 개수(페이징 처리에 사용)
	public int boardSearchCount(Criteria cri);
	
	// 게시글 등록
	public int boardInsert(BoardVO vo);
		
	// 게시글 수정
	public int boardUpdate(BoardVO vo);
		
	// 게시글 삭제
	public int boardDelete(int bNo);
		
	// 게시글 단건 조회(ajax) boardUpdate.jsp 에서 사용
	public BoardVO boardSelectOne(BoardVO vo);

	// 게시글 단건 조회
	public List<BoardVO> boardSelectDetail(BoardVO vo) throws Exception;
	
	// 게시글 조회수 증가
	public int boardUpdateCnt(BoardVO vo);
	
	// 댓글 조회
	public List<ReplyVO> replySelect(Criteria cri);
	
	// 댓글 등록
	public int replyInsert(ReplyVO vo);
	
	// 댓글 수정
	public int replyUpdate(ReplyVO vo);
	
	// 댓글 삭제
	public int replyDelete(int rNo);
	
	// 게시글 별 댓글  count
	public int boardReplyCount(Criteria cri) throws Exception;
	
	// 게시글 좋아요 여부 조회
	public BoardVO boardLikeSelect(BoardVO vo);
	
	// 게시글 좋아요 첫 클릭
	public int boardLikeInsert(BoardVO vo);
	
	// 게시글 좋아요 클릭/클릭취소
	public int boardLikeUpdate(BoardVO vo);
	
	// 게시글 좋아요 총 개수
	public List<BoardVO> boardLikeAllSelect(BoardVO vo);
	
}
