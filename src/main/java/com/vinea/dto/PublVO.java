package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 발행기관 정보_VO 객체  **/
public class PublVO {

	//발행기관 정보 테이블 기본키
	private int publ_pk;
	//논문 UID
	private String uid;
	//발행기관 주소
	private String publ_addr;
	//발행기관 풀네임
	private String publ_full_nm;
	//발행기관 명
	private String publ_nm;
	//발행기관 주소정보_도시명
	private String city;
	//발행기관 주소정보_국가명
	private String country;
	//발행기관 주소정보_주
	private String state;
	
	/* getter/setter 작성 */	
	public int getPubl_pk() {
		return publ_pk;
	}
	public void setPubl_pk(int publ_pk) {
		this.publ_pk = publ_pk;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getPubl_addr() {
		return publ_addr;
	}
	public void setPubl_addr(String publ_addr) {
		this.publ_addr = publ_addr;
	}
	public String getPubl_full_nm() {
		return publ_full_nm;
	}
	public void setPubl_full_nm(String publ_full_nm) {
		this.publ_full_nm = publ_full_nm;
	}
	public String getPubl_nm() {
		return publ_nm;
	}
	public void setPubl_nm(String publ_nm) {
		this.publ_nm = publ_nm;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}	
		
}
