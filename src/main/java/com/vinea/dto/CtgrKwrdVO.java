package com.vinea.dto;

public class CtgrKwrdVO {
	
	//키워드 통계 테이블 기본키
	private int kwrd_st_pk;
	//상위분야명
	private String ctgr_nm;
	
	private String subj_nm;
	private String kwrd_nm;
	private int kwrd_cnt;
	private String pub_year;
	public int getKwrd_st_pk() {
		return kwrd_st_pk;
	}
	public void setKwrd_st_pk(int kwrd_st_pk) {
		this.kwrd_st_pk = kwrd_st_pk;
	}
	public String getCtgr_nm() {
		return ctgr_nm;
	}
	public void setCtgr_nm(String ctgr_nm) {
		this.ctgr_nm = ctgr_nm;
	}
	public String getSubj_nm() {
		return subj_nm;
	}
	public void setSubj_nm(String subj_nm) {
		this.subj_nm = subj_nm;
	}
	public String getKwrd_nm() {
		return kwrd_nm;
	}
	public void setKwrd_nm(String kwrd_nm) {
		this.kwrd_nm = kwrd_nm;
	}
	public int getKwrd_cnt() {
		return kwrd_cnt;
	}
	public void setKwrd_cnt(int kwrd_cnt) {
		this.kwrd_cnt = kwrd_cnt;
	}
	public String getPub_year() {
		return pub_year;
	}
	public void setPub_year(String pub_year) {
		this.pub_year = pub_year;
	}
	
	

}
