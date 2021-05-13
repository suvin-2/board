package com.suvin.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.suvin.project.security.CustomUserDetails;
import com.suvin.project.vo.UserVO;

@Repository
public class UserDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 전체 회원 조회
	public List<UserVO> userSelect(UserVO vo) throws Exception {
		return mybatis.selectList("UserDAO.userSelect",vo);
	}
	
	// 회원 가입 시 아이디 중복 체크(ajax)
	public UserVO userIdCheck(String userId) {
		return mybatis.selectOne("UserDAO.userIdCheck",userId);
	}
	
	// 회원 가입 시 이메일 중복 체크(ajax)
	public UserVO userEmailCheck(String email) {
		return mybatis.selectOne("UserDAO.userEmailCheck",email);
	}
	
	// 회원 가입 시 전화번호 중복 체크(ajax)
	public UserVO userTelCheck(String tel) {
		return mybatis.selectOne("UserDAO.userTelCheck",tel);
	}
	
	// 회원 가입
	public int userInsert(UserVO vo) {
		return mybatis.insert("UserDAO.userInsert",vo);
	}
	
	// 회원 로그인 (security)
	public UserVO userLogin(String userId) throws Exception {
		return mybatis.selectOne("UserDAO.userLogin",userId);
	}
	
	// 회원 권한 조회
	public List<String> selectUserAuth(String userId) throws Exception {
		return mybatis.selectOne("UserDAO.selectUserAuth",userId);
	}
	
	// 회원 로그인 (사용X)
	public CustomUserDetails getUserById(String userId) {
		return mybatis.selectOne("UserDAO.getUserById",userId);
	}
	
	// 회원 정보 조회
	public UserVO userInfoSelect(UserVO vo) {
		return mybatis.selectOne("UserDAO.userLogin",vo);
	}

}
