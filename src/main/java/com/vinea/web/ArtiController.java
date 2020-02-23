package com.vinea.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
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
import org.springframework.web.servlet.ModelAndView;

import com.vinea.dto.ArtiVO;
import com.vinea.dto.CtgrKwrdVO;
import com.vinea.dto.CtgrStatVO;
import com.vinea.dto.OrgnVO;
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
	
	/* 메인페이지_논문 목록 */
	/** 메인화면으로 이동_논문 목록 페이지 **/
	@RequestMapping(value = "/article", method=RequestMethod.GET)
	public ModelAndView xmlList(@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue="") String search,
			@RequestParam(defaultValue="0")String search_option,
			@RequestParam(defaultValue="0")String sort_option) throws Exception
	{
		
		/* 데이터 넘길 JSP 경로 */
		ModelAndView mav = new ModelAndView("article/article_home");
	
		/* 한페이지에 보여질 요소 개수 */
		int pageSize = 10;
		
		/* 사용할 데이터를 저장할 map 선언 */
		Map<String,Object> map = new HashMap<String,Object>();
		
		/* 검색 기능 */
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
		
		/* 페이징 처리 */
		PostPager pager = new PostPager(xmlCount, page, pageSize);
		map.put("start_index", pager.getStartIndex());
		map.put("page_size", pageSize);
		
		List<ArtiVO> xmlList = service.selectXmlList(map);
		mav.addObject("xmlList", xmlList);
		mav.addObject("pager", pager);
		mav.addObject("cnt", xmlCount);
		mav.addObject("search", search);
		mav.addObject("search_option",search_option);
		mav.addObject("sort_option",sort_option);
		
		return mav;
	}
	
	/* 상세페이지 */
	/** 파싱된 XML(논문) 내용 상세보기 **/
	@RequestMapping(value="/article/article_detail", method=RequestMethod.GET)
	public ModelAndView article_detail(@RequestParam("uid")String uid) throws Exception{
		
		ModelAndView mav = new ModelAndView("article/article_detail");
		
		mav.addObject("ArtiVO", service.article_detail(uid));
		
		return mav;
		
	} 
	
	/* XML 파일 파싱 부분 */
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

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("file_name",file_name);
		map.put("file_cnt", file_cnt);
		
		service.parseXmlList(map);
		
		return true;
	}

	/* 파싱된 결과 통계 부분 */
	/** 연도별 논문수, 도서수, 참고문헌수, 학술지수 통계(페이지) **/
	@RequestMapping(value = "/article/yearstat", method = RequestMethod.GET)
	public ModelAndView yearlyChart() throws Exception {
				
		 List<YearVO> list = service.getYearCnt();	
		 
		 ModelAndView mav = new ModelAndView("article/year_stat");	  
		 mav.addObject("yearVOList", list);
		  
		 return mav;		 
	}
	
	/** 연도별 논문수, 도서수, 참고문헌수, 학술지수 통계(차트데이터) **/
	@RequestMapping(value = "/article/yearcnt", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public @ResponseBody String yearList(Locale locale, Model model) throws Exception {

		Gson gson = new Gson();
		List<YearVO> list = service.getYearCnt();
		return gson.toJson(list);

	}	
		
	/** 소속기관별 데이터 통계(페이지) **/
	@RequestMapping(value = "/article/orgnstat")
	public ModelAndView orgnChart(@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue="") String search,
			@RequestParam(defaultValue="2017")String year) throws Exception {
		
		/* 소속기관별 통계: 논문수, 인용수, 소속기관별 연구분야 비율 */
		ModelAndView mav = new ModelAndView("article/orgn_stat");
		
		
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
		map.put("search_year", year);
		
		/* 기관 목록의 건수 */
		int orgCnt = service.countOrg(map);
		
		PostPager pager = new PostPager(orgCnt, page, pageSize);

		map.put("start_index", pager.getStartIndex());
		map.put("page_size", pageSize);
		
		List<OrgnVO> orgList = service.selectOrgList(map);
		
		mav.addObject("orgList", orgList);
		mav.addObject("pager", pager);
		mav.addObject("cnt", orgCnt);
		mav.addObject("search", search);
		
		return mav;
	}
	
	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 **/
	@RequestMapping(value = "/article/ctgrstat")
	public ModelAndView ctgrChart(@RequestParam(defaultValue = "1") int page
			,@RequestParam(defaultValue="1")String sort_option
			,@RequestParam(defaultValue="1")String ctgr_option
			,@RequestParam(defaultValue="ctgr1") String tab_option
			) throws Exception {
		
		
		ModelAndView mav = new ModelAndView("article/ctgr_stat");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sort_option", sort_option);
		map.put("ctgr_option", ctgr_option);
		
		
		int pageSize = 10;
		int ctgrCount = service.countCtgrStat(map);
		
		PostPager pager = new PostPager(ctgrCount, page, pageSize);
		
		map.put("start_index", pager.getStartIndex());
		map.put("page_size", pageSize);
		
		
		List<CtgrStatVO> ctgrList = service.selectCtgrStatList(map);
		
		mav.addObject("ctgrList", ctgrList);
		mav.addObject("pager", pager);
		mav.addObject("cnt", ctgrCount);
		mav.addObject("sort_option", sort_option);
		mav.addObject("ctgr_option", ctgr_option);
		
		mav.addObject("tab_option",tab_option);
		
		return mav;
	}
	
	
	/** 연구분야별 논문, 저자, 학술지, 참고문헌수 통계에 따른 현황->차트 **/
	@RequestMapping(value = "/article/subjcnt", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public @ResponseBody String subjlist(@RequestParam(defaultValue="1")String sort_option,Locale locale, Model model) throws Exception {
		
		Gson gson = new Gson();
		List<CtgrStatVO> list = service.getCtgrStatList();
		for(CtgrStatVO vo :list){
			logger.info(Integer.toString(vo.getJrnl_cnt()));
		}
		return gson.toJson(list);

	}
		
	/** 키워드 빈도 **/
	@RequestMapping(value = "/article/kwrdstat", method = RequestMethod.GET)
	public ModelAndView kwrdChart(@RequestParam(defaultValue="") String ctgrnm
			,@RequestParam(defaultValue="Materials Science, Multidisciplinary") String subjnm) throws Exception {

		/* view로 데이터 넘김 */
		ModelAndView mav = new ModelAndView("article/kwrd_stat");
		
		/* 상위 분야 리스트 */
		List<CtgrKwrdVO> list= service.getKwrdCnt(); 
		List<String> subList = new ArrayList<String>();
		List<String> strList = new ArrayList<String>();
		for (CtgrKwrdVO vo :list) {
			
		    if(vo.getCtgr_nm().equals(ctgrnm) || ctgrnm.equals("")) {
		    	subList.add(vo.getSubj_nm());
			}
			strList.add(vo.getCtgr_nm());
		}
		HashSet<String> hashset = new HashSet<String>(strList);
		
		/* 상위 분야 배열 */
		mav.addObject("ctgrList",new ArrayList<String>(hashset));
		
		/* 주제명을 받기 위한 배열 */
		mav.addObject("ctgrList1",list);
		/* 주제명 배열 2 */
		mav.addObject("subList",subList);
		
		List<String> list2 = new ArrayList<String>();
		
		/** 키워드 빈도수 워드클라우드 생성 **/
		/* 서비스로 주제명을 보내기 위한 map 생성 */
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("subjnm", subjnm);
		
		List<CtgrKwrdVO> kwrdList = service.kwrdCloudList(map);
		
		/* 워드 클라우드 생성을 위해 {"키워드명":"키워드명 데이터", 값: "키워드빈도수"} 와 같은 JSON 형태로 변환 */
		for (CtgrKwrdVO vo:kwrdList) {
			Map<String,Object> map2 = new HashMap<String,Object>();
			map2.put("x", vo.getKwrd_nm());
			map2.put("value", vo.getKwrd_cnt());
			
			Gson gson = new Gson();
			String json = gson.toJson(map2);
			list2.add(json);
		}
				
		mav.addObject("ctgrnm",ctgrnm);
		mav.addObject("subjnm",subjnm);
		/* 워드클라우드를 그리기 위한 배열 */
		mav.addObject("list2",list2);
		return mav;
	
	} 
	
	/** 키워드 빈도 데이터 리스트 **/
	@RequestMapping(value = "/article/kwrdcnt", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public @ResponseBody String incomeList(Locale locale, Model model) throws Exception {

		Gson gson = new Gson();
		List<CtgrKwrdVO> list = service.getKwrdCnt();
		return gson.toJson(list);

	}		
}
