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

	public TestNJH() throws Exception {

		
		np = new NjhParser(filepath);
		
		String filePath = "D:\\2017_CORE\\WR_2017_20180509131811_CORE_0001.xml";
		
		/* 파일 이름 */
		String fileName = null;
		String array[] = filePath.split("\\\\");
		for (int i = 0; i < array.length; i++) {
			if (array[i].contains(".xml")) {
				fileName = array[i];
			}
		}
		Date date = null;
		date = new Date();
		long start = date.getTime();
		logger.info(Long.toString(start));
		logger.info(fileName);

	}

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub

		new TestNJH();

	}

}
