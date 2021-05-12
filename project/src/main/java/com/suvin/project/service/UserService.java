package com.suvin.project.service;

import java.util.List;

import com.suvin.project.vo.UserVO;

public interface UserService {
	
	// 전체 회원 조회
	public List<UserVO> userSelect(UserVO vo) throws Exception;
	
	// 회원 가입 시 아이디 중복 체크(ajax)
	public UserVO userIdCheck(String userId);
	
	// 회원 가입
	public int userInsert(UserVO vo);

	// 회원 로그인
	public UserVO userLogin(String userId) throws Exception;
		
}
