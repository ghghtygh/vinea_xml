package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class ArtiVO {
	
	private int arti_no;
	private String uid;
	private String arti_title;
	private String jrnl_title;
	private String arti_auth;
	private String pub_year;
	private String pub_date;
	private String pub_type;
	private String volume;
	private String issue;
	private String arti_sup;
	private String doi;
	private String arti_ab;
	private String issn;
	private String eissn;
	private int cite_cnt;
	private int page_cnt;
	private String arti_bp;
	private String arti_ep;
	private String OA;
	
	public int getArti_no() {
		return arti_no;
	}
	public void setArti_no(int arti_no) {
		this.arti_no = arti_no;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getArti_title() {
		return arti_title;
	}
	public void setArti_title(String arti_title) {
		this.arti_title = arti_title;
	}
	public String getJrnl_title() {
		return jrnl_title;
	}
	public void setJrnl_title(String jrnl_title) {
		this.jrnl_title = jrnl_title;
	}
	public String getArti_auth() {
		return arti_auth;
	}
	public void setArti_auth(String arti_auth) {
		this.arti_auth = arti_auth;
	}
	public String getPub_year() {
		return pub_year;
	}
	public void setPub_year(String pub_year) {
		this.pub_year = pub_year;
	}
	public String getPub_date() {
		return pub_date;
	}
	public void setPub_date(String pub_date) {
		this.pub_date = pub_date;
	}
	public String getPub_type() {
		return pub_type;
	}
	public void setPub_type(String pub_type) {
		this.pub_type = pub_type;
	}
	public String getVolume() {
		return volume;
	}
	public void setVolume(String volume) {
		this.volume = volume;
	}
	public String getIssue() {
		return issue;
	}
	public void setIssue(String issue) {
		this.issue = issue;
	}
	public String getArti_sup() {
		return arti_sup;
	}
	public void setArti_sup(String arti_sup) {
		this.arti_sup = arti_sup;
	}
	public String getDoi() {
		return doi;
	}
	public void setDoi(String doi) {
		this.doi = doi;
	}
	public String getArti_ab() {
		return arti_ab;
	}
	public void setArti_ab(String arti_ab) {
		this.arti_ab = arti_ab;
	}
	public String getIssn() {
		return issn;
	}
	public void setIssn(String issn) {
		this.issn = issn;
	}
	public String getEissn() {
		return eissn;
	}
	public void setEissn(String eissn) {
		this.eissn = eissn;
	}
	public int getCite_cnt() {
		return cite_cnt;
	}
	public void setCite_cnt(int cite_cnt) {
		this.cite_cnt = cite_cnt;
	}
	public int getPage_cnt() {
		return page_cnt;
	}
	public void setPage_cnt(int page_cnt) {
		this.page_cnt = page_cnt;
	}
	public String getArti_bp() {
		return arti_bp;
	}
	public void setArti_bp(String arti_bp) {
		this.arti_bp = arti_bp;
	}
	public String getArti_ep() {
		return arti_ep;
	}
	public void setArti_ep(String arti_ep) {
		this.arti_ep = arti_ep;
	}
	public String getOA() {
		return OA;
	}
	public void setOA(String oA) {
		OA = oA;
	}
	public String toStringMultiline() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
	
}
