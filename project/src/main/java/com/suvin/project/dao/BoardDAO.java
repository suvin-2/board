package com.suvin.project.dao;

import java.util.List;

import com.suvin.project.vo.BoardVO;

public interface BoardDAO {

	List<BoardVO> selectBoardList() throws Exception;
	
	void boardInsert(BoardVO vo);
}
