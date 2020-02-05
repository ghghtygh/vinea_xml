package com.vinea.notuseDto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 도서 기록 정보_VO 객체  **/
public class BooknoteVO {

	//도서 기록 정보 테이블 기본키
	private int book_note_pk;
	//논문 UID
	private String uid;
	//기록명(노트명)
	private String note_nm;
	
	/* getter/setter 작성 */	
	public int getBook_note_pk() {
		return book_note_pk;
	}
	public void setBook_note_pk(int book_note_pk) {
		this.book_note_pk = book_note_pk;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getNote_nm() {
		return note_nm;
	}
	public void setNote_nm(String note_nm) {
		this.note_nm = note_nm;
	}
	
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
}
