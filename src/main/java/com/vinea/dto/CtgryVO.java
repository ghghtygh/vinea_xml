package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class CtgryVO {

	private int ctgry_pk;
	private String uid;
	private String ctgry_nm;
	private String ctgry_sub_title;
	private String ctgry_subject;
	
	public int getCtgry_pk() {
		return ctgry_pk;
	}
	public void setCtgry_pk(int ctgry_pk) {
		this.ctgry_pk = ctgry_pk;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getCtgry_nm() {
		return ctgry_nm;
	}
	public void setCtgry_nm(String ctgry_nm) {
		this.ctgry_nm = ctgry_nm;
	}
	public String getCtgry_sub_title() {
		return ctgry_sub_title;
	}
	public void setCtgry_sub_title(String ctgry_sub_title) {
		this.ctgry_sub_title = ctgry_sub_title;
	}
	public String getCtgry_subject() {
		return ctgry_subject;
	}
	public void setCtgry_subject(String ctgry_subject) {
		this.ctgry_subject = ctgry_subject;
	}
	
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

}
