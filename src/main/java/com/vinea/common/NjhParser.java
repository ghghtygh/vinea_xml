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
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.vinea.dto.ArtiVO;

public class NjhParser {
	
	Logger logger;
	
	private List<ArtiVO> listvo;
	
	public XPath xpath;
	public Document document;
	
	String msg;
	
	public NjhParser(String filePath) throws Exception {
		
		Logger logger = LoggerFactory.getLogger(NjhParser.class);
		
		listvo = new ArrayList<ArtiVO>();
		
		document = DocumentBuilderFactory.newInstance().newDocumentBuilder()
				.parse(filePath);
		
		xpath = XPathFactory.newInstance().newXPath();
		
		NodeList recs = (NodeList) xpath.evaluate("//REC", document, XPathConstants.NODESET);
				
		
		for (int i = 0, n = recs.getLength(); i < n; i++) {
			
			logger.info(Integer.toString(i));

			Node rec = (Node) recs.item(i);
			
			//logger.info(rec.getTextContent());
			
			parseREC(rec);
			
			
			//listvo.add(vo);
		}
		
//		
//		/* 논문 UID */
//		String uid = (String) xpath.evaluate("//UID/text()", document, XPathConstants.STRING);
//		
//		/* 논문번호 */
//		String arti_no = (String) xpath.evaluate("//identifier[@type='art_no']/@value", document,
//				XPathConstants.STRING);
//		
//		/* 논문제목 */
//		String arti_title = (String) xpath.evaluate("//title[@type='item']", document, XPathConstants.STRING);
//		
//		/* 학술지명(저널명) */
//		String jrnl_title = (String) xpath.evaluate("//title[@type='source']", document, XPathConstants.STRING);
//		/* 발행년도 */
//		String pub_year = (String) xpath.evaluate("//pub_info/@pubyear", document, XPathConstants.STRING);
//
//		/* 발행일자 */
//		String pub_date = (String) xpath.evaluate("//pub_info/@sortdate", document, XPathConstants.STRING);
//
//		/* 자료 열람 여부 */
//		String oa = (String) xpath.evaluate("//pub_info/@journal_oas_gold", document, XPathConstants.STRING);
//
//		/* 권 번호 */
//		String volume = (String) xpath.evaluate("//pub_info/@vol", document, XPathConstants.STRING);
//
//		/* 호 번호 */
//		String issue = (String) xpath.evaluate("//pub_info/@issue", document, XPathConstants.STRING);
//
//		/* 부록 수 */
//		String arti_sup = (String) xpath.evaluate("//pub_info/@supplement", document, XPathConstants.STRING);
//
//		/* 페이지 수 */
//		String page_cnt = (String) xpath.evaluate("//page/@page_count", document, XPathConstants.STRING);
//
//		
//		/* 시작 페이지 */
//		String arti_bp = (String) xpath.evaluate("//page", document, XPathConstants.STRING);
//
//		/* 종료 페이지 */
//		String arti_ep = (String) xpath.evaluate("//page", document, XPathConstants.STRING);
//
//		/* DOI */
//		String doi = (String) xpath.evaluate("//identifier[@type='doi']/@value", document, XPathConstants.STRING);
//		// String doi = (String) xpath.evaluate("//identifier[@type='xref_doi']/@value",
//		// document, XPathConstants.STRING);
//
//
//		/* 초록 */
//		String arti_ab = (String) xpath.evaluate("//abstract_text/p", document, XPathConstants.STRING);
//
//		/* 국제표준연속간행물번호(ISSN) */
//		String issn = (String) xpath.evaluate("//identifier[@type='issn']/@value", document, XPathConstants.STRING);
//
//		/* 전자국제표준연속간행물번호(EISSN) */
//		String eissn = (String) xpath.evaluate("//identifier[@type='eissn']/@value", document,
//				XPathConstants.STRING);
//
//		/* 참고문헌 수 */
//		String cite_cnt = (String) xpath.evaluate("//references/@count", document, XPathConstants.STRING);
//
//		
//		vo.setUid(uid);
//		vo.setArti_no(Integer.parseInt(arti_no));
//		
//		vo.setArti_title(arti_title);
//		vo.setJrnl_title(jrnl_title);
//		
//		vo.setPub_year(pub_year);
//		vo.setPub_date(pub_date);
//		
//		vo.setOA(oa);
//		
//		vo.setVolume(volume);
//		vo.setIssue(issue);
//		vo.setArti_sup(arti_sup);
//		
//		vo.setPage_cnt(Integer.parseInt(page_cnt));
//		vo.setArti_bp(arti_bp);
//		vo.setArti_ep(arti_ep);
//
//		vo.setArti_ab(arti_ab);
//		
//		vo.setDoi(doi);
//		vo.setIssn(issn);
//		vo.setEissn(eissn);
//		
//		vo.setCite_cnt(Integer.parseInt(cite_cnt));
		
	}
	
	public void parseREC(Node rec3) throws Exception {
		
		logger.info(rec3.getTextContent());
//		
//		ArtiVO vo = null;
//		
//		Node rec2 = (Node) xpath.evaluate(".//UID", rec3, XPathConstants.NODE);
//		
//		logger.info("NODENAME : "+rec2.getNodeName());
//		logger.info("VALUE : "+rec2.getTextContent());
//		
	}
	public List<ArtiVO> returnList(){
		return listvo;
	}

}
