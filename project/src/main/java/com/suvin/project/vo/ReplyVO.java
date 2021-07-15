package com.suvin.project.vo;

import java.util.Date;

public class ReplyVO {

	private int bNo;
	private int rNo;
	private String title;
	private String rContent;
	private String writer;
	private String rWriter;
	private String rDate_string;
	private Date rDate;				// 등록 날짜
	private Date uDate;				// 수정 날짜
	private String sName;
	private int cnt;
	private int cNo;
	private String sDate;
	
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getrWriter() {
		return rWriter;
	}
	public void setrWriter(String rWriter) {
		this.rWriter = rWriter;
	}
	public String getrDate_string() {
		return rDate_string;
	}
	public void setrDate_string(String rDate_string) {
		this.rDate_string = rDate_string;
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
	public String getsName() {
		return sName;
	}
	public void setsName(String sName) {
		this.sName = sName;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getcNo() {
		return cNo;
	}
	public void setcNo(int cNo) {
		this.cNo = cNo;
	}
	public String getsDate() {
		return sDate;
	}
	public void setsDate(String sDate) {
		this.sDate = sDate;
	}
	@Override
	public String toString() {
		return "ReplyVO [bNo=" + bNo + ", rNo=" + rNo + ", title=" + title + ", rContent=" + rContent + ", writer="
				+ writer + ", rWriter=" + rWriter + ", rDate_string=" + rDate_string + ", rDate=" + rDate + ", uDate="
				+ uDate + ", sName=" + sName + ", cnt=" + cnt + ", cNo=" + cNo + ", sDate=" + sDate + "]";
	}
}
