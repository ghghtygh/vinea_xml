package com.vinea.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.vinea.dto.CtgrKwrdVO;
import com.vinea.dto.CtgrStatVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.YearVO;

@Repository
public class StatDAO {
	
	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "mappers.statMapper";

	Logger logger = LoggerFactory.getLogger(this.getClass().getName());
	
	/** 분야별 키워드 빈도 수 (워드클라우드 생성) **/
	public List<CtgrKwrdVO> kwrdCloudList(Map<String,Object> map) {
		return sqlSession.selectList(Namespace + ".kwrdCloudList", map);
	}
	
	/** 분야별 키워드 빈도 수 **/
	public List<CtgrKwrdVO> getKwrdCnt() {
		return sqlSession.selectList(Namespace + ".getKwrdCnt");
	}
	
	/** 연도별 논문수, 도서수, 참고문헌수, 학술지수 통계 **/
	public List<YearVO> getYearCnt() {
		return sqlSession.selectList(Namespace + ".getYearCnt");
	}
	
	/** 소속기관별 데이터 통계(기관수) **/
	public int countOrg(Map<String,Object> map) throws Exception{
		return sqlSession.selectOne(Namespace + ".countOrg", map);
	}
	
	/** 소속기관별 데이터 통계(기관목록) **/
	public List<OrgnVO> selectOrgList(Map<String,Object> map){
		return sqlSession.selectList(Namespace + ".selectOrgList", map);
	}
	
	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 **/
	public int countCtgrStat(Map<String,Object> map){
		return sqlSession.selectOne(Namespace + ".countCtgrStat", map);
	}
	
	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 통계1 */
	public List<CtgrStatVO> getCtgrStatList() {
		return sqlSession.selectList(Namespace + ".getCtgrStatList");
	}
	
	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 통계2 **/
	public List<CtgrStatVO> selectCtgrStatList(Map<String,Object> map){
		return sqlSession.selectList(Namespace + ".selectCtgrStatList", map);
	}
		
	/** 소속기관별 데이터 통계(기관수)_수정 **/
	public int countOrg2(Map<String,Object> map) throws Exception{
		return sqlSession.selectOne(Namespace + ".countOrg2", map);
	}

	/** 소속기관별 데이터 통계(기관목록)_수정 **/
	public List<OrgnVO> selectOrgList2(Map<String,Object> map){
		return sqlSession.selectList(Namespace + ".selectOrgList2", map);
	}	
}
