package com.vinea.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.vinea.dao.StatDAO;
import com.vinea.dto.CtgrKwrdVO;
import com.vinea.dto.CtgrStatVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.YearVO;

@Service
public class StatServiceImpl implements StatService {

	
	
	@Inject
	private StatDAO dao;
	
	/* 파싱된 결과 통계 부분 */
	/** 분야별 키워드 빈도 수 (워드클라우드 생성) **/
	@Override
	public List<CtgrKwrdVO> kwrdCloudList(Map<String, Object> map) {
		return dao.kwrdCloudList(map);
	}

	/** 분야별 키워드 빈도 수 **/
	@Override
	public List<CtgrKwrdVO> getKwrdCnt() throws Exception {

		return dao.getKwrdCnt();
	}

	/** 연도별 논문수, 도서수, 참고문헌수, 학술지수 통계 **/
	@Override
	public List<YearVO> getYearCnt() throws Exception {

		return dao.getYearCnt();
	}

	/** 소속기관별 데이터 통계(기관수) **/
	@Override
	public int countOrg(Map<String, Object> map) throws Exception {
		return dao.countOrg(map);
	}

	/** 소속기관별 데이터 통계(기관목록) **/
	@Override
	public List<OrgnVO> selectOrgList(Map<String, Object> map) throws Exception {
		return dao.selectOrgList(map);
	}

	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 **/
	@Override
	public int countCtgrStat(Map<String, Object> map) {
		return dao.countCtgrStat(map);
	}

	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 통계1 */
	@Override
	public List<CtgrStatVO> getCtgrStatList() throws Exception {
		return dao.getCtgrStatList();
	}

	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 통계2 **/
	@Override
	public List<CtgrStatVO> selectCtgrStatList(Map<String, Object> map) {
		return dao.selectCtgrStatList(map);
	}
	
	
	


	/** 소속기관별 데이터 통계(기관수)_수정 **/
	@Override
	public int countOrg2(Map<String, Object> map) throws Exception {
		return dao.countOrg2(map);
	}

	/** 소속기관별 데이터 통계(기관목록)_수정 **/
	@Override
	public List<OrgnVO> selectOrgList2(Map<String, Object> map) throws Exception {
		return dao.selectOrgList2(map);
	}

}
