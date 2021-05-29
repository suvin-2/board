package com.suvin.project.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;

public class CustomAuthenticationProvider implements AuthenticationProvider {
	
	@Autowired
	private UserDetailsService service;

	@SuppressWarnings("unchecked")
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		String userId = (String) authentication.getPrincipal();
        String userPw = (String) authentication.getCredentials();
        
        CustomUserDetails users = (CustomUserDetails) service.loadUserByUsername(userId);

        if(!matchPassword(userPw, users.getPassword())) {
            throw new BadCredentialsException(userId);
        }
 
        if(!users.isEnabled()) {
            throw new BadCredentialsException(userId);
        }
        
        return new UsernamePasswordAuthenticationToken(userId, userPw, users.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}

	private boolean matchPassword(String loginPwd, String userPw) {
        return loginPwd.equals(userPw);
    }
}
