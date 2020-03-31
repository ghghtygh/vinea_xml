package com.vinea.dto;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/** 논문 정보_VO 객체  **/
public class ArtiVO {

	//게시글번호
	private int num;
	//논문 UID
	private String uid;
	//논문 번호
	private String arti_no;
	//논문 제목
	private String arti_title;
	//발행 년도
	private String pub_year;
	//발행 일자
	private String pub_date;
	//권
	private String volume;
	//호
	private String issue;
	//DOI
	private String doi;
	//초록
	private String abstr;
	//국제연속간행물번호
	private String issn;
	//전자국제연속간행물번호
	private String eissn;
	//참고문헌수
	private String cite_cnt;
	//저널명(학술지명)
	private String jrnl_title;
	//부록 수
	private String sup_cnt;
	//페이지 수
	private String page_cnt;
	//시작 페이지
	private String begin_page;
	//종료 페이지
	private String end_page;
	//자료 열람 여부
	private String open_yn;
	//간행물 아이디
	private String item_id;
	//간행물 사용 여부
	private String item_avail_yn;
	//간행물 유형
	private String item_type;
	//간행물 페이지 수
	private String item_page_cnt;
	//도서 페이지 수
	private String book_page_cnt;
	//도서 제본 여부
	private String book_bind_yn;
	//도서 출판사
	private String book_publ;
	//도서 주문정보
	private String book_prepay;
	//(논문) 삭제 여부
	private String del_yn;
	//(논문) 등록 일시
	private String regist_date;
	//(논문) 등록자 아이디
	private String registr_id;
	//(논문) 수정 일시
	private String modify_date;
	//(논문) 수정자 아이디
	private String modify_id;

	//카테고리 정보 VO객체 리스트로 저장
	private List<CtgryVO> list_ctgry;
	//기관 정보 VO객체 리스트로 저장
	private List<OrgnVO> list_orgn;
	//저자 정보 VO객체 리스트로 저장
	private List<AuthVO> list_auth;
	//도서기록 정보 VO객체 리스트로 저장
	private List<BooknoteVO> list_booknote;
	//학회 정보 VO객체 리스트로 저장
	private List<ConfVO> list_conf;
	//문서유형 정보 VO객체 리스트로 저장
	private List<DtypeVO> list_dtype;
	//자금기관 정보 VO객체 리스트로 저장
	private List<GrntVO> list_grnt;
	//키워드 정보 VO객체 리스트로 저장
	private List<KwrdVO> list_kwrd;
	//참고문헌 정보 VO객체 리스트로 저장
	private List<RefrVO> list_refr;
	//발행기관 정보 VO객체 리스트로 저장
	private List<PublVO> list_publ;

	/* getter/setter 작성 */	

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}
	
	public String getOpen_yn() {
		return open_yn;
	}

	public void setOpen_yn(String open_yn) {
		this.open_yn = open_yn;
	}

	public String getArti_no() {
		return arti_no;
	}

	public void setArti_no(String arti_no) {
		this.arti_no = arti_no;
	}

	public String getArti_title() {
		return arti_title;
	}

	public void setArti_title(String arti_title) {
		this.arti_title = arti_title;
	}

	public String getPub_year() {
		return pub_year;
	}

	public void setPub_year(String pub_year) {
		this.pub_year = pub_year;
	}

	public String getPub_date() {
		return pub_date;
	}

	public void setPub_date(String pub_date) {
		this.pub_date = pub_date;
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

	public String getDoi() {
		return doi;
	}

	public void setDoi(String doi) {
		this.doi = doi;
	}

	public String getAbstr() {
		return abstr;
	}

	public void setAbstr(String abstr) {
		this.abstr = abstr;
	}

	public String getIssn() {
		return issn;
	}

	public void setIssn(String issn) {
		this.issn = issn;
	}

	public String getEissn() {
		return eissn;
	}

	public void setEissn(String eissn) {
		this.eissn = eissn;
	}

	public String getCite_cnt() {
		return cite_cnt;
	}

	public void setCite_cnt(String cite_cnt) {
		this.cite_cnt = cite_cnt;
	}

	public String getJrnl_title() {
		return jrnl_title;
	}

	public void setJrnl_title(String jrnl_title) {
		this.jrnl_title = jrnl_title;
	}

	public String getSup_cnt() {
		return sup_cnt;
	}

	public void setSup_cnt(String sup_cnt) {
		this.sup_cnt = sup_cnt;
	}

	public String getPage_cnt() {
		return page_cnt;
	}

	public void setPage_cnt(String page_cnt) {
		this.page_cnt = page_cnt;
	}

	public String getBegin_page() {
		return begin_page;
	}

	public void setBegin_page(String begin_page) {
		this.begin_page = begin_page;
	}

	public String getEnd_page() {
		return end_page;
	}

	public void setEnd_page(String end_page) {
		this.end_page = end_page;
	}

	public String getItem_id() {
		return item_id;
	}

	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}

	public String getItem_avail_yn() {
		return item_avail_yn;
	}

	public void setItem_avail_yn(String item_avail_yn) {
		this.item_avail_yn = item_avail_yn;
	}

	public String getItem_type() {
		return item_type;
	}

	public void setItem_type(String item_type) {
		this.item_type = item_type;
	}

	public String getItem_page_cnt() {
		return item_page_cnt;
	}

	public void setItem_page_cnt(String item_page_cnt) {
		this.item_page_cnt = item_page_cnt;
	}

	public String getBook_page_cnt() {
		return book_page_cnt;
	}

	public void setBook_page_cnt(String book_page_cnt) {
		this.book_page_cnt = book_page_cnt;
	}

	public String getBook_bind_yn() {
		return book_bind_yn;
	}

	public void setBook_bind_yn(String book_bind_yn) {
		this.book_bind_yn = book_bind_yn;
	}

	public String getBook_publ() {
		return book_publ;
	}

	public void setBook_publ(String book_publ) {
		this.book_publ = book_publ;
	}

	public String getBook_prepay() {
		return book_prepay;
	}

	public void setBook_prepay(String book_prepay) {
		this.book_prepay = book_prepay;
	}
	
	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}

	public String getRegistr_id() {
		return registr_id;
	}

	public void setRegistr_id(String registr_id) {
		this.registr_id = registr_id;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	
	public List<CtgryVO> getList_ctgry() {
		return list_ctgry;
	}

	public void setList_ctgry(List<CtgryVO> list_ctgry) {
		this.list_ctgry = list_ctgry;
	}

	public List<OrgnVO> getList_orgn() {
		return list_orgn;
	}

	public void setList_orgn(List<OrgnVO> list_orgn) {
		this.list_orgn = list_orgn;
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

	public List<PublVO> getList_publ() {
		return list_publ;
	}

	public void setList_publ(List<PublVO> list_publ) {
		this.list_publ = list_publ;
	}
	
	public String getRegist_date() {
		return regist_date;
	}

	public void setRegist_date(String regist_date) {
		this.regist_date = regist_date;
	}

	public String getModify_date() {
		return modify_date;
	}

	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}

	/* VO객체에 담긴 데이터들을  로그로 확인할 때 사용 */	
	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

}
