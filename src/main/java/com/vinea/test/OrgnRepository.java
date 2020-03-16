package com.vinea.test;

import java.util.List;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface OrgnRepository extends ElasticsearchRepository{

	List findOrgnByUid(String uid);
	List findOrgnByOrgnNm(String orgnNm);
	List findOrgnByOrgnPrefNm(String orgnPrefNm);
	
	
}
