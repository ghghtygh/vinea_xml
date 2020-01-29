package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class ArtiVO {

	private String arti_no;
	private String arti_uid;
	private String arti_title;
	private String arti_source_title;
	private String arti_year;
	private String arti_date;
	private String arti_vol;
	private String arti_issue;
	private String arti_sup;
	private String arti_doi;
	private String arti_ab;
	private String arti_issn;
	private String arti_eissn;
	private int arti_cite_cnt;
	private int arti_page_cnt;
	private String arti_bp;
	private String arti_ep;
	private String arti_oa;

	public String getArti_no() {
		return arti_no;
	}

	public void setArti_no(String arti_no) {
		this.arti_no = arti_no;
	}

	
	public String getArti_uid() {
		return arti_uid;
	}

	public void setArti_uid(String arti_uid) {
		this.arti_uid = arti_uid;
	}

	public String getArti_title() {
		return arti_title;
	}

	public void setArti_title(String arti_title) {
		this.arti_title = arti_title;
	}

	public String getArti_source_title() {
		return arti_source_title;
	}

	public void setArti_source_title(String arti_source_title) {
		this.arti_source_title = arti_source_title;
	}

	public String getArti_year() {
		return arti_year;
	}

	public void setArti_year(String arti_year) {
		this.arti_year = arti_year;
	}

	public String getArti_date() {
		return arti_date;
	}

	public void setArti_date(String arti_date) {
		this.arti_date = arti_date;
	}

	public String getArti_vol() {
		return arti_vol;
	}

	public void setArti_vol(String arti_vol) {
		this.arti_vol = arti_vol;
	}

	public String getArti_issue() {
		return arti_issue;
	}

	public void setArti_issue(String arti_issue) {
		this.arti_issue = arti_issue;
	}

	public String getArti_sup() {
		return arti_sup;
	}

	public void setArti_sup(String arti_sup) {
		this.arti_sup = arti_sup;
	}

	public String getArti_doi() {
		return arti_doi;
	}

	public void setArti_doi(String arti_doi) {
		this.arti_doi = arti_doi;
	}

	public String getArti_ab() {
		return arti_ab;
	}

	public void setArti_ab(String arti_ab) {
		this.arti_ab = arti_ab;
	}

	public String getArti_issn() {
		return arti_issn;
	}

	public void setArti_issn(String arti_issn) {
		this.arti_issn = arti_issn;
	}

	public String getArti_eissn() {
		return arti_eissn;
	}

	public void setArti_eissn(String arti_eissn) {
		this.arti_eissn = arti_eissn;
	}

	public int getArti_cite_cnt() {
		return arti_cite_cnt;
	}

	public void setArti_cite_cnt(int arti_cite_cnt) {
		this.arti_cite_cnt = arti_cite_cnt;
	}

	public int getArti_page_cnt() {
		return arti_page_cnt;
	}

	public void setArti_page_cnt(int arti_page_cnt) {
		this.arti_page_cnt = arti_page_cnt;
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

	public String getArti_oa() {
		return arti_oa;
	}

	public void setArti_oa(String arti_oa) {
		this.arti_oa = arti_oa;
	}

	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

}
