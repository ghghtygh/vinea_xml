package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 파싱 정보_VO 객체  **/
public class XmlFileVO {
	
	//논문 UID
	private String uid;
	//논문내용(REC시작~REC끝)
	private String content;
	//등록일(파싱날짜)
	private String regist_date;
	//등록자
	private String registr_id;
	//파일명
	private String file_name;
	//파싱여부(완료, 미완료)
	private String parse_yn;
	//삭제여부
	private String del_yn;
	//파싱완료된 논문개수
	private int y_cnt;
	//총 논문개수
	private int all_cnt;
	
	/* getter/setter 작성 */
	public int getY_cnt() {
		return y_cnt;
	}
	public void setY_cnt(int y_cnt) {
		this.y_cnt = y_cnt;
	}
	public int getAll_cnt() {
		return all_cnt;
	}
	public void setAll_cnt(int all_cnt) {
		this.all_cnt = all_cnt;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getParse_yn() {
		return parse_yn;
	}
	public void setParse_yn(String parse_yn) {
		this.parse_yn = parse_yn;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	
	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
}