package com.vinea.notuse;

import java.util.List;
import java.util.Map;

import com.vinea.dto.ArtiVO;

public interface ArtiService {
	
	public List<ArtiVO> selectXml();

	public ArtiVO createVO(String filePath) throws Exception;

	public int countXml() throws Exception;
	
	public void insertVO(ArtiVO article) throws Exception;

	public List<ArtiVO> selectXmlList(Map<String, Object> map);

	public ArtiVO readVO(int arti_no);

	public void createListVO(String filePath) throws Exception;
	

}
