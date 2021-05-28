package com.suvin.project.vo;

public class Criteria {
	
	private int page;
	// perPageNum : 한 페이지 당 보여줄 게시글 수
	private int perPageNum;
	private int rowStart;
	private int rowEnd;
	
	private int cNo;
	private int bNo;
	private String cName;
	private String sName;
	private String userId;
	private String title;
	private String cnotent;
	private String keyword;
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	// 현재 페이지 번호
	public int getPage() {
		return page;
	}
	
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPageStart() {
		//현재 페이지의 게시글 시작 번호 = (현재 페이지 번호 - 1) * 페이지당 보여줄 게시글 갯수
		return (this.page - 1) * perPageNum;
	}
	
	public int getRowStart() {
		rowStart = ((page - 1) * perPageNum) + 1;
		return rowStart;
	}

	public void setRowStart(int rowStart) {
		this.rowStart = rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}
	
	public void setRowEnd(int rowEnd) {
		this.rowEnd = rowEnd;
	}

	public int getcNo() {
		return cNo;
	}

	public void setcNo(int cNo) {
		this.cNo = cNo;
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
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

	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCnotent() {
		return cnotent;
	}

	public void setCnotent(String cnotent) {
		this.cnotent = cnotent;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getKeyword(String keyword) {
		return keyword;
	}
	
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ ", cNo=" + cNo + ", bNo=" + bNo + ", cName=" + cName + ", sName=" + sName + ", userId=" + userId
				+ ", title=" + title + ", cnotent=" + cnotent + ", keyword=" + keyword + "]";
	}

}
