package com.suvin.project.service;

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;
import com.suvin.project.vo.UserVO;

public interface UserService {
	
	// 전체 회원 조회
	public List<UserVO> userSelect(UserVO vo) throws Exception;
	
	// 회원 가입 시 아이디 중복 체크(ajax)
	public UserVO userIdCheck(String userId);
	
	// 회원 가입 시 이메일 중복 체크(ajax)
	public UserVO userEmailCheck(String string);
	
	// 회원 가입 시 전화번호 중복 체크(ajax)
	public UserVO userTelCheck(String tel);
	
	// 회원 가입 시 이메일 인증(ajax)
	public UserVO userEmailAuthNumber(@PathVariable("email") String email) throws Exception;
	
	// 회원 가입
	public int userInsert(UserVO vo);

	// 회원 로그인 (security)
	public UserVO userLogin(String userId) throws Exception;
	
	// 회원 정보 조회
	public UserVO userInfoSelect(UserVO vo);
	
	// 회원 정보 수정
	public int userUpdate(UserVO vo);

	// 내가 작성한 게시글 목록 (페이징 처리)
	public List<BoardVO> writingList(Criteria cri) throws Exception;
	
	// 내가 작성한 댓글 목록 (페이징 처리)
	public List<BoardVO> replyList(Criteria cri) throws Exception;
	
	// 내가 좋아요 한 게시글 목록 (페이징 처리)
	public List<BoardVO> likeList(Criteria cri) throws Exception;
	
	// 내가 작성한 게시글 개수(페이징 처리에 사용)
	public int writingListCount(Criteria cri);
	
	// 내가 작성한 댓글 개수(페이징 처리에 사용)
	public int replyListCount(Criteria cri);
	
	// 내가 좋아요 한 글 개수(페이징 처리에 사용)
	public int likeListCount(Criteria cri);
}
