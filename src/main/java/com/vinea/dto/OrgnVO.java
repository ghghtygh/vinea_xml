package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 저자 연구기관정보_VO 객체  **/
public class OrgnVO {

	//저자 연구기관 테이블 기본키
	private int auth_orgn_pk;
	//논문 UID
	private String uid;
	//기관 주소
	private String orgn_addr_no;
	//기관 풀네임
	private String orgn_full_nm;
	//기관명
	private String orgn_nm;
	//세부 기관명
	private String orgn_pref_nm;
	//소속 기관명
	private String orgn_sub_nm;
	//연구기관 주소정보_도시명
	private String city;
	//연구기관 주소정보_주
	private String state;
	//연구기관 주소정보_국가명
	private String country;
	//연구기관 주소정보_도로명 주소
	private String street;
	
	// 통계 테이블
	
	// 통계테이블 순번
	private int num;
	//연구기관 논문 수
	private int arti_cnt;
	//연구기관 인용 수
	private int cite_cnt;
	// 해당 통계연도
	private String pub_year;
	
	
	/* getter/setter 작성 */	
	public int getAuth_orgn_pk() {
		return auth_orgn_pk;
	}
	
	public void setAuth_orgn_pk(int auth_orgn_pk) {
		this.auth_orgn_pk = auth_orgn_pk;
	}

	public String getUid() {
		return uid;
	}
	
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getOrgn_addr_no() {
		return orgn_addr_no;
	}
	public void setOrgn_addr_no(String orgn_addr_no) {
		this.orgn_addr_no = orgn_addr_no;
	}
	
	public String getOrgn_nm() {
		return orgn_nm;
	}

	public void setOrgn_nm(String orgn_nm) {
		this.orgn_nm = orgn_nm;
	}

	public String getOrgn_full_nm() {
		return orgn_full_nm;
	}
	public void setOrgn_full_nm(String orgn_full_nm) {
		this.orgn_full_nm = orgn_full_nm;
	}
	public String getOrgn_pref_nm() {
		return orgn_pref_nm;
	}
	public void setOrgn_pref_nm(String orgn_pref_nm) {
		this.orgn_pref_nm = orgn_pref_nm;
	}
	public String getOrgn_sub_nm() {
		return orgn_sub_nm;
	}
	public void setOrgn_sub_nm(String orgn_sub_nm) {
		this.orgn_sub_nm = orgn_sub_nm;
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
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getArti_cnt() {
		return arti_cnt;
	}

	public void setArti_cnt(int arti_cnt) {
		this.arti_cnt = arti_cnt;
	}

	public int getCite_cnt() {
		return cite_cnt;
	}

	public void setCite_cnt(int cite_cnt) {
		this.cite_cnt = cite_cnt;
	}

	public String getPub_year() {
		return pub_year;
	}

	public void setPub_year(String pub_year) {
		this.pub_year = pub_year;
	}

	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}	
	
}
