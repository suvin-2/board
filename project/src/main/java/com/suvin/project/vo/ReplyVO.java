package com.suvin.project.vo;

import java.util.Date;

public class ReplyVO {

	private int bNo;
	private int rNo;
	private String rContent;
	private String rWriter;
	private Date rDate;
	
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
	
	@Override
	public String toString() {
		return "ReplyVO [bNo=" + bNo + ", rNo=" + rNo + ", rContent=" + rContent + ", rWriter=" + rWriter + ", rDate="
				+ rDate + "]";
	}
	
}
