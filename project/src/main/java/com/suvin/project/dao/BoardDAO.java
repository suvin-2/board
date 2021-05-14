package com.suvin.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;

@Repository
public class BoardDAO {
	

	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 게시글 전체 조회
	public List<BoardVO> boardSelect(BoardVO vo) throws Exception {
		return mybatis.selectList("BoardDAO.boardSelect",vo);
	}
	/*
	// 게시글 카테고리 별 조회
	public List<BoardVO> boardCategorySelect(BoardVO vo) throws Exception {
		return mybatis.selectList("BoardDAO.boardCategorySelect",vo);
	}
	*/
	// 게시글 카테고리 별 조회 (페이징 처리)
	public List<BoardVO> boardCategorySelect(Criteria cri) throws Exception {
		return mybatis.selectList("BoardDAO.boardCategorySelect",cri);
	}
	
	// 총 글 개수(페이징 처리에 사용)
	public int listCount(Criteria cri) {
		return mybatis.selectOne("BoardDAO.listCount",cri);
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
}
