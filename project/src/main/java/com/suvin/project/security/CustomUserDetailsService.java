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
			System.out.println("-- user details user vo : " + vo + " --");
			
			if(vo == null) {
				throw new UsernameNotFoundException(userId);
			} else {		// 사용자 정보 있을 경우 로직 전개 (userDetails에 데이터 넣기)
				System.out.println("----- Found user : "+vo);
				users.setUsername(vo.getUserId());
				users.setPassword(vo.getUserPw());
				users.setAuth(vo.getAuth());
				users.setEnabled(vo.getEnabled());
				System.out.println("-- user details user users : " + users.getUsername() + ",  "+users.getAuth());
				// 사용자 권한 select해서 받아온 List<String> 객체 주입
				//users.setAuthorities(dao.selectUserAuth(userId));
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return users;
	}

}
