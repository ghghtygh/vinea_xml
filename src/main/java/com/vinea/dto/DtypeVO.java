package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 문서유형정보_VO 객체  **/
public class DtypeVO {

	//문서유형정보 테이블 기본키
	private int dtype_pk;
	//논문 UID
	private String uid;
	//문서유형 명
	private String dtype_nm;

	/* getter/setter 작성 */	
	public int getDtype_pk() {
		return dtype_pk;
	}

	public void setDtype_pk(int dtype_pk) {
		this.dtype_pk = dtype_pk;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getDtype_nm() {
		return dtype_nm;
	}

	public void setDtype_nm(String dtype_nm) {
		this.dtype_nm = dtype_nm;
	}

	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

}
