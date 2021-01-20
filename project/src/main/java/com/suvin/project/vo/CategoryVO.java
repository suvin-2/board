package com.suvin.project.vo;

public class CategoryVO {
	
	private int sno;
	private String c_name;
	private String s_name;
	
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
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
	
	@Override
	public String toString() {
		return "CategoryVO [sno=" + sno + ", c_name=" + c_name + ", s_name=" + s_name + "]";
	}
}
