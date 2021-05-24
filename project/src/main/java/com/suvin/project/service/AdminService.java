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
	
	// 신규 회원 조회
	public List<UserVO> newUserList(UserVO vo) throws Exception;

	// 좋아요 1개 이상인 글 전체 조회
	public List<BoardVO> boardLikeList(BoardVO vo) throws Exception;
	
	// 좋아요 많은 순서대로 정렬한 bNo List
	public List<BoardVO> boardLikeCntList(BoardVO vo) throws Exception;
	
	// 전체 회원 count
	public int userCount() throws Exception;
	
	// 전체 회원 조회 & 페이징
	public List<UserVO> allUserList(Criteria cri) throws Exception;
	
	// 회원 계정 비활성화
	public int userStopActivity(UserVO vo) throws Exception;
	
	// 회원 계정 활성화
	public int userResumeActivity(UserVO vo) throws Exception;
	
	// 회원 계정 비활성화 체크
	public List<UserVO> userStopActivityCheck(UserVO vo) throws Exception;
	
	// 전체 게시글 count
	public int boardCount() throws Exception;
	
	// 전체 게시글 조회 & 페이징
	public List<BoardVO> boardList(Criteria cri) throws Exception;
	
	// 게시글 삭제
	public int adminBoardDelete(int bNo);
}
