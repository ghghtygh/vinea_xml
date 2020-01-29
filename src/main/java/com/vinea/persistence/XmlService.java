package com.vinea.persistence;

import java.util.List;
import java.util.Map;

import com.vinea.dto.XmlVO;

public interface XmlService {

	
	public List<XmlVO> selectXml();

	public XmlVO createVO(String filePath) throws Exception;

	public int countXml() throws Exception;
	
	public void insertVO(XmlVO vo) throws Exception;

	public List<XmlVO> selectXmlList(Map<String, Object> map);

	public XmlVO readVO(int id);
	
	public void createListVO(String filePath) throws Exception;
	
}
