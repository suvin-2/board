package com.suvin.project.security;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

// Spring Security 로그인을 위한 UserDetails VO 객체
public class CustomUserDetails implements UserDetails {
	
	// 안만들어도 상관없지만 Warning이 발생함
	private static final long serialVersionUID = 1L;

	// security에서는 ID를 'username'이라고 표현
	private String username; // userId
	private String password; // userPw
	private String auth;
	private String enabled;
	private boolean enabled_result;
	private List<GrantedAuthority> authorities;
	
	// setter
	public void setUsername(String username) {
		this.username = username;
	}

	// setter
	public void setPassword(String password) {
		this.password = password;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}
	
	// 권한
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	// id
	@Override
	public String getUsername() {
		return username;
	}

	// pw
	@Override
	public String getPassword() {
		return password;
	}
	
	public String getAuth() {
		return auth;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	@Override
	// 계정이 만료 되지 않았는가?
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	// 계정이 잠기지 않았는가?
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	// 패스워드가 만료되지 않았는가?
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	// 계정이 활성화 되었는가?
	public boolean isEnabled() {
		if(enabled.equals("1")) {
			enabled_result = true;
		} else {
			enabled_result = false;
		}
		return enabled_result;
	}


}
