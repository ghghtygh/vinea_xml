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
import com.vinea.dto.DtypeVO;
import com.vinea.dto.GrntVO;
import com.vinea.dto.KwrdVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.PublVO;
import com.vinea.dto.RefrVO;
import com.vinea.dto.XmlFileVO;
import com.vinea.web.ArtiController;

@Repository
public class XmlDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.vinea.mapper.xmlMapper";

	Logger logger = LoggerFactory.getLogger(XmlDAO.class);
	
	/** 파싱된 논문 건수 반환 **/
	public int countXml() {

		return sqlSession.selectOne(Namespace + ".countXml");
	}

	/* ArtiVO DB 저장(사용안함)
	public void insertAVO(ArtiVO vo) {

		sqlSession.insert(Namespace + ".insertAVO", vo);
	} */

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

	/* 공저자 정보 DB 저장(사용안함)
	public void insertCoauth(CoauthVO vo) {
		sqlSession.insert(Namespace + ".insertCoauth", vo);
	}*/

	/** 학회 정보 DB 저장 **/
	public void insertConf(ConfVO vo) {
		sqlSession.insert(Namespace + ".insertConf", vo);
	}
	
	/* 후원기관 정보 DB 저장(사용안함)
	public void insertSpon(SponVO vo) {
	sqlSession.insert(Namespace + ".insertSpon", vo);
	}*/

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

	/* 간행물 키워드(키워드플러스) 정보 DB 저장(사용안함)
	public void insertKwrdp(KwrdplusVO vo) {
		sqlSession.insert(Namespace + ".insertKwrdp", vo);
	}*/

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

	/** 논문XML(API) 원본데이터  **/
	public void insertXmlFile(XmlFileVO vo){
		
		sqlSession.insert(Namespace+".insertXmlFile", vo);
	}
	
	/** 페이징 처리된 논문 목록 조회  **/
	public List<ArtiVO> selectXmlList(Map<String, Object> map) {

		return sqlSession.selectList(Namespace + ".selectXmlList", map);
	}
	
	/** 논문 상세보기
	public ArtiVO selectOneXml(int arti_id){
		
		return sqlSession.selectOne(Namespace+".selectOneXml",arti_id);
	} **/
	
	/** 논문 상세보기 **/
	public ArtiVO selectOneXml(String arti_no){
		
		return sqlSession.selectOne(Namespace+".selectOneXml",arti_no);
	}
	
	/** 논문 상세보기_키워드  **/
	public List<KwrdVO> selectKwrdList(String uid){
		
		return sqlSession.selectList(Namespace +".selectKwrdList",uid);
	}
	
	/** 논문 상세보기_참고문헌  **/
	public List<RefrVO> selectRefrList(String uid){
		
		return sqlSession.selectList(Namespace +".selectRefrList",uid);
	}
	
	/** 논문 상세보기_저자 정보  **/
	public List<AuthVO> selectAuthList(String uid){
		
		return sqlSession.selectList(Namespace +".selectAuthList",uid);
	}
	
    /** 논문 상세보기_기관 정보  **/
	public List<OrgnVO> selectOrgnList(String uid){
		
		return sqlSession.selectList(Namespace +".selectOrgnList",uid);
	}
	
	/** 논문 상세보기_발행기관  **/
	public List<PublVO> selectPublList(String uid){
		
		return sqlSession.selectList(Namespace +".selectPublList",uid);
	}
		
}
