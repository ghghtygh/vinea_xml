package com.vinea.web;

import com.vinea.dto.XmlVO;
import com.vinea.persistence.ParseXml;

public class Testing {

	public static void main(String[] args) throws Exception{
		// TODO Auto-generated method stub

		String filePath = "C:\\Users\\vinea\\Desktop\\sample.xml";
		ParseXml px = new ParseXml(filePath);
		XmlVO vo = px.returnVO();
		
		System.out.println(vo.getTitle());
	}

}
