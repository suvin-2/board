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
	public List<BoardVO> boardSelect(BoardVO vo) throws Exception {
		return dao.boardSelect(vo);
	}

	@Override
	public int boardInsert(BoardVO vo) {
		return dao.boardInsert(vo);
	}

	@Override
	public int boardUpdate(BoardVO vo) {
		return dao.boardUpdate(vo);		
	}

	@Override
	public int boardDelete(int bNo) {
		return dao.boardDelete(bNo);		
	}

	@Override
	public BoardVO boardSelectOne(BoardVO vo) {
		return dao.boardSelectOne(vo);
	}
	
}
