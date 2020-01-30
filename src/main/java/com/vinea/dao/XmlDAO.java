package com.vinea.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
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
import com.vinea.dto.XmlVO;

@Repository
public class XmlDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.vinea.mapper.xmlMapper";

	/* 페이징 전 XML 건수 반환 */
	public int countXml() {

		return sqlSession.selectOne(Namespace + ".countXml");
	}

	/* XML DB에 저장 */
	public void insertVO(XmlVO vo) {

		sqlSession.insert(Namespace + ".insertXml", vo);
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

	/* XML 상세보기 */
	public XmlVO readVO(int id) {

		return sqlSession.selectOne(Namespace + ".readXml", id);
	}

	/* 페이징 처리된 XML 목록 리턴 */
	public List<XmlVO> selectXmlList(Map<String, Object> map) {

		return sqlSession.selectList(Namespace + ".selectXmlList", map);
	}

	/* 전체 XML 목록 리턴 */
	public List<XmlVO> selectXml() {

		return sqlSession.selectList(Namespace + ".selectXml");
	}

}
