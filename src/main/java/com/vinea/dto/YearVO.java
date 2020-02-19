package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class YearVO {
	
	private String pub_year;
	private int arti_cnt;
	private int book_cnt;
	private int jrnl_cnt;
	private int refr_cnt;
	
	public String getPub_year() {
		return pub_year;
	}
	public void setPub_year(String pub_year) {
		this.pub_year = pub_year;
	}
	public int getArti_cnt() {
		return arti_cnt;
	}
	public void setArti_cnt(int arti_cnt) {
		this.arti_cnt = arti_cnt;
	}
	public int getBook_cnt() {
		return book_cnt;
	}
	public void setBook_cnt(int book_cnt) {
		this.book_cnt = book_cnt;
	}
	public int getJrnl_cnt() {
		return jrnl_cnt;
	}
	public void setJrnl_cnt(int jrnl_cnt) {
		this.jrnl_cnt = jrnl_cnt;
	}
	public int getRefr_cnt() {
		return refr_cnt;
	}
	public void setRefr_cnt(int refr_cnt) {
		this.refr_cnt = refr_cnt;
	}
	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

}
