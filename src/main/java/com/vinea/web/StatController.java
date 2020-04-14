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

import com.google.gson.Gson;
import com.vinea.dto.CtgrKwrdVO;
import com.vinea.dto.CtgrStatVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.YearVO;
import com.vinea.service.PostPager;
import com.vinea.service.StatService;


@Controller
@RequestMapping("/stat")
public class StatController {
	
	@Inject
	private StatService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/* 파싱된 결과 통계 부분 */
	/** 연도별 논문수, 도서수, 참고문헌수, 학술지수 통계(페이지) **/
	@RequestMapping(value = "/year", method = RequestMethod.GET)
	public ModelAndView yearlyChart() throws Exception {
				
		 List<YearVO> list = service.getYearCnt();	
		 
		 ModelAndView mav = new ModelAndView("article/year_stat");	  
		 mav.addObject("yearVOList", list);
		  
		 return mav;		 
	}
	
	/** 연도별 논문수, 도서수, 참고문헌수, 학술지수 통계(차트데이터) **/
	@RequestMapping(value = "/yearcnt", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public @ResponseBody String yearList(Locale locale, Model model) throws Exception {

		Gson gson = new Gson();
		List<YearVO> list = service.getYearCnt();
		return gson.toJson(list);

	}	
	
		
	/** 소속기관별 데이터 통계(페이지)_수정 **/
	@RequestMapping(value = "/orgn2")
	public ModelAndView orgnChart2(@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue="") String search,
			@RequestParam(defaultValue = "") String country, //추가 부분(국가선택)
			@RequestParam(defaultValue="10")String cnt_option,
			@RequestParam(defaultValue="2017")String year) throws Exception {
		
		/* 소속기관별 통계: 논문수, 인용수, 소속기관별 연구분야 비율 */
		ModelAndView mav = new ModelAndView("article/orgn_stat");
		
		
		/* 한페이지에 보여질 요소 개수 */
		int pageSize = Integer.parseInt(cnt_option);
		
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
		int orgCnt = service.countOrg2(map);
		
		PostPager pager = new PostPager(orgCnt, page, pageSize);

		map.put("start_index", pager.getStartIndex());
		map.put("page_size", pageSize);
		
		List<OrgnVO> orgList = service.selectOrgList2(map);
		
		mav.addObject("orgList", orgList);
		mav.addObject("pager", pager);
		mav.addObject("cnt", orgCnt);
		mav.addObject("search", search);
		mav.addObject("cnt_option",cnt_option);
		
		return mav;
	}
	
	/** 연구분야별 저자수, 논문수, 학술지, 참고문헌수 **/
	@RequestMapping(value = "/ctgr")
	public ModelAndView ctgrChart(@RequestParam(defaultValue = "1") int page
			,@RequestParam(defaultValue="3")String sort_option
			,@RequestParam(defaultValue="1")String ctgr_option
			,@RequestParam(defaultValue="ctgr1") String tab_option
			,@RequestParam(defaultValue="10")String cnt_option
			) throws Exception {
		
		
		ModelAndView mav = new ModelAndView("article/ctgr_stat");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sort_option", sort_option);
		map.put("ctgr_option", ctgr_option);
		
		
		int pageSize = Integer.parseInt(cnt_option);
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
		mav.addObject("cnt_option",cnt_option);
		mav.addObject("tab_option",tab_option);
		
		return mav;
	}
	
	
	/** 연구분야별 논문, 저자, 학술지, 참고문헌수 통계에 따른 현황->차트 **/
	@RequestMapping(value = "/subjcnt", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public @ResponseBody String subjlist(@RequestParam(defaultValue="1")String sort_option,Locale locale, Model model) throws Exception {
		
		/* 차트에 데이터를 JSON 방식으로 넘김 */
		Gson gson = new Gson();
		List<CtgrStatVO> list = service.getCtgrStatList();
		for(CtgrStatVO vo :list){
			logger.info(Integer.toString(vo.getJrnl_cnt()));
		}
		return gson.toJson(list);

	}
		
	/** 키워드 빈도 **/
	@RequestMapping(value = "/kwrd", method = RequestMethod.GET)
	public ModelAndView kwrdChart(@RequestParam(defaultValue="") String ctgrnm
			,@RequestParam(defaultValue="") String subjnm
			,@RequestParam(defaultValue="10") String cnt_option
			) throws Exception {

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
		if (subjnm.equals("")) {
			subjnm = subList.get(0);
		}
		map.put("subjnm", subjnm);
		map.put("cnt_option", Integer.parseInt(cnt_option));
		List<CtgrKwrdVO> kwrdList = service.kwrdCloudList(map);
		
		/* 워드 클라우드 생성을 위해 {"키워드명":"키워드명 데이터", 값: "키워드빈도수"} 와 같은 JSON 형태로 변환 */
		
		int max = -1, min = 10000;
		for (CtgrKwrdVO vo:kwrdList) {
			
			int tmp = vo.getKwrd_cnt();
			
			if(min>=tmp)
				min = tmp;
			
			if(max<=tmp)
				max = tmp;
			
		}
		
		for (CtgrKwrdVO vo:kwrdList) {
			Map<String,Object> map2 = new HashMap<String,Object>();
			map2.put("x", vo.getKwrd_nm());
			map2.put("value", (int)(vo.getKwrd_cnt()-min)*100/max);
			
			Gson gson = new Gson();
			String json = gson.toJson(map2);
			list2.add(json);
		}
				
		mav.addObject("ctgrnm",ctgrnm);
		mav.addObject("subjnm",subjnm);
		mav.addObject("cnt_option",cnt_option);
		/* 워드클라우드를 그리기 위한 배열 */
		mav.addObject("list2",list2);
		return mav;
	
	} 
	
	/** 키워드 빈도 데이터 리스트 **/
	@RequestMapping(value = "/kwrdcnt", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public @ResponseBody String incomeList(Locale locale, Model model) throws Exception {

		/* 차트에 데이터를 JSON 방식으로 넘김 */
		Gson gson = new Gson();
		//List<CtgrKwrdVO> list = service.getKwrdCnt();
		List<CtgrKwrdVO> list = null;
		return gson.toJson(list);

	}		
}
