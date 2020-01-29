package com.vinea.common;

import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.vinea.dto.ArtiVO;

public class NjhParser {
	
	Logger logger;
	
	public List<ArtiVO> listvo;
	
	public XPath xpath;
	public Document document;
	
	String msg;
	
	public NjhParser(String filePath) throws Exception {
		
		logger = LoggerFactory.getLogger(NjhParser.class);
		
		listvo = new ArrayList<ArtiVO>();
		
		document = DocumentBuilderFactory.newInstance().newDocumentBuilder()
				.parse(filePath);
		
		xpath = XPathFactory.newInstance().newXPath();
		
		NodeList recs = (NodeList) xpath.evaluate("//REC", document, XPathConstants.NODESET);
				
		
		for (int i = 0, n = recs.getLength(); i < n; i++) {
			
			//logger.info(Integer.toString(i));

			ArtiVO vo = parseREC((Node)recs.item(i));
			
			listvo.add(vo);
		}
		
		
	}
	
	public ArtiVO parseREC(Node rec) throws Exception {
		
		//logger.info(rec.getTextContent());
		
		
		ArtiVO vo = new ArtiVO();
		
		vo.setArti_no((String) xpath.evaluate(".//identifier[@type='art_no']/@value",
				rec, XPathConstants.STRING));
		
		vo.setArti_uid((String) xpath.evaluate(".//UID/text()",
				rec, XPathConstants.STRING));
		
		vo.setArti_title((String) xpath.evaluate(".//title[@type='item']",
				rec, XPathConstants.STRING));
		
		vo.setArti_source_title((String) xpath.evaluate(".//title[@type='source']",
				rec, XPathConstants.STRING));
		
		vo.setArti_year((String) xpath.evaluate(".//pub_info/@pubyear",
				rec, XPathConstants.STRING));
		
		vo.setArti_date((String) xpath.evaluate(".//pub_info/@sortdate",
				rec, XPathConstants.STRING));
		
		vo.setArti_vol((String) xpath.evaluate(".//pub_info/@vol",
				rec, XPathConstants.STRING));
		
		vo.setArti_issue((String) xpath.evaluate(".//pub_info/@issue",
				rec, XPathConstants.STRING));
		
		vo.setArti_sup((String) xpath.evaluate(".//pub_info/@supplement",
				rec, XPathConstants.STRING));
		
		vo.setArti_doi((String) xpath.evaluate(".//identifier[contains(@type, 'doi')]/@value",
				rec, XPathConstants.STRING));
		
		vo.setArti_ab((String) xpath.evaluate(".//abstract_text/p",
				rec, XPathConstants.STRING));
		
		vo.setArti_issn((String) xpath.evaluate(".//identifier[@type='issn']/@value",
				rec, XPathConstants.STRING));
		
		vo.setArti_eissn((String) xpath.evaluate(".//identifier[@type='eissn']/@value",
				rec, XPathConstants.STRING));
		
		vo.setArti_cite_cnt(parseInt((String) xpath.evaluate(".//references/@count",
				rec, XPathConstants.STRING)));
		
		vo.setArti_page_cnt(parseInt((String) xpath.evaluate(".//page/@page_count",
				rec, XPathConstants.STRING)));
		
		vo.setArti_bp((String) xpath.evaluate(".//page",
				rec, XPathConstants.STRING));
		
		vo.setArti_ep((String) xpath.evaluate(".//page",
				rec, XPathConstants.STRING));
		
		vo.setArti_oa((String) xpath.evaluate(".//pub_info/@journal_oas_gold",
				rec, XPathConstants.STRING));
		
		
		//logger.info(vo.toStringMultiline());
		
		return vo;
	}
	public int parseInt(String str){
		
		String restr = str.replaceAll("[^0-9]","");
		
		if (restr.equals("")){
			return 0;
		}else{
			return Integer.parseInt(restr);
		}
		
	}
	public List<ArtiVO> returnList(){
		
		return listvo;
	}

}
