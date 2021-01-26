package com.suvin.project.service;

import java.util.List;

import org.springframework.ui.Model;

import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.CategoryVO;

public interface BoardService {

	// 게시글 전체 조회
	public List<BoardVO> boardSelect(BoardVO vo) throws Exception;
	
	// 게시글 등록
	public int boardInsert(BoardVO vo);
		
	// 게시글 수정
	public int boardUpdate(BoardVO vo);
		
	// 게시글 삭제
	public int boardDelete(int bNo);
		
	// 게시글 단건 조회(ajax)
	public BoardVO boardSelectOne(BoardVO vo);

	// 게시글 단건 조회
	public List<BoardVO> boardSelectDetail(BoardVO vo) throws Exception;

}
