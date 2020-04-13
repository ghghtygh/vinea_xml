package com.vinea.service;

import java.util.List;
import java.util.Map;

import com.vinea.dto.ArtiVO;
import com.vinea.dto.XmlFileVO;

public interface ParseService {

	
	/* 파싱된 정보 DB 저장 */
	
	/** 논문 정보 VO 객체 DB 에 저장**/
	public void createVO(ArtiVO vo) throws Exception;
	
	/** 논문 정보 리스트 DB에 저장 **/
	public void insertVOList(List<ArtiVO> list) throws Exception;
	
	/*사용X*/
	public void createListVO(String filePath) throws Exception;
	
	/** XML파일의 REC 태그 한개 불러오기 **/
	public XmlFileVO parseOneXml(String file_name) throws Exception;
	
	/** 해당 파일명, 태그 개수을 입력받아 여러 태그 한꺼번에 파싱 **/
	public void parseXmlList(Map<String,Object> map) throws Exception;

	public void updateError(String uid) throws Exception;

	public List<XmlFileVO> selectXmlFileCount() throws Exception;

	public List<XmlFileVO> selectParseYN() throws Exception;

	
	
}
