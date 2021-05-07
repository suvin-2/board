package com.suvin.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.suvin.project.dao.UserDAO;
import com.suvin.project.vo.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO dao;
	
	// 회원 전체 조회
	@Override
	@Transactional
	public List<UserVO> userSelect(UserVO vo) throws Exception {
		return dao.userSelect(vo);
	}

	// 회원 가입 시 아이디 중복 체크(ajax)
	@Override
	public UserVO userIdCheck(UserVO vo) {
		return dao.userIdCheck(vo);
	}

	// 회원 가입
	@Override
	public int userInsert(UserVO vo) {
		return dao.userInsert(vo);
	}

	// 회원 로그인
	@Override
	public UserVO userLogin(String userId) throws Exception {
		
		UserVO vo = dao.userLogin(userId);
		
		// userId의 사정자 정보가 없다면 예외를 던져줌
		if(vo == null) {
			throw new UsernameNotFoundException(userId);
		}
		return vo;
		
	}

}
