package com.suvin.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.suvin.project.security.CustomUserDetails;
import com.suvin.project.vo.BoardVO;
import com.suvin.project.vo.Criteria;
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
	// 회원 정보 수정
	public int userUpdate(UserVO vo) {
		return mybatis.update("UserDAO.userUpdate",vo);
	}

	// 내가 작성한 게시글 목록 (페이징 처리)
	public List<BoardVO> writingList(Criteria cri) throws Exception {
		return mybatis.selectList("UserDAO.writingList",cri);
	}
	
	// 내가 작성한 게시글 개수(페이징 처리에 사용)
	public int writingListCount(Criteria cri) {
		return mybatis.selectOne("UserDAO.writingListCount",cri);
	}
		
	// 내가 작성한 댓글 목록 (페이징 처리)
	public List<BoardVO> replyList(Criteria cri) throws Exception {
		return mybatis.selectList("UserDAO.replyList",cri);
	}
	
	// 내가 작성한 댓글 개수(페이징 처리에 사용)
	public int replyListCount(Criteria cri) {
		return mybatis.selectOne("UserDAO.replyListCount",cri);
	}
	
	// 내가 좋아요 한 게시글 목록 (페이징 처리)
	public List<BoardVO> likeList(Criteria cri) throws Exception {
		return mybatis.selectList("UserDAO.likeList",cri);
	}
	
	// 내가 좋아요 한 글 개수(페이징 처리에 사용)
	public int likeListCount(Criteria cri) {
		return mybatis.selectOne("UserDAO.likeListCount",cri);
	}
}
