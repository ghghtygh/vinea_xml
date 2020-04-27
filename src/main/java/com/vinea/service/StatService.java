package com.vinea.service;

import java.util.List;
import java.util.Map;

import com.vinea.dto.CtgrKwrdVO;
import com.vinea.dto.CtgrStatVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.YearVO;

public interface StatService {
	
	/* 파싱된 결과 통계 부분 */
	/** 분야별 키워드 빈도 수 (워드클라우드 생성) **/
	public List<CtgrKwrdVO> kwrdCloudList(Map<String, Object> map);
	
	/** 분야별 키워드 빈도 수 **/
	public List<CtgrKwrdVO> getKwrdCnt() throws Exception;
	
	/** 연도별 논문수, 도서수, 참고문헌수, 학술지수 통계 **/
	public List<YearVO> getYearCnt() throws Exception;

	/** 소속기관별 데이터 통계(기관수) **/
	public int countOrg(Map<String, Object> map) throws Exception;

	/** 소속기관별 데이터 통계(기관목록) **/
	public List<OrgnVO> selectOrgList(Map<String, Object> map) throws Exception;
	
	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 **/
	public int countCtgrStat(Map<String, Object> map);
	
	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 통계1 */
	public List<CtgrStatVO> getCtgrStatList() throws Exception;
	
	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 통계2 **/
	public List<CtgrStatVO> selectCtgrStatList(Map<String, Object> map);
	
	/** 소속기관별 데이터 통계(기관수)_수정 **/
	public int countOrg2(Map<String, Object> map) throws Exception;

	/** 소속기관별 데이터 통계(기관목록)_수정 **/
	public List<OrgnVO> selectOrgList2(Map<String, Object> map) throws Exception;

}
