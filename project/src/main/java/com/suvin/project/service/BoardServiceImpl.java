package com.suvin.project.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.suvin.project.dao.BoardDAO;
import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.ReplyVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO dao;

	@Override
	@Transactional
	public List<BoardVO> boardSelect(BoardVO vo) throws Exception {
		return dao.boardSelect(vo);
	}
/*
	@Override
	public List<BoardVO> boardCategorySelect(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.boardCategorySelect(vo);
	}
*/
	@Override
	public List<BoardVO> boardCategorySelect(Criteria cri) throws Exception {
		return dao.boardCategorySelect(cri);
	}
	
	@Override
	public int listCount(Criteria cri) throws Exception {
		return dao.listCount(cri); 
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

	@Override
	public List<BoardVO> boardSelectDetail(BoardVO vo) throws Exception {
		return dao.boardSelectDetail(vo);
	}

	@Override
	public int boardUpdateCnt(BoardVO vo) {
		return dao.boardUpdateCnt(vo);
	}
	
	@Override
	public List<ReplyVO> replySelect(Criteria cri) {
		return dao.replySelect(cri);
	}
	
	@Override
	public int replyInsert(ReplyVO vo) {
		return dao.replyInsert(vo);
	}
	@Override
	public int replyUpdate(ReplyVO vo) {
		return dao.replyUpdate(vo);
	}
	@Override
	public int replyDelete(int rNo) {
		return dao.replyDelete(rNo);
	}
	@Override
	public int boardReplyCount(Criteria cri) throws Exception {
		return dao.boardReplyCount(cri);
	}
	@Override
	public BoardVO boardLikeSelect(BoardVO vo) {
		return dao.boardLikeSelect(vo);
	}
	@Override
	public int boardLikeInsert(BoardVO vo) {
		return dao.boardLikeInsert(vo);
	}
	@Override
	public int boardLikeUpdate(BoardVO vo) {
		return dao.boardLikeUpdate(vo);
	}
	@Override
	public List<BoardVO> boardLikeAllSelect(BoardVO vo) {
		return dao.boardLikeAllSelect(vo);
	}


}
