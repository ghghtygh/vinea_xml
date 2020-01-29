package com.vinea.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.vinea.common.ArtiParser;
import com.vinea.common.NjhParser;
import com.vinea.dao.ArtiDAO;

import com.vinea.dto.ArtiVO;

@Service
public class ArtiServiceImpl implements ArtiService{
	
	private NjhParser parser;
	
	@Inject
	private ArtiDAO dao;
	
	/** XML(논문) 파일 경로를 가져와 파싱하여 VO 객체로 전달  **/
	@Override
	public ArtiVO createVO(String filePath) throws Exception{
		
		ArtiParser ap = new ArtiParser(filePath);
		
		return ap.returnVO();
	}
	
	
	/** 파싱된 XML(논문) 내용 상세보기 **/
	@Override
	public ArtiVO readVO(int arti_no){
		
		return dao.readVO(arti_no);
	}
	
	/** 해당 XML(논문) 개수 카운팅 **/
	@Override
	public int countXml() throws Exception{
		
		return dao.countXml();
	}
	
	/** 해당하는 페이지에 대하여 XML(논문) 목록 보기 **/
	@Override
	public List<ArtiVO> selectXmlList(Map<String,Object> map){
		
		return dao.selectXmlList(map);
	}
	
	/** 파싱된 XML(논문) 데이터 DB에 저장 **/
	@Override
	public void insertVO(ArtiVO article) throws Exception{
		
		dao.insertVO(article);
	}
	
	/** 파싱된 XML(논문)List 데이터 DB에 저장 **/
	@Override
	public void createListVO(String filePath) throws Exception{
		
		parser = new NjhParser(filePath);
		
		List<ArtiVO> list = parser.returnList();
		
		for(ArtiVO vo : list){
			dao.insertVO(vo);
		}
		
	}
	
	/** 전체 XML(논문) 목록 보기 **/
	@Override
	public List<ArtiVO> selectXml(){
		return dao.selectXml();
	}
}
