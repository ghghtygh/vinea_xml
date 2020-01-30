package com.vinea.web;

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

import com.vinea.dto.XmlVO;
import com.vinea.service.ArtiService;
import com.vinea.service.PostPager;
import com.vinea.service.XmlService;

@Controller
public class XmlController {

	@Inject
	private XmlService service;
	
	@Inject
	private ArtiService service2;
	
	/* 메인 화면 - 페이징 처리*/
	@RequestMapping(value = "/xml")
	public String xmlList(@RequestParam(defaultValue = "1") int page, Model model) throws Exception {

		// List<XmlVO> xmlList = service.selectXml();

		int xmlCount = service.countXml();
		int pageSize = 7;
		int startIndex = -1;

		PostPager pager = new PostPager(xmlCount, page, pageSize);

		startIndex = pager.getStartIndex();

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("startIndex", startIndex);
		map.put("pageSize", pageSize);

		//List<XmlVO> xmlList = service.selectXmlList(map);
		List<XmlVO> xmlList = null;
		model.addAttribute("xmlList", xmlList);
		model.addAttribute("pager", pager);
		model.addAttribute("cnt", xmlCount);
		
		return "xml/xml_home";
	}

	
	@RequestMapping(value = "/xml/test")
	public void testtest() throws Exception {
		
		String filepath = "C:\\Users\\vinea\\Desktop\\sample\\api_xml\\test.xml";
		//String filepath = "C:\\Users\\vinea\\jupyter\\sample\\test.xml";
		service.createListVO(filepath);
	}

	
	
	/* 관리자 페이지 GET */
	@RequestMapping(value = "/xml/admin", method = RequestMethod.GET)
	public String xmlAdminGet() {

		return "xml/xml_admin";
	}
	/* 관리자 페이지 POST */
	@RequestMapping(value = "/xml/admin", method = RequestMethod.POST)
	public String xmlAdminPost() {

		return "xml/xml_admin";
	}
	
	/* xml_home.jsp - ajax XML 상세보기 */
	@RequestMapping(value="/xml/read", method=RequestMethod.POST)
	@ResponseBody
	public XmlVO xmlRead(@RequestParam("id")int id, Model model){
		
		XmlVO vo = service.readVO(id);
		
		return vo;
	}
	
	/* xml_home.jsp - ajax 파싱 해오기 */
	@RequestMapping(value = "/xml/check", method = RequestMethod.POST)
	@ResponseBody
	public XmlVO xmlCheck(@RequestParam(defaultValue = "") String filePath) throws Exception {

		XmlVO vo = service.createVO(filePath);

		// logger.info(vo.getTitle());

		return vo;
	}

	
	/* xml_home.jsp - 파싱해온 정보 DB에 저장 */
	@RequestMapping(value = "/xml/insert", method = RequestMethod.POST)
	public String xmlInsert(XmlVO vo) throws Exception {

		
		service.insertVO(vo);

		return "redirect:/xml";
	}
}
