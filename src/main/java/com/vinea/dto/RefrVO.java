package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 참고문헌 정보_VO 객체  **/
public class RefrVO {
	
	//참고문헌 테이블 기본키_참고문헌 아이디
	private int refr_id;
	//참고문헌 UID
	private String refr_uid;
	//논문 UID
	private String uid;
	//참고문헌 저자
	private String author;
	//발행연도
	private String pub_year;
	//권
	private String volume;
	//호
	private String issue;
	//참고문헌(논문) 제목
	private String arti_title;
	//DOI
	private String doi;
	//참고(인용) 페이지
	private String page;
	//연구기관명
	//private String orgn_nm;
	//저널명(학술지명)
	private String jrnl_title;
	//(참고문헌) 삭제 여부
	private String del_yn;
	//(참고문헌) 등록 일시
	private String regist_date;
	//(참고문헌) 등록자 아이디
	private String registr_id;
	//(참고문헌) 수정 일시
	private String modify_date;
	//(참고문헌) 수정자 아이디
	private String modify_id;
	
	/* getter/setter 작성 */
	public int getRefr_id() {
		return refr_id;
	}
	public void setRefr_id(int refr_id) {
		this.refr_id = refr_id;
	}
	public String getRefr_uid() {
		return refr_uid;
	}
	public void setRefr_uid(String refr_uid) {
		this.refr_uid = refr_uid;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPub_year() {
		return pub_year;
	}
	public void setPub_year(String pub_year) {
		this.pub_year = pub_year;
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
	public String getArti_title() {
		return arti_title;
	}
	public void setArti_title(String arti_title) {
		this.arti_title = arti_title;
	}
	public String getDoi() {
		return doi;
	}
	public void setDoi(String doi) {
		this.doi = doi;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}	
	/*public String getOrgn_nm() {
		return orgn_nm;
	}
	public void setOrgn_nm(String orgn_nm) {
		this.orgn_nm = orgn_nm;
	}*/
	public String getJrnl_title() {
		return jrnl_title;
	}
	public void setJrnl_title(String jrnl_title) {
		this.jrnl_title = jrnl_title;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getRegist_date() {
		return regist_date;
	}
	public void setRegist_date(String regist_date) {
		this.regist_date = regist_date;
	}
	public String getRegistr_id() {
		return registr_id;
	}
	public void setRegistr_id(String registr_id) {
		this.registr_id = registr_id;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}	
	
}
