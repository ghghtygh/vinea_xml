package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 저자 정보_VO 객체  **/
public class AuthVO {

	//저자 테이블 기본키
	private int auth_pk;
	//저자 아이디
	private String auth_id;
	//저자 순번
	private int auth_seq;
	//저자 주소 번호(기관 주소번호와 매칭)
	private String auth_addr_no;
	//논문 UID
	private String uid;
	//저자 명
	private String auth_nm;
	//저자 명 전체
	private String auth_full_nm;
	//저자 명 wos 표준형식
	private String auth_wos_nm;
	//저자 역할
	private String auth_role;
	//주저자 구분
	private String lead_yn;
	//교신 여부
	private String corres_yn;
	//저자 이메일 주소
	private String auth_email_addr;
	//orcid_id(과학자와 다른 학문자 구분 식별자 코드)
	private String orcid_id;
	//researcher_id(저자 연구원 아이디)
	private String auth_rid;

	/* getter/setter 작성 */	
	public int getAuth_pk() {
		return auth_pk;
	}

	public void setAuth_pk(int auth_pk) {
		this.auth_pk = auth_pk;
	}

	public String getAuth_id() {
		return auth_id;
	}

	public void setAuth_id(String auth_id) {
		this.auth_id = auth_id;
	}
	
	public String getAuth_wos_nm() {
		return auth_wos_nm;
	}

	public void setAuth_wos_nm(String auth_wos_nm) {
		this.auth_wos_nm = auth_wos_nm;
	}

	public int getAuth_seq() {
		return auth_seq;
	}

	public void setAuth_seq(int auth_seq) {
		this.auth_seq = auth_seq;
	}

	public String getAuth_addr_no() {
		return auth_addr_no;
	}

	public void setAuth_addr_no(String auth_addr_no) {
		this.auth_addr_no = auth_addr_no;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getAuth_nm() {
		return auth_nm;
	}

	public void setAuth_nm(String auth_nm) {
		this.auth_nm = auth_nm;
	}

	public String getAuth_full_nm() {
		return auth_full_nm;
	}

	public void setAuth_full_nm(String auth_full_nm) {
		this.auth_full_nm = auth_full_nm;
	}

	public String getAuth_role() {
		return auth_role;
	}

	public void setAuth_role(String auth_role) {
		this.auth_role = auth_role;
	}

	public String getLead_yn() {
		return lead_yn;
	}

	public void setLead_yn(String lead_yn) {
		this.lead_yn = lead_yn;
	}

	public String getCorres_yn() {
		return corres_yn;
	}

	public void setCorres_yn(String corres_yn) {
		this.corres_yn = corres_yn;
	}

	public String getAuth_email_addr() {
		return auth_email_addr;
	}

	public void setAuth_email_addr(String auth_email_addr) {
		this.auth_email_addr = auth_email_addr;
	}

	public String getOrcid_id() {
		return orcid_id;
	}

	public void setOrcid_id(String orcid_id) {
		this.orcid_id = orcid_id;
	}

	public String getAuth_rid() {
		return auth_rid;
	}

	public void setAuth_rid(String auth_rid) {
		this.auth_rid = auth_rid;
	}

	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
}
