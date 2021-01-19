package com.suvin.project.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.suvin.project.vo.BoardVO;

@Repository
public class BoardDAO {
	

	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 게시글 전체 조회
	public List<BoardVO> boardSelect(BoardVO vo) throws Exception {
		return mybatis.selectList("BoardDAO.boardSelect",vo);
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
	
	// 게시글 단건 조회
	public BoardVO boardSelectOne(BoardVO vo) {
		return mybatis.selectOne("BoardDAO.boardSelectOne",vo);
	}
}
