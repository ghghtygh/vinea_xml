package com.vinea.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vinea.dto.XmlFileVO;
import com.vinea.service.ParseService;

@Controller
@RequestMapping("/parsing")
public class ParseController{

	@Inject
	private ParseService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping("")
	public String parsingMapping() throws Exception{
		
		return "article/article_parse";
	}
	
	/** XML 파일명에 따라 파싱 **/
	@RequestMapping(value="/do")
	@ResponseBody
	public Boolean parsingDo(@RequestParam(defaultValue="") String file_name,
			@RequestParam(defaultValue="1")int file_cnt) throws Exception{

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("file_name",file_name);
		map.put("file_cnt", file_cnt);
		
		
		service.parseXmlList(map);
		
		return true;
	}
	
	/** 파싱 현황 불러오기 **/
	@RequestMapping(value="/check")
	@ResponseBody
	public List<XmlFileVO> xmlParsingCheck() throws Exception{
		
		return service.selectXmlFileCount();
	}
	
	/** XML 파일 파싱 페이지 **/
	@RequestMapping(value="/xml")
	public String parsingXml(){
		
		return "xml/xml_file";
	}
	
	
}
