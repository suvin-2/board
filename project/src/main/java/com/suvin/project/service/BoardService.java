package com.suvin.project.service;

import java.util.List;

import com.suvin.project.vo.BoardVO;

public interface BoardService {

	List<BoardVO> selectBoardList() throws Exception;
	
	void boardInsert(BoardVO vo);
}
