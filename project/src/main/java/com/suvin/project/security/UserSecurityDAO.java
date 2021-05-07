package com.suvin.project.security;

import java.util.ArrayList;

public interface UserSecurityDAO {
	
	// 데이터베이스에서 ID가 username인 User를 찾아 UserDetailDto객체형으로 반환
	public CustomUserDetails selectUser(String username);
	
	// 데이터베이스에서 ID가 username인 User의 모든 AUTHORITY를 리스트로 반환
	public ArrayList<String> getAuthList(String username);
}
