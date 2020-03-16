package com.vinea.test;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;

@Document(indexName="logstash_mysql", type="orgn")
public class Orgn {
	
	@Id
	private String auth_orgn_pk;
	private String uid;
	private String orgn_full_nm;
	private String orgn_nm;
	private String orgn_pref_nm;
	private String orgn_sub_nm;
	
	public Orgn(){}
	
	public Orgn(String uid, String orgn_full_nm, String orgn_nm, String orgn_pref_nm, String orgn_sub_nm){
		
		this.uid = uid;
		this.orgn_full_nm = orgn_full_nm;
		this.orgn_nm = orgn_nm;
		this.orgn_pref_nm = orgn_pref_nm;
		this.orgn_sub_nm = orgn_sub_nm;
		
	}
	public String getAuth_orgn_pk() {
		return auth_orgn_pk;
	}

	public void setAuth_orgn_pk(String auth_orgn_pk) {
		this.auth_orgn_pk = auth_orgn_pk;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getOrgn_full_nm() {
		return orgn_full_nm;
	}

	public void setOrgn_full_nm(String orgn_full_nm) {
		this.orgn_full_nm = orgn_full_nm;
	}

	public String getOrgn_nm() {
		return orgn_nm;
	}

	public void setOrgn_nm(String orgn_nm) {
		this.orgn_nm = orgn_nm;
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

	public void setOrgn_sub_nml(String orgn_sub_nm) {
		this.orgn_sub_nm = orgn_sub_nm;
	}

	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	

}
