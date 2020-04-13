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
import com.vinea.dto.CtgryVO;
import com.vinea.dto.KwrdVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.PublVO;
import com.vinea.dto.RefrVO;


@Repository
public class ArtiDAO {

	
	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "mappers.artiMapper";

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/** 파싱된 논문 건수 반환 **/
	public int countXml(Map<String, Object> map) {
		try{
			return sqlSession.selectOne(Namespace + ".countXml", map);
		}catch(Exception e){
			return 0;
		}
	}
	
	/* 메인페이지_논문 목록 */
	/** 페이징 처리된 논문 목록 조회  **/
	public List<ArtiVO> selectXmlList(Map<String, Object> map) {

		return sqlSession.selectList(Namespace + ".selectXmlList", map);
	}
	
	/* 상세페이지*/
	/** 논문 상세보기 **/
	public ArtiVO selectOneXml(String uid){
		
		return sqlSession.selectOne(Namespace+".selectOneXml", uid);
	}
	
	/** 논문 상세보기_카테고리  **/
	public List<CtgryVO> selectCtgryList(String uid){
		
		return sqlSession.selectList(Namespace +".selectCtgryList", uid);
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
	
	
}
