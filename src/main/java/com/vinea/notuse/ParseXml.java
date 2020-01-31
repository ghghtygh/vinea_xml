package com.vinea.notuse;

import java.io.StringReader;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.vinea.dto.XmlVO;

public class ParseXml {

	private XmlVO vo = null;
	private XPath xpath;
	private Document document;
	
	public ParseXml(String filePath) throws Exception {

		vo = new XmlVO();
		
		document = DocumentBuilderFactory.newInstance().newDocumentBuilder()
				.parse(filePath);

		// xpath 생성
		xpath = XPathFactory.newInstance().newXPath();
		
		// 제목 [title 중 type이 source에 해당하는 것]
		vo.setTitle((String) xpath.evaluate("//*/title[@type='source']", document, XPathConstants.STRING));
		
		// 요약
		vo.setAbstr((String) xpath.evaluate("//*/abstract/abstract_text/p", document, XPathConstants.STRING));
		
		// 기관
		vo.setOrg((String) xpath.evaluate("//*/address_name/address_spec/organizations/organization", document,
				XPathConstants.STRING));

		// 저자 [display_name들을 String으로 저장, "|" 를 통해 구분]
		NodeList cols = (NodeList) xpath.evaluate("//*/address_name/names/name/display_name", document,
				XPathConstants.NODESET);

		String authors = "";
		
		for (int i = 0, n = cols.getLength(); i < n; i++) {

			String author = cols.item(i).getTextContent();
			
			authors+=author;
			
			if (i < n - 1){
				authors+=";";
			}
			
		}
		
		vo.setAuthors(authors);
		
		// 카테고리 [category_info 중 heading에 해당하는 것]
		vo.setCategory((String) xpath.evaluate("//*/category_info/headings/heading", document,
				XPathConstants.STRING));

		// 세부주제 [category_info 중 subject에 해당하는 것]
		vo.setSubject((String) xpath.evaluate("//*/category_info/subjects/subject", document, XPathConstants.STRING));

		// 출판사 [publisher의 하위 태그 중 display_name]
		vo.setPublisher((String) xpath.evaluate("//*/publisher/names/name/display_name", document,
				XPathConstants.STRING));
		
		// 도시
		String city = (String) xpath.evaluate("//*/address_name/address_spec/city", document, XPathConstants.STRING);

		// 나라
		String country = (String) xpath.evaluate("//*/address_name/address_spec/country", document,
				XPathConstants.STRING);
		
	}

	public XmlVO returnVO(){
		return vo;
	}
	/*
	public void printXp(String xp) throws Exception{
		
		System.out.println((String) xpath.evaluate(xp, document, XPathConstants.STRING));
		
	}
	public void printVO(){
		
		System.out.println(vo.toStringMultiline());
		
	}
	public void insertVO(){
		
		vtm = new VoToMap(vo);
		
		ot = new OracleTest();
		
		ot.insertXml(vtm.reMap());
		
	}

	*/
}