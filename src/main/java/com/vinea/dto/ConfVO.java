package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 학회 정보_VO 객체  **/
public class ConfVO {
	
	//학회 정보 테이블 기본키
	private int conf_pk;
	//학회(컨퍼런스) 아이디
	private String conf_id;
	//논문 UID
	private String uid;
	//학회(컨퍼런스) 명
	private String conf_title;
	//학회(컨퍼런스) 일자
	private String conf_date;
	//학회(컨퍼런스) 시작일자
	private String start_date;
	//학회(컨퍼런스) 종료일자
	private String end_date;
	//학회(컨퍼런스) 장소정보_도시명
	private String city;
	//학회(컨퍼런스) 장소정보_주
	private String state;
	//학회(컨퍼런스) 장소정보_국가명
	private String country;
	//학회(컨퍼런스) 후원기관 명
	private String spon_nm;
	
	/* getter/setter 작성 */	
	public int getConf_pk() {
		return conf_pk;
	}
	public void setConf_pk(int conf_pk) {
		this.conf_pk = conf_pk;
	}
	public String getConf_id() {
		return conf_id;
	}
	public void setConf_id(String conf_id) {
		this.conf_id = conf_id;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getConf_title() {
		return conf_title;
	}
	public void setConf_title(String conf_title) {
		this.conf_title = conf_title;
	}
	public String getConf_date() {
		return conf_date;
	}
	public void setConf_date(String conf_date) {
		this.conf_date = conf_date;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getSpon_nm() {
		return spon_nm;
	}
	public void setSpon_nm(String spon_nm) {
		this.spon_nm = spon_nm;
	}
	
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}	
}
