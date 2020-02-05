package com.vinea.notuseDto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 보조금 정보_VO 객체  **/
public class GrntVO {

	//보조금 정보 테이블 기본키
	private int grnt_pk;
	//논문 UID
	private String uid;
	//보조금 구분 아이디
	private String grnt_gid;
	//보조금 설명
	private String grnt_text;
	//보조금 기관
	private String grnt_agcy;
	
	/* getter/setter 작성 */	
	public int getGrnt_pk() {
		return grnt_pk;
	}
	public void setGrnt_pk(int grnt_pk) {
		this.grnt_pk = grnt_pk;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getGrnt_gid() {
		return grnt_gid;
	}
	public void setGrnt_gid(String grnt_gid) {
		this.grnt_gid = grnt_gid;
	}
	public String getGrnt_text() {
		return grnt_text;
	}
	public void setGrnt_text(String grnt_text) {
		this.grnt_text = grnt_text;
	}
	public String getGrnt_agcy() {
		return grnt_agcy;
	}
	public void setGrnt_agcy(String grnt_agcy) {
		this.grnt_agcy = grnt_agcy;
	}
	
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
}
