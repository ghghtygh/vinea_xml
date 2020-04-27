package com.vinea.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.http.HttpHost;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.FieldSortBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vinea.dto.ArtiVO;
import com.vinea.dto.RefrVO;
import com.vinea.service.ArtiService;
import com.vinea.service.PostPager;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/article")
public class ArtiController {
	
	@Inject
	private ArtiService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/* 메인페이지_논문 목록 */
	/** 메인화면으로 이동_논문 목록 페이지 **/
	@RequestMapping(value = "", method=RequestMethod.GET)
	public ModelAndView xmlList(@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue="") String search,
			@RequestParam(defaultValue="0")String search_option,
			@RequestParam(defaultValue="0")String sort_option,
			@RequestParam(defaultValue="10")String cnt_option,
			@RequestParam(defaultValue="0")String es) throws Exception
	{
		
		/* 데이터 넘길 JSP 경로 */
		ModelAndView mav = new ModelAndView("article/article_home");
	
		/* 한페이지에 보여질 요소 개수 */
		int pageSize = Integer.parseInt(cnt_option);
		
		/* 사용할 데이터를 저장할 map 선언 */
		Map<String,Object> map = new HashMap<String,Object>();
		
		/* 검색어 세팅 */
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
			
		
		int xmlCount = 0;				// 논문 건수
		List<ArtiVO> xmlList = new ArrayList<ArtiVO>();	// 논문 리스트
		PostPager pager = null;			// 페이징 객체
		
		
		if (es.equals("0")){
		// 테이블 통한 검색
			
			xmlCount = service.countXml(map);
			
			/* 페이징 처리 */
			pager = new PostPager(xmlCount, page, pageSize);
			
			map.put("start_index", pager.getStartIndex());
			map.put("page_size", pageSize);
			
			xmlList = service.selectXmlList(map);
			
			
		}
		/** ElasticSearch 검색  **/
		else {
		
			String aliasName = "logstash_mysql_test04";
			
			RestHighLevelClient client = createConnection();
			SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
						
			String[] fields = null;
			
			if(search_option.equals("1")){
				/* 논문제목 검색 */
				fields = new String[]{"arti_title"};
			}else if(search_option.equals("2")){
				/* 소속기관 검색 */
				fields = new String[]{"orgn_nm","orgn_pref_nm"};
			}
			
			searchSourceBuilder.query(QueryBuilders.multiMatchQuery(search, fields));
			
			/* 정렬 기준 */			
			if(sort_option.equals("1")){
				searchSourceBuilder.sort(new FieldSortBuilder("_score").order(SortOrder.DESC));
			}else if(sort_option.equals("2")){
				searchSourceBuilder.sort(new FieldSortBuilder("uid.keyword").order(SortOrder.DESC));
			}else{
				searchSourceBuilder.sort(new FieldSortBuilder("pub_date").order(SortOrder.DESC));
			}
			searchSourceBuilder.from((page-1)*pageSize);
			searchSourceBuilder.size(pageSize);
			
			SearchRequest searchRequest = new SearchRequest(aliasName);
			searchRequest.source(searchSourceBuilder);

			SearchResponse response = null;
			SearchHits searchHits = null;

			response = client.search(searchRequest, RequestOptions.DEFAULT);
			searchHits = response.getHits();
			
			xmlCount = (int)searchHits.getTotalHits().value;
			
			pager = new PostPager(xmlCount, page, pageSize);
			
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			
			int num = ((page-1)*pageSize) +1;
			
			for (SearchHit hit : searchHits) {
				Map<String, Object> sourceAsMap = hit.getSourceAsMap();
				
				ArtiVO artiVO = mapper.convertValue(sourceAsMap, ArtiVO.class);
				artiVO.setNum(num++);
				xmlList.add(artiVO);
				
			}
			
			if(client!=null){
				client.close();
			}
			
		}
		
		mav.addObject("xmlList", xmlList);
		mav.addObject("pager", pager);
		mav.addObject("cnt", xmlCount);
		mav.addObject("search", search);
		mav.addObject("search_option",search_option);
		mav.addObject("sort_option",sort_option);
		mav.addObject("cnt_option",cnt_option);
		mav.addObject("es", es);
		return mav;
	}
	
	/* ElasticSearch 클라이언트(서버) 연결 */
	public RestHighLevelClient createConnection() {

		RestClientBuilder builder = RestClient.builder(new HttpHost("127.0.0.1", 9200, "http"));

		return new RestHighLevelClient(builder);
	}
	
	/* 상세페이지 */
	/** 파싱된 XML(논문) 내용 상세보기 **/
	@RequestMapping(value="/article_detail", method=RequestMethod.GET)
	public ModelAndView article_detail(@RequestParam("uid")String uid) throws Exception{
		
		ModelAndView mav = new ModelAndView("article/article_detail");
		ArtiVO artiVO = service.article_detail(uid);
		
		mav.addObject("ArtiVO", artiVO);
		
		return mav;
		
	}
}