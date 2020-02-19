package com.vinea.service;

import java.util.List;
import java.util.Map;

import com.vinea.dto.ArtiVO;
import com.vinea.dto.CtgrKwrdVO;
import com.vinea.dto.XmlFileVO;
import com.vinea.dto.YearVO;

public interface XmlService {

	/** 파싱된 논문 건수 반환 **/
	public int countXml(Map<String,Object> map) throws Exception;
	
	/** 요청 페이지에 따른 논문 목록 조회 **/
	public List<ArtiVO> selectXmlList(Map<String, Object> map);
	
	/** 파싱된 논문 데이터 DB에 저장 **/
	public void createListVO(String filePath) throws Exception;
	
	/** 논문 상세보기 **/
	public ArtiVO article_detail(String uid) throws Exception;
	
	/** chk 동작  **/
	public List<ArtiVO> checkList(String filePath) throws Exception;
	
	/** XML 파일 DB 저장 반복 **/
	public void articleTestList() throws Exception;
	
	/** XML 파일 DB 저장 **/	
	public void articleTest(String filePath) throws Exception;

	/** 논문 정보 VO 객체 DB 에 저장**/
	public void createVO(ArtiVO vo) throws Exception;
	
	/** 논문 정보 리스트 DB에 저장 **/
	public void insertVOList(List<ArtiVO> list) throws Exception;
	
	/** 파싱 현황 불러오기 **/
	public List<XmlFileVO> selectXmlFileCount() throws Exception;
	
	/** XML 파싱 완료 현황**/
	public List<XmlFileVO> selectParseYN() throws Exception;
	
	/** XML파일의 REC 태그 한개 불러오기 **/
	public XmlFileVO parseOneXml(String file_name) throws Exception;
	
	/** 해당 파일명, 태그 개수을 입력받아 여러 태그 한꺼번에 파싱 **/
	public void parseXmlList(Map<String,Object> map) throws Exception;

	/** 저장완료 반영 **/
	public void updateParse(String uid) throws Exception;

	/** 저장에러 반영 **/
	public void updateError(String uid) throws Exception;
	
	/** 키워드 빈도 **/
	public List<CtgrKwrdVO> getKwrdCnt() throws Exception;
	
	/** 연도별 논문,참고문헌,학술지,도서 수 **/
	public List<YearVO> getYearCnt() throws Exception;
}
