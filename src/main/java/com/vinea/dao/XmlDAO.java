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
import com.vinea.dto.CoauthVO;
import com.vinea.dto.ConfVO;
import com.vinea.dto.DtypeVO;
import com.vinea.dto.GrntVO;
import com.vinea.dto.KwrdVO;
import com.vinea.dto.KwrdplusVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.PublVO;
import com.vinea.dto.RefrVO;
import com.vinea.dto.SponVO;
import com.vinea.dto.XmlFileVO;
import com.vinea.web.ArtiController;

@Repository
public class XmlDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.vinea.mapper.xmlMapper";

	Logger logger = LoggerFactory.getLogger(XmlDAO.class);
	
	/* 페이징 전 XML 건수 반환 */
	public int countXml() {

		return sqlSession.selectOne(Namespace + ".countXml");
	}

	/* ArtiVO DB 저장 */
	public void insertAVO(ArtiVO vo) {

		sqlSession.insert(Namespace + ".insertAVO", vo);
	}

	public void insertArti(ArtiVO vo) {

		sqlSession.insert(Namespace + ".insertArti", vo);
	}

	public void insertAuth(AuthVO vo) {
		sqlSession.insert(Namespace + ".insertAuth", vo);
	}

	public void insertBooknote(BooknoteVO vo) {
		sqlSession.insert(Namespace + ".insertBooknote", vo);
	}

	public void insertCoauth(CoauthVO vo) {
		sqlSession.insert(Namespace + ".insertCoauth", vo);
	}

	public void insertConf(ConfVO vo) {
		sqlSession.insert(Namespace + ".insertConf", vo);
	}

	public void insertDtype(DtypeVO vo) {
		sqlSession.insert(Namespace + ".insertDtype", vo);
	}

	public void insertGrnt(GrntVO vo) {
		sqlSession.insert(Namespace + ".insertGrnt", vo);
	}

	public void insertKwrd(KwrdVO vo) {
		sqlSession.insert(Namespace + ".insertKwrd", vo);
	}

	public void insertKwrdp(KwrdplusVO vo) {
		sqlSession.insert(Namespace + ".insertKwrdp", vo);
	}

	public void insertOrgn(OrgnVO vo) {
		sqlSession.insert(Namespace + ".insertOrgn", vo);
	}

	public void insertPubl(PublVO vo) {
		sqlSession.insert(Namespace + ".insertPubl", vo);
	}

	public void insertRefr(RefrVO vo) {
		sqlSession.insert(Namespace + ".insertRefr", vo);
	}

	public void insertSpon(SponVO vo) {
		sqlSession.insert(Namespace + ".insertSpon", vo);
	}
	/* XML FILE 추가 */
	public void insertXmlFile(XmlFileVO vo){
		
		//logger.info(vo.toStringMultiline());
		sqlSession.insert(Namespace+".insertXmlFile", vo);
	}
	
	/* 상세보기 */
	public ArtiVO selectOneXml(int arti_id){
		
		return sqlSession.selectOne(Namespace+".selectOneXml",arti_id);
	}
	
	/* 키워드 */
	public List<KwrdVO> selectKwrdList(String uid){
		
		return sqlSession.selectList(Namespace +".selectKwrdList",uid);
	}
	
	/* 참고문헌 */
	public List<RefrVO> selectRefrList(String uid){
		
		return sqlSession.selectList(Namespace +".selectRefrList",uid);
	}
	
	/* 저자 */
	public List<AuthVO> selectAuthList(String uid){
		
		return sqlSession.selectList(Namespace +".selectAuthList",uid);
	}
	
    /* 기관 */
	public List<OrgnVO> selectOrgnList(String uid){
		
		return sqlSession.selectList(Namespace +".selectOrgnList",uid);
	}
	
	/* 발행기관 */
	public List<PublVO> selectPublList(String uid){
		
		return sqlSession.selectList(Namespace +".selectPublList",uid);
	}
	
	
	/* 페이징 처리된 XML 목록 리턴 */
	public List<ArtiVO> selectXmlList(Map<String, Object> map) {

		return sqlSession.selectList(Namespace + ".selectXmlList", map);
	}
	
	

}
