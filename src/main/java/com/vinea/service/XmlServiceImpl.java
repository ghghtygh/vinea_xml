package com.vinea.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.vinea.common.ParseXml;
import com.vinea.dao.XmlDAO;
import com.vinea.dto.XmlVO;

@Service
public class XmlServiceImpl implements XmlService{
	
	@Inject
	private XmlDAO dao;
	
	/* 해당 경로의 XML파일 VO객체로 파싱 */
	@Override
	public XmlVO createVO(String filePath) throws Exception{
		
		ParseXml px = new ParseXml(filePath);
		
		return px.returnVO();
	}
	
	@Override
	public XmlVO readVO(int id){
		
		return dao.readVO(id);
	}
	
	/* XML 개수 리턴 */
	@Override
	public int countXml() throws Exception{
		
		return dao.countXml();
	}
	
	/* 요청 페이지에 따른 XML 목록 리턴*/
	@Override
	public List<XmlVO> selectXmlList(Map<String,Object> map){
	
		
		return dao.selectXmlList(map);
	}
	
	/* XML DB에 저장 */
	@Override
	public void insertVO(XmlVO vo) throws Exception{
		
		dao.insertVO(vo);
	}
	
	/* 전체 XML 목록 리턴 */
	@Override
	public List<XmlVO> selectXml(){
		return dao.selectXml();
	}
}
