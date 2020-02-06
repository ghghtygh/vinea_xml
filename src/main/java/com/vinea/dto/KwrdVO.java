package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 키워드 정보_VO 객체  **/
public class KwrdVO {

	//키워드 정보 테이블 기본키
	private int kwrd_pk;
	//논문 UID
	private String uid;
	//키워드 명
	private String kwrd_nm;
	//논문키워드와 키워드플러스 구분
	private String kw_plus_yn;
	
	/* getter/setter 작성 */	
	public int getKwrd_pk() {
		return kwrd_pk;
	}
	public void setKwrd_pk(int kwrd_pk) {
		this.kwrd_pk = kwrd_pk;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getKwrd_nm() {
		return kwrd_nm;
	}
	public void setKwrd_nm(String kwrd_nm) {
		this.kwrd_nm = kwrd_nm;
	}
	public String getKw_plus_yn() {
		return kw_plus_yn;
	}
	public void setKw_plus_yn(String kw_plus_yn) {
		this.kw_plus_yn = kw_plus_yn;
	}
	
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}	
	
}
