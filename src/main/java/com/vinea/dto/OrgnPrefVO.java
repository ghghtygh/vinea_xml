package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class OrgnPrefVO {

	private int orgn_pref_pk;
	private String uid;
	private String orgn_addr_no;
	private String orgn_pref_nm;
	
	public int getOrgn_pref_pk() {
		return orgn_pref_pk;
	}
	public void setOrgn_pref_pk(int orgn_pref_pk) {
		this.orgn_pref_pk = orgn_pref_pk;
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
	public String getOrgn_pref_nm() {
		return orgn_pref_nm;
	}
	public void setOrgn_pref_nm(String orgn_pref_nm) {
		this.orgn_pref_nm = orgn_pref_nm;
	}
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	
}
