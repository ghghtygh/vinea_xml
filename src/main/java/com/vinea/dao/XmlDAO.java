package com.vinea.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.vinea.dto.XmlVO;

@Repository
public class XmlDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String Namespace="com.vinea.mapper.xmlMapper";
	
	
	
	/* 페이징 전 XML 건수 반환 */
	public int countXml(){
		
		return sqlSession.selectOne(Namespace+".countXml");
	}
	
	/* XML DB에 저장 */
	public void insertVO(XmlVO vo){
		
		sqlSession.insert(Namespace+".insertXml", vo);
	}
	
	/* XML 상세보기 */
	public XmlVO readVO(int id){
		
		return sqlSession.selectOne(Namespace+".readXml",id);
	}
	
	/* 페이징 처리된 XML 목록 리턴 */
	public List<XmlVO> selectXmlList(Map<String,Object> map){
		
		return sqlSession.selectList(Namespace+".selectXmlList", map);
	}
	
	/* 전체 XML 목록 리턴 */
	public List<XmlVO> selectXml(){

		return sqlSession.selectList(Namespace+".selectXml");
	}
	
}
