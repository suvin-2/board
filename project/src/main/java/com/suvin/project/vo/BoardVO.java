package com.suvin.project.vo;

import java.util.Date;

public class BoardVO {

	private Integer bNo;
	private String title;
	private String content;
	private int cnt;
	private Date bDate;
	private String writer;
	private int cNo;
	private String cName;
	private String sName;
	
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
	public int getcNo() {
		return cNo;
	}
	public void setcNo(int cNo) {
		this.cNo = cNo;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	public String getsName() {
		return sName;
	}
	public void setsName(String sName) {
		this.sName = sName;
	}
	// 게시글 단건조회 (boardUpdate.jsp)
	public Integer getbNo(int bNo) {
		return bNo;
	}
	@Override
	public String toString() {
		return "BoardVO [bNo=" + bNo + ", title=" + title + ", content=" + content + ", cnt=" + cnt + ", bDate=" + bDate
				+ ", writer=" + writer + ", cNo=" + cNo + ", cName=" + cName + ", sName=" + sName + "]";
	}
}
