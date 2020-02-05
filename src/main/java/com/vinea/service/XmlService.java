package com.vinea.service;

import java.util.List;
import java.util.Map;

import com.vinea.dto.ArtiVO;

public interface XmlService {


	public int countXml() throws Exception;

	public List<ArtiVO> selectXmlList(Map<String, Object> map);

	public void createListVO(String filePath) throws Exception;

	public ArtiVO article_detail(int arti_id) throws Exception;

	public List<ArtiVO> checkList(String filePath) throws Exception;

	public void articleTest(String filePath) throws Exception;

	public void createVO(ArtiVO vo) throws Exception;
	
}
