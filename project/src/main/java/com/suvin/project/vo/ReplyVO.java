package com.suvin.project.vo;

import java.util.Date;

public class ReplyVO {

	private int bNo;
	private int rNo;
	private String rContent;
	private String rWriter;
	private Date rDate;				// 등록 날짜
	private Date uDate;				// 수정 날짜
	private String secret_check;	// 비밀댓글 체크
	
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public int getrNo() {
		return rNo;
	}
	public void setrNo(int rNo) {
		this.rNo = rNo;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public String getrWriter() {
		return rWriter;
	}
	public void setrWriter(String rWriter) {
		this.rWriter = rWriter;
	}
	public Date getrDate() {
		return rDate;
	}
	public void setrDate(Date rDate) {
		this.rDate = rDate;
	}
	public Date getuDate() {
		return uDate;
	}
	public void setuDate(Date uDate) {
		this.uDate = uDate;
	}
	public String getSecret_check() {
		return secret_check;
	}
	public void setSecret_check(String secret_check) {
		this.secret_check = secret_check;
	}
	@Override
	public String toString() {
		return "ReplyVO [bNo=" + bNo + ", rNo=" + rNo + ", rContent=" + rContent + ", rWriter=" + rWriter + ", rDate="
				+ rDate + ", uDate=" + uDate + ", secret_check=" + secret_check + "]";
	}
	
}
