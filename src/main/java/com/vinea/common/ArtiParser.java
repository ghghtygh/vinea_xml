package com.vinea.common;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.vinea.dto.ArtiVO;

public class ArtiParser {
	
	private ArtiVO vo = null;
	private XPath xpath;
	private Document document;
	
	public ArtiParser(String filePath) throws Exception {
		
		/** 논문 정보 파싱 vo 객체에 담기(ArtiParser.java --> ArtiVo.java) **/
		
		vo = new ArtiVO();
		
		document = DocumentBuilderFactory.newInstance().newDocumentBuilder()
				.parse(filePath);
		
		xpath = XPathFactory.newInstance().newXPath();
		
		NodeList cols2 = (NodeList) xpath.evaluate("//records", document, XPathConstants.NODESET);
		for (int idx = 0; idx < cols2.getLength(); idx++) {
		}
		
		/** 논문번호  **/
		String arti_no = (String) xpath.evaluate("//identifier[@type='art_no']/@value", document,
				XPathConstants.STRING);
		/** 논문 UID **/
		String arti_uid = (String) xpath.evaluate("//UID/text()", document, XPathConstants.STRING);
		
		/** 논문제목 **/
		String arti_title = (String) xpath.evaluate("//title[@type='item']", document, XPathConstants.STRING);
		/** 학술지명(저널명) **/
		String arti_source_title = (String) xpath.evaluate("//title[@type='source']", document, XPathConstants.STRING);
		
		/** 발행년도 **/
		String arti_year = (String) xpath.evaluate("//pub_info/@pubyear", document, XPathConstants.STRING);
		/** 발행일자 **/
		String arti_date = (String) xpath.evaluate("//pub_info/@sortdate", document, XPathConstants.STRING);
		/** 권 번호  **/
		String arti_volume = (String) xpath.evaluate("//pub_info/@vol", document, XPathConstants.STRING);
		/** 호 번호 **/
		String arti_issue = (String) xpath.evaluate("//pub_info/@issue", document, XPathConstants.STRING);
		/** 부록 수 **/
		String arti_sup = (String) xpath.evaluate("//pub_info/@supplement", document, XPathConstants.STRING);
		
		/** DOI(정규표현식 사용) **/
		String arti_doi = (String) xpath.evaluate("//identifier[contains(@type, 'doi')]/@value", document, XPathConstants.STRING);
		/** 초록 **/
		String arti_ab = (String) xpath.evaluate("//abstract_text/p", document, XPathConstants.STRING);
		
		/** 국제표준연속간행물번호(ISSN) **/
		String arti_issn = (String) xpath.evaluate("//identifier[@type='issn']/@value", document, XPathConstants.STRING);
		/** 전자국제표준연속간행물번호(EISSN) **/
		String arti_eissn = (String) xpath.evaluate("//identifier[@type='eissn']/@value", document,
				XPathConstants.STRING);
		
		/** 참고문헌 수 **/
		String arti_cite_cnt = (String) xpath.evaluate("//references/@count", document, XPathConstants.STRING);
		/** 페이지 수 **/
		String arti_page_cnt = (String) xpath.evaluate("//page/@page_count", document, XPathConstants.STRING);
		
		/** 시작 페이지 **/
		String arti_bp = (String) xpath.evaluate("//page", document, XPathConstants.STRING);
		/** 종료 페이지 **/
		String arti_ep = (String) xpath.evaluate("//page", document, XPathConstants.STRING);

		/** 자료 열람 여부 **/
		String arti_oa = (String) xpath.evaluate("//pub_info/@journal_oas_gold", document, XPathConstants.STRING);
	
		vo.setArti_no(arti_no);
		vo.setArti_uid(arti_uid);
		
		vo.setArti_title(arti_title);
		vo.setArti_source_title(arti_source_title);
		
		vo.setArti_year(arti_year);
		vo.setArti_date(arti_date);
		
		vo.setArti_vol(arti_volume);
		vo.setArti_issue(arti_issue);
		vo.setArti_sup(arti_sup);
		
		vo.setArti_doi(arti_doi);
		
		vo.setArti_ab(arti_ab);
		vo.setArti_issn(arti_issn);
		vo.setArti_eissn(arti_eissn);
		
		vo.setArti_cite_cnt(Integer.parseInt(arti_cite_cnt));
		vo.setArti_page_cnt(Integer.parseInt(arti_page_cnt));
		
		vo.setArti_bp(arti_bp);
		vo.setArti_ep(arti_ep);
		
		vo.setArti_oa(arti_oa);
		
		
		/** VO 객체에 담긴 데이터들을 보여준다 **/
		//System.out.println(vo.toStringMultiline());

	}
	
	public ArtiVO returnVO(){
		return vo;
	}

}
