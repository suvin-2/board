package com.suvin.project.service;

import java.util.List;


import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.ReplyVO;
import com.suvin.project.vo.UserVO;

public interface AdminService {

	// 게시글 전체 조회
	public List<BoardVO> boardSelect(BoardVO vo) throws Exception;
	
	// 게시글 카테고리 별 조회 페이징 테스트
	public List<BoardVO> boardCategorySelect(Criteria cri) throws Exception;
	
	// 전체 회원 조회
	public List<UserVO> newUserList(UserVO vo) throws Exception;

	// 좋아요 1개 이상인 글 전체 조회
	public List<BoardVO> boardLikeList(BoardVO vo) throws Exception;
}
