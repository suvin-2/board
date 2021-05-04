package com.suvin.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.suvin.project.vo.UserVO;

@Repository
public class UserDAO {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 전체 회원 조회
	public List<UserVO> userSelect(UserVO vo) throws Exception {
		return mybatis.selectList("UserDAO.userSelect",vo);
	}
	
	// 회원 가입
	public int userInsert(UserVO vo) {
		return mybatis.insert("UserDAO.userInsert",vo);
	}
}
