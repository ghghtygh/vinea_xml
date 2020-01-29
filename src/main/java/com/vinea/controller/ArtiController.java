package com.vinea.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vinea.dto.ArtiVO;
import com.vinea.service.ArtiService;
import com.vinea.service.PostPager;

@Controller
public class ArtiController {
	
	@Inject
	private ArtiService service;

	/** 메인화면으로 이동 **/
	@RequestMapping(value = "/article")
	public String xmlList(@RequestParam(defaultValue = "1") int page, Model model) throws Exception
	{
		int xmlCount = service.countXml();
		int pageSize = 7;
		int startIndex = -1;
		
		PostPager pager = new PostPager(xmlCount, page, pageSize);

		startIndex = pager.getStartIndex();

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("startIndex", startIndex);
		map.put("pageSize", pageSize);

		List<ArtiVO> xmlList = service.selectXmlList(map);

		model.addAttribute("xmlList", xmlList);
		model.addAttribute("pager", pager);
		model.addAttribute("cnt", xmlCount);
		
		return "article/article_home";
	}
	
	
	/** 파싱된 XML(논문) 내용 상세보기  **/
	@RequestMapping(value="/article/read", method=RequestMethod.POST)
	@ResponseBody
	public ArtiVO xmlRead(@RequestParam("arti_no")int arti_no, Model model){
		
		ArtiVO article = service.readVO(arti_no);
		
		return article;
	}
	
	/** 메인 페이지(xml_home.jsp)에서 Ajax파싱 부분 불러오기 **/
	@RequestMapping(value = "/article/check", method = RequestMethod.POST)
	@ResponseBody
	public ArtiVO xmlCheck(@RequestParam(defaultValue = "") String filePath) throws Exception {

		ArtiVO article = service.createVO(filePath);
		
		return article;
	}
	
	/** 메인 페이지(xml_home.jsp)에서 파싱해온 결과 DB에 저장 **/
	@RequestMapping(value = "/article/insert", method = RequestMethod.POST)
	public String xmlInsert(ArtiVO article) throws Exception {

		
		service.insertVO(article);

		return "redirect:/article";
	}
	

}
