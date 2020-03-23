package com.vinea.web;

import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.vinea.dto.ArtiVO;

@Controller
@RequestMapping("/es")
public class EsController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private Gson gson = new Gson();

	
	
	public RestHighLevelClient createConnection() {

		RestClientBuilder builder = RestClient.builder(new HttpHost("127.0.0.1", 9200, "http"));

		return new RestHighLevelClient(builder);
	}
	

	@RequestMapping("/search")
	public void search(@RequestParam(defaultValue = "") String search, @RequestParam(defaultValue = "0") String sp,
			@RequestParam(defaultValue = "10") String ps) throws Exception {

		String nm = search;
		logger.info("nm : {}", nm);
		logger.info("nm.trim() : {}",nm.trim());
		
		String aliasName = "logstash_leftjoin_mysql";
		
		RestHighLevelClient client = createConnection();
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
		
		String[] fleids = {"orgn_nm","orgn_pref_nm"}; 
		searchSourceBuilder.query(QueryBuilders.multiMatchQuery(nm, fleids));
		searchSourceBuilder.sort(new FieldSortBuilder("_score").order(SortOrder.DESC));
		
		searchSourceBuilder.from(Integer.parseInt(sp));
		searchSourceBuilder.size(Integer.parseInt(ps));
		
		SearchRequest searchRequest = new SearchRequest(aliasName);
		searchRequest.source(searchSourceBuilder);

		SearchResponse response = null;
		SearchHits searchHits = null;

		response = client.search(searchRequest, RequestOptions.DEFAULT);
		searchHits = response.getHits();
		
		
		logger.info("test:{}",(int)searchHits.getTotalHits().value);
		
		
		
		int i = 0;

		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		
		for (SearchHit hit : searchHits) {
			Map<String, Object> sourceAsMap = hit.getSourceAsMap();
			
			ArtiVO artiVO = mapper.convertValue(sourceAsMap, ArtiVO.class);
			
			/*logger.info("========={}============", i++);
			logger.info(sourceAsMap.get("uid").toString());
			logger.info(sourceAsMap.get("orgn_nm").toString());
			logger.info("----------------------");
			logger.info(artiVO.toStringMultiline());*/
		}
		
		if(client!=null){
			client.close();
		}

	}

}
