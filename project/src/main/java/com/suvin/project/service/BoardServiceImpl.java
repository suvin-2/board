package com.suvin.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.suvin.project.dao.BoardDAO;
import com.suvin.project.vo.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO dao;

	@Override
	@Transactional
	public List<BoardVO> selectBoardList() throws Exception {
		return dao.selectBoardList();
	}

	@Override
	public void boardInsert(BoardVO vo) {
		dao.boardInsert(vo);
	}
	
}
