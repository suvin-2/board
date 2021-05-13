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
	public UserVO userIdCheck(String userId) {
		return dao.userIdCheck(userId);
	}
	
	// 회원 가입 시 이메일 중복 체크(ajax)
	@Override
	public UserVO userEmailCheck(String email) {
		return dao.userEmailCheck(email);
	}

	// 회원 가입 시 전화번호 중복 체크(ajax)
	@Override
	public UserVO userTelCheck(String tel) {
		return dao.userTelCheck(tel);
	}

	// 회원 가입
	@Override
	public int userInsert(UserVO vo) {
		return dao.userInsert(vo);
	}

	// 회원 로그인 (security)
	@Override
	public UserVO userLogin(String userId) throws Exception {
		
		UserVO vo = dao.userLogin(userId);
		
		// userId의 사정자 정보가 없다면 예외를 던져줌
		if(vo == null) {
			throw new UsernameNotFoundException(userId);
		}
		return vo;
		
	}

	// 회원 정보 조회
	@Override
	public UserVO userInfoSelect(UserVO vo) {
		return dao.userInfoSelect(vo);
	}

}
