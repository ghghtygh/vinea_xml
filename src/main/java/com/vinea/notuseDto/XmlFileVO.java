package com.vinea.notuseDto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class XmlFileVO {
	
	private String uid;
	private String content;
	private String regist_date;
	private String regist_id;
	private String file_name;
	private String parse_yn;
	private String del_yn;
	
	
	
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
	public String getRegist_id() {
		return regist_id;
	}
	public void setRegist_id(String regist_id) {
		this.regist_id = regist_id;
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
