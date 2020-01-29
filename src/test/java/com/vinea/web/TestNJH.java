package com.vinea.web;

import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vinea.common.NjhParser;
import com.vinea.dto.ArtiVO;

public class TestNJH {

	
	public static void main(String[] args) throws Exception{
		// TODO Auto-generated method stub
		
		Logger logger = LoggerFactory.getLogger(TestNJH.class);
		
		NjhParser np = new NjhParser("C:\\Users\\vinea\\Desktop\\sample\\api_xml\\test.xml");
		
		//ArtiVO vo = np.returnVO();
		
		
		
		//logger.info("hi");
		
		List<ArtiVO> list = np.returnList();
		
		Iterator it = list.iterator();
		
		while(it.hasNext()) {
			ArtiVO vo = (ArtiVO) it.next();
			logger.info(vo.toStringMultiline());
		}
	}

}
