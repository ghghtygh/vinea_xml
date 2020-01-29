package com.vinea.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.vinea.dto.ArtiVO;

@Repository
public class ArtiDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.vinea.mapper.artiMapper";
	
	/**  페이징 전 XML 건수 반환  **/
	public int countXml(){
		
		return sqlSession.selectOne(NAMESPACE + ".countXml");
	}
		
	/** 파싱된 XML(논문) 데이터 DB에 저장  **/
	public void insertVO(ArtiVO article){
		
		sqlSession.insert(NAMESPACE+".insertXml", article);
	}
	
	/** 파싱된 XML(논문) 데이터 상세보기 **/
	public ArtiVO readVO(int arti_no){
		
		return sqlSession.selectOne(NAMESPACE+".readXml", arti_no);
	}
	
	/** 페이징 처리된 파싱된 XML(논문) 목록보기 **/
	public List<ArtiVO> selectXmlList(Map<String,Object> map){
		
		return sqlSession.selectList(NAMESPACE+".selectXmlList", map);
	}
	
	/** 파싱된 전체 XML(논문) 데이터 보기  **/
	public List<ArtiVO> selectXml(){

		return sqlSession.selectList(NAMESPACE+".selectXml");
	}
	

}
