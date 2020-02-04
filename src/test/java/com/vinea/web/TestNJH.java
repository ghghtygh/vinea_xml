package com.vinea.web;

import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vinea.common.NjhParser;
import com.vinea.dto.ArtiVO;
import com.vinea.dto.AuthVO;
import com.vinea.dto.DtypeVO;

public class TestNJH {

	Logger logger;
	String filepath;
	NjhParser np;
	List<ArtiVO> list;
	Iterator it;
	
	
	public TestNJH() throws Exception{
		
		logger = LoggerFactory.getLogger(TestNJH.class);
		
		filepath = "D:\\test.xml";

		np = new NjhParser(filepath);
		
		np.Test1();
		
//		if(np.CanParse()){
//			
//			np.DoParse();
//			list = np.returnList();
//			
//			for (ArtiVO vo : list){
//				
//				logger.info(vo.getArti_ctgr_name());
//				logger.info(vo.getArti_ctgr_subh());
//				logger.info(vo.getArti_ctgr_subj());
//				
//				for (DtypeVO dvo : vo.getList_dtype()){
//					
//					logger.info(dvo.toStringMultiline());
//				}
//				
//			}
//			
//			logger.info("성공");
//		}else{
//		
//			logger.info("실패");
//		}
		
		
		
	}
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		
		
		
		new TestNJH();
		
		
	}

}
