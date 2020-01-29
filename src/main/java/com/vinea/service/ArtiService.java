package com.vinea.service;

import java.util.List;
import java.util.Map;

import com.vinea.model.ArtiVO;

public interface ArtiService {
	
	public List<ArtiVO> selectXml();

	public ArtiVO createVO(String filePath) throws Exception;

	public int countXml() throws Exception;
	
	public void insertVO(ArtiVO article) throws Exception;

	public List<ArtiVO> selectXmlList(Map<String, Object> map);

	public ArtiVO readVO(int arti_no);
	

}
