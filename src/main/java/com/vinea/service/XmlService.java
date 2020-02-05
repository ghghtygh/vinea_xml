package com.vinea.service;

import java.util.List;
import java.util.Map;

import com.vinea.dto.ArtiVO;

public interface XmlService {

	/** 파싱된 논문 건수 반환 **/
	public int countXml() throws Exception;
	/** 요청 페이지에 따른 논문 목록 조회 **/
	public List<ArtiVO> selectXmlList(Map<String, Object> map);
	/** 파싱된 논문 데이터 DB에 저장 **/
	public void createListVO(String filePath) throws Exception;
	/** 논문 상세보기  **/
	public ArtiVO article_detail(int arti_id) throws Exception;	
	/** 논문 상세보기
	 * public ArtiVO article_detail(String arti_no) throws Exception;
	 */
	
	/** chk 동작  **/
	public List<ArtiVO> checkList(String filePath) throws Exception;
	/** 원본 데이터 파싱 테스트 **/	
	public void articleTest(String filePath) throws Exception;
	/** 논문 정보 VO 객체 DB 에 저장**/
	public void createVO(ArtiVO vo) throws Exception;
	
}
