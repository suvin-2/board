package com.suvin.project.vo;

import java.util.Date;

public class BoardVO {

	private Integer bNo;
	private String title;
	private String content;
	private int cnt;
	private Date bDate;
	private String writer;
	private String c_name;
	private String s_name;
	
	
	public Integer getbNo() {
		return bNo;
	}
	public void setbNo(Integer bNo) {
		this.bNo = bNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public Date getbDate() {
		return bDate;
	}
	public void setbDate(Date bDate) {
		this.bDate = bDate;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	// 게시글 단건조회
	public Integer getbNo(int bNo) {
		return bNo;
	}
	
	@Override
	public String toString() {
		return "BoardVO [bNo=" + bNo + ", title=" + title + ", content=" + content + ", cnt=" + cnt + ", bDate=" + bDate
				+ ", writer=" + writer + ", c_name=" + c_name + ", s_name=" + s_name + "]";
	}
	
}
