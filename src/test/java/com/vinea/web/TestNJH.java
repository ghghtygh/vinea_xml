package com.vinea.web;

import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vinea.common.NjhParser;
import com.vinea.dto.ArtiVO;
import com.vinea.dto.KwrdplusVO;
import com.vinea.service.ArtiService;

public class TestNJH {

	Logger logger;
	String filepath;
	NjhParser np;
	List<ArtiVO> list;
	Iterator it;
	
	
	public TestNJH() throws Exception{
		
		logger = LoggerFactory.getLogger(TestNJH.class);
		
		filepath = "C:\\Users\\vinea\\Desktop\\sample\\api_xml\\test.xml";
		
		np = new NjhParser(filepath);
		
		list = np.returnList();
		
		for (ArtiVO vo : list){
			
			//logger.info(vo.toStringMultiline());
			
			for (KwrdplusVO kvo : vo.getList_kwrdplus()){
				//logger.info(kvo.getKwrdp_name());
			}
		}
		
		
	}
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		
		
		
		new TestNJH();
		
		
	}

}
