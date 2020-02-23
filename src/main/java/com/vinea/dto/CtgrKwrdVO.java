package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 분야별 키워드 빈도 관련_VO 객체 **/
public class CtgrKwrdVO {
	
	//분야별 키워드 빈도 테이블 기본키
	private int kwrd_st_pk;
	//상위 분야명
	private String ctgr_nm;
	//주제명
	private String subj_nm;
	//키워드명
	private String kwrd_nm;
	//키워드 빈도수
	private int kwrd_cnt;
	//발행연도
	private String pub_year;
	
	/* getter/setter 작성 */
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
	
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}	

}
