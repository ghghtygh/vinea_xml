package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 연구분야별 현황 관련_VO 객체  **/
public class CtgrStatVO {

	//순번
	private int num;
	//상위분야명
	private String ctgr_nm;
	//주제명
	private String subj_nm;
	//논문수
	private int arti_cnt;
	//학술지수
	private int jrnl_cnt;
	//참고문헌수
	private int refr_cnt;
	//저자수
	private int auth_cnt;

	/* getter/setter 작성 */	
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
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

	public int getArti_cnt() {
		return arti_cnt;
	}

	public void setArti_cnt(int arti_cnt) {
		this.arti_cnt = arti_cnt;
	}

	public int getJrnl_cnt() {
		return jrnl_cnt;
	}

	public void setJrnl_cnt(int jrnl_cnt) {
		this.jrnl_cnt = jrnl_cnt;
	}

	public int getRefr_cnt() {
		return refr_cnt;
	}

	public void setRefr_cnt(int refr_cnt) {
		this.refr_cnt = refr_cnt;
	}

	public int getAuth_cnt() {
		return auth_cnt;
	}

	public void setAuth_cnt(int auth_cnt) {
		this.auth_cnt = auth_cnt;
	}
	
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}	

}