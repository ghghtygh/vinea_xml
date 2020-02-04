package com.vinea.web;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vinea.common.NjhParser;
import com.vinea.dto.ArtiVO;
import com.vinea.dto.AuthVO;
import com.vinea.dto.DtypeVO;

public class TestNJH {

	Logger logger = LoggerFactory.getLogger(TestNJH.class);
	String filepath;
	NjhParser np;
	List<ArtiVO> list;
	Iterator it;
	
	
	public TestNJH() throws Exception{
		
		
		
		filepath = "C:\\Users\\vinea\\Desktop\\2017_CORE\\WR_2017_20180509131811_CORE_0001.xml";

		np = new NjhParser(filepath);
		
		String filePath = "C:\\Users\\vinea\\Desktop\\2017_CORE\\WR_2017_20180509131811_CORE_0001.xml";
		
		/* 파일 이름 */
		String fileName = null;
		String array[] = filePath.split("\\\\");
		for (int i=0;i<array.length;i++){
			if(array[i].contains(".xml")){
				fileName=array[i];
			}
		}
		Date date = null;
		date = new Date();
		long start = date.getTime();
		logger.info(Long.toString(start));
		logger.info(fileName);
		
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
