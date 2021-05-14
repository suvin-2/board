package com.suvin.project.vo;

public class UserVO {
	
	private String userId;
	private String userPw;
	private String userName;
	private String birthday;
	private String gender;
	private String email;
	private String tel;
	private String auth;
	private int enabled;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	// 아이디 단건 조회 (회원가입 시 중복체크)
	public String getUserId(String userId) {
		return userId;
	}
	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", userPw=" + userPw + ", userName=" + userName + ", birthday=" + birthday
				+ ", gender=" + gender + ", email=" + email + ", tel=" + tel + ", auth=" + auth + ", enabled=" + enabled
				+ "]";
	}

}
