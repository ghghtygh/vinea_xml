package com.vinea.dto;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class ArtiVO {

	private int arti_id;
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
	private String arti_cite_cnt;
	private String arti_page_cnt;
	private String arti_bp;
	private String arti_ep;
	private String arti_oa;
	
	private String arti_item_id;
	private String arti_item_avail;
	private String arti_item_type;
	private String arti_item_page;
	
	private String arti_book_page;
	private String arti_book_bind;
	private String arti_book_publ;
	private String arti_book_prepay;

	
	private String arti_ctgr_name;
	private String arti_ctgr_subh;
	private String arti_ctgr_subj;
	///
	private List<String> list_auth_full;
	///

	
	private List<OrgnVO> list_orgn;
	private List<AuthVO> list_auth;
	private List<BooknoteVO> list_booknote;
	private List<CoauthVO> list_coauth;
	private List<ConfVO> list_conf;
	private List<DtypeVO> list_dtype;
	private List<GrntVO> list_grnt;
	private List<KwrdVO> list_kwrd;
	private List<RefrVO> list_refr;
	private List<KwrdplusVO> list_kwrdplus;
	private List<PublVO> list_publ;
	
	
	//////////
	
	
	public List<String> getList_auth_full() {
		return list_auth_full;
	}




	public void setList_auth_full(List<String> list_auth_full) {
		this.list_auth_full = list_auth_full;
	}

	
	
	////////
	
	

	public int getArti_id() {
		return arti_id;
	}




	public void setArti_id(int arti_id) {
		this.arti_id = arti_id;
	}




	public String getArti_ctgr_name() {
		return arti_ctgr_name;
	}




	public void setArti_ctgr_name(String arti_ctgr_name) {
		this.arti_ctgr_name = arti_ctgr_name;
	}




	public String getArti_ctgr_subh() {
		return arti_ctgr_subh;
	}




	public void setArti_ctgr_subh(String arti_ctgr_subh) {
		this.arti_ctgr_subh = arti_ctgr_subh;
	}




	public String getArti_ctgr_subj() {
		return arti_ctgr_subj;
	}




	public void setArti_ctgr_subj(String arti_ctgr_subj) {
		this.arti_ctgr_subj = arti_ctgr_subj;
	}




	public List<PublVO> getList_publ() {
		return list_publ;
	}




	public void setList_publ(List<PublVO> list_publ) {
		this.list_publ = list_publ;
	}




	public List<OrgnVO> getList_orgn() {
		return list_orgn;
	}




	public void setList_orgn(List<OrgnVO> list_orgn) {
		this.list_orgn = list_orgn;
	}




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




	public String getArti_cite_cnt() {
		return arti_cite_cnt;
	}




	public void setArti_cite_cnt(String arti_cite_cnt) {
		this.arti_cite_cnt = arti_cite_cnt;
	}




	public String getArti_page_cnt() {
		return arti_page_cnt;
	}




	public void setArti_page_cnt(String arti_page_cnt) {
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




	public String getArti_item_id() {
		return arti_item_id;
	}




	public void setArti_item_id(String arti_item_id) {
		this.arti_item_id = arti_item_id;
	}




	public String getArti_item_avail() {
		return arti_item_avail;
	}




	public void setArti_item_avail(String arti_item_avail) {
		this.arti_item_avail = arti_item_avail;
	}




	public String getArti_item_type() {
		return arti_item_type;
	}




	public void setArti_item_type(String arti_item_type) {
		this.arti_item_type = arti_item_type;
	}




	public String getArti_item_page() {
		return arti_item_page;
	}




	public void setArti_item_page(String arti_item_page) {
		this.arti_item_page = arti_item_page;
	}




	public String getArti_book_page() {
		return arti_book_page;
	}




	public void setArti_book_page(String arti_book_page) {
		this.arti_book_page = arti_book_page;
	}




	public String getArti_book_bind() {
		return arti_book_bind;
	}




	public void setArti_book_bind(String arti_book_bind) {
		this.arti_book_bind = arti_book_bind;
	}




	public String getArti_book_publ() {
		return arti_book_publ;
	}




	public void setArti_book_publ(String arti_book_publ) {
		this.arti_book_publ = arti_book_publ;
	}




	public String getArti_book_prepay() {
		return arti_book_prepay;
	}




	public void setArti_book_prepay(String arti_book_prepay) {
		this.arti_book_prepay = arti_book_prepay;
	}




	public List<AuthVO> getList_auth() {
		return list_auth;
	}




	public void setList_auth(List<AuthVO> list_auth) {
		this.list_auth = list_auth;
	}




	public List<BooknoteVO> getList_booknote() {
		return list_booknote;
	}




	public void setList_booknote(List<BooknoteVO> list_booknote) {
		this.list_booknote = list_booknote;
	}




	public List<CoauthVO> getList_coauth() {
		return list_coauth;
	}




	public void setList_coauth(List<CoauthVO> list_coauth) {
		this.list_coauth = list_coauth;
	}




	public List<ConfVO> getList_conf() {
		return list_conf;
	}




	public void setList_conf(List<ConfVO> list_conf) {
		this.list_conf = list_conf;
	}



	public List<DtypeVO> getList_dtype() {
		return list_dtype;
	}




	public void setList_dtype(List<DtypeVO> list_dtype) {
		this.list_dtype = list_dtype;
	}




	public List<GrntVO> getList_grnt() {
		return list_grnt;
	}




	public void setList_grnt(List<GrntVO> list_grnt) {
		this.list_grnt = list_grnt;
	}




	public List<KwrdVO> getList_kwrd() {
		return list_kwrd;
	}




	public void setList_kwrd(List<KwrdVO> list_kwrd) {
		this.list_kwrd = list_kwrd;
	}




	public List<RefrVO> getList_refr() {
		return list_refr;
	}




	public void setList_refr(List<RefrVO> list_refr) {
		this.list_refr = list_refr;
	}




	public List<KwrdplusVO> getList_kwrdplus() {
		return list_kwrdplus;
	}




	public void setList_kwrdplus(List<KwrdplusVO> list_kwrdplus) {
		this.list_kwrdplus = list_kwrdplus;
	}




	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

}
