package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class XmlFileVO {
	
	private String uid;
	private String content;
	private String regist_date;
	private String registr_id;
	private String file_name;
	private String parse_yn;
	private String del_yn;
	private int y_cnt;
	private int all_cnt;
	
	
	public int getY_cnt() {
		return y_cnt;
	}
	public void setY_cnt(int y_cnt) {
		this.y_cnt = y_cnt;
	}
	public int getAll_cnt() {
		return all_cnt;
	}
	public void setAll_cnt(int all_cnt) {
		this.all_cnt = all_cnt;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegist_date() {
		return regist_date;
	}
	public void setRegist_date(String regist_date) {
		this.regist_date = regist_date;
	}
	public String getRegistr_id() {
		return registr_id;
	}
	public void setRegistr_id(String registr_id) {
		this.registr_id = registr_id;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getParse_yn() {
		return parse_yn;
	}
	public void setParse_yn(String parse_yn) {
		this.parse_yn = parse_yn;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	
	
}
