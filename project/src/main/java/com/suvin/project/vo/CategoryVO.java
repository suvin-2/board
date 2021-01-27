package com.suvin.project.vo;

public class CategoryVO {
	

	private int cNo;
	private String cName;
	private String sName;
	
	
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
	@Override
	public String toString() {
		return "CategoryVO [cNo=" + cNo + ", cName=" + cName + ", sName=" + sName + "]";
	}
}
