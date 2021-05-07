package com.suvin.project.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.suvin.project.dao.UserDAO;

@Service("loginService")
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private UserDAO dao;
	
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		CustomUserDetails users = dao.getUserById(userId);
		
		if(users == null) {
			 throw new UsernameNotFoundException("username " + userId + " not found");
		}
		System.out.println(" ----- Found user ----- ");
		System.out.println("id : " + users.getUsername());
		
		return users;
	}

}
