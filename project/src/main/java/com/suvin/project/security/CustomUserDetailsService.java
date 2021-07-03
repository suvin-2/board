package com.suvin.project.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.suvin.project.dao.UserDAO;
import com.suvin.project.vo.UserVO;

@Service("userLoginService")
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private UserDAO dao;
	
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		
		// 최종적으로 리턴해야할 객체
		CustomUserDetails users = new CustomUserDetails();
		
		// 사용자 정보 select
		try {
			
			UserVO vo = dao.userLogin(userId);
			
			if(vo == null) {
				throw new UsernameNotFoundException(userId+"는 없는 회원입니다.");
			} else {		// 사용자 정보 있을 경우 로직 전개 (userDetails에 데이터 넣기)
				users.setUsername(vo.getUserId());
				users.setPassword(vo.getUserPw());
				users.setAuth(vo.getAuth());
				users.setEnabled(vo.getEnabled());
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return users;
	}

}
