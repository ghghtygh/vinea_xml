package com.vinea.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.vinea.dto.ArtiVO;
import com.vinea.dto.AuthVO;
import com.vinea.dto.BooknoteVO;
import com.vinea.dto.ConfVO;
import com.vinea.dto.CtgrKwrdVO;
import com.vinea.dto.DtypeVO;
import com.vinea.dto.GrntVO;
import com.vinea.dto.KwrdVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.PublVO;
import com.vinea.dto.RefrVO;
import com.vinea.dto.XmlFileVO;
import com.vinea.dto.YearVO;
import com.vinea.web.ArtiController;

@Repository
public class XmlDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.vinea.mapper.xmlMapper";

	Logger logger = LoggerFactory.getLogger(XmlDAO.class);
	
	/** 파싱된 논문 건수 반환 **/
	public int countXml(Map<String, Object> map) {

		return sqlSession.selectOne(Namespace + ".countXml", map);
	}

	/** 논문 정보 DB 저장 **/
	public void insertArti(ArtiVO vo) {

		sqlSession.insert(Namespace + ".insertArti", vo);
	}

	/** 저자 정보 DB 저장 **/
	public void insertAuth(AuthVO vo) {
		sqlSession.insert(Namespace + ".insertAuth", vo);
	}
	
	/** 도서기록 정보 DB 저장 **/
	public void insertBooknote(BooknoteVO vo) {
		sqlSession.insert(Namespace + ".insertBooknote", vo);
	}

	/** 학회 정보 DB 저장 **/
	public void insertConf(ConfVO vo) {
		sqlSession.insert(Namespace + ".insertConf", vo);
	}
	

	/** 문서유형 정보 DB 저장 **/
	public void insertDtype(DtypeVO vo) {
		sqlSession.insert(Namespace + ".insertDtype", vo);
	}

	/** 보조금 정보 DB 저장 **/
	public void insertGrnt(GrntVO vo) {
		sqlSession.insert(Namespace + ".insertGrnt", vo);
	}

	/** 키워드 정보 DB 저장 **/
	public void insertKwrd(KwrdVO vo) {
		sqlSession.insert(Namespace + ".insertKwrd", vo);
	}

	/** 저자 연구기관 정보 DB 저장 **/
	public void insertOrgn(OrgnVO vo) {
		sqlSession.insert(Namespace + ".insertOrgn", vo);
	}

	/** 발행기관 정보 DB 저장 **/
	public void insertPubl(PublVO vo) {
		sqlSession.insert(Namespace + ".insertPubl", vo);
	}

	/** 참고문헌 정보 DB 저장 **/
	public void insertRefr(RefrVO vo) {
		sqlSession.insert(Namespace + ".insertRefr", vo);
	}

	/** 논문XML(API) 원본데이터 DB 저장 **/
	public void insertXmlFile(XmlFileVO vo){
		
		sqlSession.insert(Namespace+".insertXmlFile", vo);
	}
	
	
	/** 논문 정보리스트 DB 저장 **/
	public void insertArtiList(List<ArtiVO> list){
		if(list.isEmpty())
			return;
		sqlSession.insert(Namespace+".insertArtiList", list);
	}
	/** 저자 정보리스트 DB 저장 **/
	public void insertAuthList(List<AuthVO> list){
		if(list.isEmpty())
			return;
		sqlSession.insert(Namespace+".insertAuthList", list);
	}
	/** 북노트 정보리스트 DB 저장 **/
	public void insertBooknoteList(List<BooknoteVO> list){
		if(list.isEmpty())
			return;
		sqlSession.insert(Namespace+".insertBooknoteList", list);
	}
	/** 학회 정보리스트 DB 저장 **/
	public void insertConfList(List<ConfVO> list){
		if(list.isEmpty())
			return;
		sqlSession.insert(Namespace+".insertConfList", list);
	}
	/** 문서유형 정보리스트 DB 저장 **/
	public void insertDtypeList(List<DtypeVO> list){
		if(list.isEmpty())
			return;
		sqlSession.insert(Namespace+".insertDtypeList", list);
	}
	/** 보조금 정보리스트 DB 저장 **/
	public void insertGrntList(List<GrntVO> list){
		if(list.isEmpty())
			return;
		sqlSession.insert(Namespace+".insertGrntList", list);
	}
	/** 키워드 정보리스트 DB 저장 **/
	public void insertKwrdList(List<KwrdVO> list){
		if(list.isEmpty())
			return;
		sqlSession.insert(Namespace+".insertKwrdList", list);
	}
	/** 저자 연구기관 정보리스트 DB 저장 **/
	public void insertOrgnList(List<OrgnVO> list){
		if(list.isEmpty())
			return;
		sqlSession.insert(Namespace+".insertOrgnList", list);
	}
	/** 발행기관 정보리스트 DB 저장 **/
	public void insertPublList(List<PublVO> list){
		if(list.isEmpty())
			return;
		sqlSession.insert(Namespace+".insertPublList", list);
	}
	/** 참고문헌 정보리스트 DB 저장 **/
	public void insertRefrList(List<RefrVO> list){
		if(list.isEmpty())
			return;
		sqlSession.insert(Namespace+".insertRefrList", list);
	}
	
	
	
	
	
	
	/** 페이징 처리된 논문 목록 조회  **/
	public List<ArtiVO> selectXmlList(Map<String, Object> map) {

		return sqlSession.selectList(Namespace + ".selectXmlList", map);
	}
	
	
	/** 논문 상세보기 **/
	public ArtiVO selectOneXml(String uid){
		
		return sqlSession.selectOne(Namespace+".selectOneXml", uid);
	}
	
	/** 논문 상세보기_키워드  **/
	public List<KwrdVO> selectKwrdList(String uid){
		
		return sqlSession.selectList(Namespace +".selectKwrdList", uid);
	}
	
	/** 논문 상세보기_참고문헌  **/
	public List<RefrVO> selectRefrList(String uid){
		
		return sqlSession.selectList(Namespace +".selectRefrList", uid);
	}
	
	/** 논문 상세보기_저자 정보  **/
	public List<AuthVO> selectAuthList(String uid){
		
		return sqlSession.selectList(Namespace +".selectAuthList", uid);
	}
	
    /** 논문 상세보기_기관 정보  **/
	public List<OrgnVO> selectOrgnList(String uid){
		
		return sqlSession.selectList(Namespace +".selectOrgnList", uid);
	}
	
	/** 논문 상세보기_발행기관  **/
	public List<PublVO> selectPublList(String uid){
		
		return sqlSession.selectList(Namespace +".selectPublList", uid);
	}
	
	/** XML 파일명에 따른 REC태그 **/
	public XmlFileVO selectOneXmlFile(String file_name){
		
		return sqlSession.selectOne(Namespace +".selectOneXmlFile", file_name);
	}
	
	/** XML 파일명에 따른 REC태그 리스트**/
	public List<XmlFileVO> selectXmlFileList(Map<String,Object> map){
		
		return sqlSession.selectList(Namespace +".selectXmlFileList", map);
	}
	
	/** 파일명과 REC태그 개수 **/
	public List<XmlFileVO> selectXmlFileCount(){
		
		return sqlSession.selectList(Namespace +".selectXmlFileCount");
	}
	
	/**  XML 파싱 완료 현황 **/
	public List<XmlFileVO> selectParseYN(){
		
		return sqlSession.selectList(Namespace +".selectParseYN");
	}
	
	
	/** XML 파일 파싱완료 표기 **/
	public void updateParseYN(String uid){
		
		sqlSession.update(Namespace+".updateParseYN", uid);
	}
	
	/** XML 파일 에러 표기 **/
	public void updateErrorYN(String uid){
		
		sqlSession.update(Namespace+".updateErrorYN", uid);
	}
	
	/** 키워드 빈도 수 **/
	public List<CtgrKwrdVO> getKwrdCnt() {
		return sqlSession.selectList(Namespace + ".getKwrdCnt");
	}
	
	public List<YearVO> getYearCnt() {
		return sqlSession.selectList(Namespace + ".getYearCnt");
	}
		
		
}
