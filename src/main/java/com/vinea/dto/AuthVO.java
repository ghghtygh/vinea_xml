package com.vinea.dto;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class AuthVO {

	private int auth_id;
	private String auth_dais;
	private String auth_addr_no;
	private String auth_uid;
	private String auth_dply;
	private String auth_full;
	private String auth_wos;
	private String auth_first;
	private String auth_last;
	private String auth_role;
	private String auth_lead;
	private String auth_repr;
	private String auth_email;
	private int auth_seq;
	
	
	public int getAuth_id() {
		return auth_id;
	}
	public void setAuth_id(int auth_id) {
		this.auth_id = auth_id;
	}
	public String getAuth_addr_no() {
		return auth_addr_no;
	}
	public void setAuth_addr_no(String auth_addr_no) {
		this.auth_addr_no = auth_addr_no;
	}
	public String getAuth_dais() {
		return auth_dais;
	}
	public void setAuth_dais(String auth_dais) {
		this.auth_dais = auth_dais;
	}
	public String getAuth_uid() {
		return auth_uid;
	}
	public void setAuth_uid(String auth_uid) {
		this.auth_uid = auth_uid;
	}
	public String getAuth_dply() {
		return auth_dply;
	}
	public void setAuth_dply(String auth_dply) {
		this.auth_dply = auth_dply;
	}
	public String getAuth_full() {
		return auth_full;
	}
	public void setAuth_full(String auth_full) {
		this.auth_full = auth_full;
	}
	public String getAuth_wos() {
		return auth_wos;
	}
	public void setAuth_wos(String auth_wos) {
		this.auth_wos = auth_wos;
	}
	public String getAuth_first() {
		return auth_first;
	}
	public void setAuth_first(String auth_first) {
		this.auth_first = auth_first;
	}
	public String getAuth_last() {
		return auth_last;
	}
	public void setAuth_last(String auth_last) {
		this.auth_last = auth_last;
	}
	public String getAuth_role() {
		return auth_role;
	}
	public void setAuth_role(String auth_role) {
		this.auth_role = auth_role;
	}
	public String getAuth_lead() {
		return auth_lead;
	}
	public void setAuth_lead(String auth_lead) {
		this.auth_lead = auth_lead;
	}
	public String getAuth_repr() {
		return auth_repr;
	}
	public void setAuth_repr(String auth_repr) {
		this.auth_repr = auth_repr;
	}
	public String getAuth_email() {
		return auth_email;
	}
	public void setAuth_email(String auth_email) {
		this.auth_email = auth_email;
	}
	public int getAuth_seq() {
		return auth_seq;
	}
	public void setAuth_seq(int auth_seq) {
		this.auth_seq = auth_seq;
	}
	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
}
