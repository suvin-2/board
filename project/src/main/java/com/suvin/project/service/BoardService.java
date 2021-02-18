package com.suvin.project.service;

import java.util.List;


import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;

public interface BoardService {

	// 게시글 전체 조회
	public List<BoardVO> boardSelect(BoardVO vo) throws Exception;
	
	// 게시글 카테고리별 조회
	//public List<BoardVO> boardCategorySelect(BoardVO vo) throws Exception;
	
	// 게시글 카테고리 별 조회 페이징 테스트
	public List<BoardVO> boardCategorySelect(Criteria cri) throws Exception;
	
	// 총 글 개수(페이징 처리에 사용)
	public int listCount(Criteria cri) throws Exception;
	
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

}
