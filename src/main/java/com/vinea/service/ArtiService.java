package com.vinea.service;

import java.util.List;
import java.util.Map;

import com.vinea.dto.ArtiVO;

public interface ArtiService {

	public int countXml(Map<String, Object> map) throws Exception;

	public List<ArtiVO> selectXmlList(Map<String, Object> map);

	public ArtiVO article_detail(String uid) throws Exception;

}
