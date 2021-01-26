package com.suvin.project.vo;

public class SubCategoryVO {
	
	private int sNo;
	private String cName;
	private String sName;
	
	public int getsNo() {
		return sNo;
	}
	public void setsNo(int sNo) {
		this.sNo = sNo;
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
	@Override
	public String toString() {
		return "CategoryVO [sNo=" + sNo + ", cName=" + cName + ", sName=" + sName + "]";
	}
	
}
