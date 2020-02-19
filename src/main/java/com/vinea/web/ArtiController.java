package com.vinea.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vinea.dto.ArtiVO;
import com.vinea.dto.CtgrKwrdVO;
import com.vinea.dto.XmlFileVO;
import com.vinea.dto.YearVO;
import com.vinea.service.XmlService;


import com.vinea.service.PostPager;
import com.google.gson.Gson;

@Controller
public class ArtiController {
	
	@Inject
	private XmlService service;

	Logger logger = LoggerFactory.getLogger(ArtiController.class);
	
	/** 메인화면으로 이동_논문 목록 페이지 **/
	@RequestMapping(value = "/article", method=RequestMethod.GET)
	public ModelAndView xmlList(@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue="") String search,
			@RequestParam(defaultValue="0")String search_option,
			@RequestParam(defaultValue="0")String sort_option) throws Exception
	{
			
		ModelAndView mav = new ModelAndView("article/article_home");
	
		/* 한페이지에 보여질 요소 개수 */
		int pageSize = 10;
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		search = search.trim();
		String[] searchs = search.split("\\s+");
		ArrayList<String> searchList = new ArrayList<String>();
		
		for(String s:searchs){
			searchList.add(s);
		}
		map.put("search", search);
		map.put("search_list", searchList);
		map.put("search_option",search_option);
		map.put("sort_option", sort_option);
		
		
		/* 논문 목록의 건수 */
		int xmlCount = service.countXml(map);
		/*
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		*/
		PostPager pager = new PostPager(xmlCount, page, pageSize);

		map.put("start_index", pager.getStartIndex());
		map.put("page_size", pageSize);
		
		List<ArtiVO> xmlList = service.selectXmlList(map);
		/*
		stopWatch.stop();
		logger.info(stopWatch.shortSummary());
		*/
		mav.addObject("xmlList", xmlList);
		mav.addObject("pager", pager);
		mav.addObject("cnt", xmlCount);
		mav.addObject("search", search);
		mav.addObject("search_option",search_option);
		mav.addObject("sort_option",sort_option);
		
		return mav;
	}
	
	/** 파싱된 XML(논문) 내용 상세보기 **/
	@RequestMapping(value="/article/article_detail", method=RequestMethod.GET)
	public ModelAndView article_detail(@RequestParam("uid")String uid) throws Exception{
		
		//logger.info(service.article_detail(uid).toStringMultiline());
		
		ModelAndView mav = new ModelAndView("article/article_detail");
		
		mav.addObject("ArtiVO", service.article_detail(uid));
		
		return mav;
		
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
	@RequestMapping(value = "/article/test/insert")
	public String testInsert() throws Exception{
		
		
		return "article/article_insert";
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

	/** 연도별 데이터 통계 
	@RequestMapping(value = "/article/yearstat")
	public String yearlyChart() throws Exception {


		return "article/year_stat";
	}**/
	
	/** 연도별 데이터 통계 **/
	@RequestMapping(value = "/article/yearstat", method = RequestMethod.GET)
	public ModelAndView yearlyChart() throws Exception {
				
		 // YearVO yearVO = new YearVO();
		  
		  //yearVO.setArti_cnt(1);
		  
		  //logger.info("vo" + yearVO.getArti_cnt()); 
		  ModelAndView mav = new ModelAndView("article/year_stat");
		  
		  for (YearVO vo :service.getYearCnt()) {
			  logger.info(vo.getPub_year()+" : "+Integer.toString(vo.getArti_cnt()));
		  }
		  
		  mav.addObject("yearVOList", service.getYearCnt());
		  
		  return mav;
		 
	}
	
	/** 연도별 데이터 **/
	@RequestMapping(value = "/article/yearcnt", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public @ResponseBody String yearList(Locale locale, Model model) throws Exception {

		Gson gson = new Gson();
		
		YearVO yearVO = new YearVO();

		List<YearVO> list = service.getYearCnt();

		return gson.toJson(list);

	}	
	
	
	
	/** 소속기관별 데이터 통계 **/
	@RequestMapping(value = "/article/orgnstat")
	public String orgnChart() throws Exception {
		
		/* 소속기관별 통계: 논문수, 인용수, 소속기관별 연구분야 비율 */
		
		return "article/orgn_stat";
	}
	
	/** 연구분야별 데이터 통계 **/
	@RequestMapping(value = "/article/ctgrstat")
	public String ctgrChart() throws Exception {
		
		/* 연구분야별 통계: 논문수, 인용수, 연구분야명, 세부분야명 */
		
		return "article/ctgr_stat";
	}
	
	
	/** 논문키워드 현황
	@RequestMapping(value = "/article/kwrdstat")
	public String kwrdChart() throws Exception {

		
		return "article/kwrd_stat";
	} **/
	
	/** 키워드 빈도 **/
	@RequestMapping(value = "/article/kwrdstat", method = RequestMethod.GET)
	public String kwrdChart(Locale locale, Model model) throws Exception {

		
		return "article/kwrd_stat";
	} 
	
	/** 키워드 빈도 데이터 리스트 */
	@RequestMapping(value = "/article/kwrdcnt", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public @ResponseBody String incomeList(Locale locale, Model model) throws Exception {

		Gson gson = new Gson();

		List<CtgrKwrdVO> list = service.getKwrdCnt();

		return gson.toJson(list);

	}	
	
	
}
