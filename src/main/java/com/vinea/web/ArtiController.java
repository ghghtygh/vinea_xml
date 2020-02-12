package com.vinea.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vinea.dto.ArtiVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.XmlFileVO;
import com.vinea.service.XmlService;
import com.vinea.service.PostPager;

@Controller
public class ArtiController {
	
	@Inject
	private XmlService service;

	Logger logger = LoggerFactory.getLogger(ArtiController.class);
	
	/** 메인화면으로 이동_논문 목록 페이지 **/
	@RequestMapping(value = "/article")
	public String xmlList(@RequestParam(defaultValue = "1") int page, Model model) throws Exception
	{
		/* 논문 목록의 건수 */
		int xmlCount = service.countXml();
		/* 한페이지에 보여질 페이지 수 */
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
	
	/** 파싱된 XML(논문) 내용 상세보기 **/
	@RequestMapping(value="/article/article_detail", method=RequestMethod.GET)
	public String article_detail(@RequestParam("uid")String uid, Model model) throws Exception{
		
		//logger.info(service.article_detail(uid).toStringMultiline());
		
		model.addAttribute("ArtiVO", service.article_detail(uid));
		
		return "article/article_detail";
		
	} 
	
	
	/** 메인 페이지(article_home.jsp)에서 Ajax파싱 부분 불러오기 **/
	@RequestMapping(value = "/article/check", method = RequestMethod.POST)
	@ResponseBody
	public List<ArtiVO> xmlCheck(@RequestParam(defaultValue = "") String filePath) throws Exception {

		List<ArtiVO> artiList = service.checkList(filePath);
		
		return artiList;
	}
	
	/** 메인 페이지(article_home.jsp)에서 파싱해온 결과 DB에 저장 **/
	@RequestMapping(value = "/article/insert", method = RequestMethod.POST)
	public String xmlInsert(@RequestParam(defaultValue = "") String filePath) throws Exception {

		service.createListVO(filePath);
		
		return "redirect:/article";
	}
	
	/** 원본 논문 데이터 파싱 테스트(DB 저장) **/
	@RequestMapping(value = "/article/test")
	public void articleTest() throws Exception{
		
		service.articleTestList();
	}
	
	/** 원본 논문 데이터 파싱 테스트(DB 저장) **/
	@RequestMapping(value = "/article/parsing")
	public String parsingMapping() throws Exception{
		
		
		return "article/article_parse";
	}
	
	/** 파싱 현황 불러오기 **/
	@RequestMapping(value="/article/parsing/check")
	@ResponseBody
	public List<XmlFileVO> xmlParsingCheck() throws Exception{
		
		return service.selectXmlFileCount();
	}
	
	/** 파싱 현황 불러오기 **/
	@RequestMapping(value="/article/parsing/check2")
	@ResponseBody
	public List<XmlFileVO> xmlParsingCheck2() throws Exception{
		
		return service.selectParseYN();
	}
	
	/** XML 파일명에 따라 파싱 **/
	@RequestMapping(value="/article/parsing/test")
	@ResponseBody
	public XmlFileVO xmlParsingTest(@RequestParam(defaultValue="") String file_name) throws Exception{
		
		
		
		return service.parseOneXml(file_name);
	}
	
	/** XML 파일명에 따라 파싱 **/
	@RequestMapping(value="/article/parsing/test2")
	@ResponseBody
	public Boolean xmlParsingTest2(@RequestParam(defaultValue="") String file_name,
			@RequestParam(defaultValue="1")int file_cnt) throws Exception{
		
		//file_name = "WR_2017_20180509131811_CORE_0001.xml";
		//file_cnt = 1;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("file_name",file_name);
		map.put("file_cnt", file_cnt);
		
		service.parseXmlList(map);
		
		return true;
	}

	/** 현황분석_시각화(테스트) **/
	@RequestMapping(value = "/article/test/chart")
	public String testChart() throws Exception {

		/* 연도별 통계 : 발행연도, 논문수, 도서권수, 학술지종수, 참고문헌수 데이터 가져오기 */
		/* 소속기관별 통계: 소속기관명, 발행연도, 논문수, 인용수, 페이징 처리 추가 */
		/* 연구분야별 통계: 분야명(대분류, 주제명), 저자수, 논문수, 학술지종수, 참고문헌수, 페이징 처리 추가 */

		return "article/article_chart";
	}
	   

}
