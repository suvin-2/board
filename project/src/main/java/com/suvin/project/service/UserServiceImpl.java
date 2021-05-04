package com.suvin.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.suvin.project.dao.UserDAO;
import com.suvin.project.vo.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO dao;
	
	//@Autowired
	//private BCryptPasswordEncoder pwEncoder;
	
	@Override
	@Transactional
	public List<UserVO> userSelect(UserVO vo) throws Exception {
		return dao.userSelect(vo);
	}

	@Override
	public int userInsert(UserVO vo) {
		/*
		System.out.println("비밀번호 인코딩 전 : " + vo.getUserPw());
		String encodedePw = pwEncoder.encode(vo.getUserPw());
		System.out.println("비밀번호 인코딩 후 : " + encodedePw);
	
		vo.setUserPw(encodedePw);
		*/
		return dao.userInsert(vo);
	}

}
