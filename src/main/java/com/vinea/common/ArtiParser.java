package com.vinea.common;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;

import com.vinea.dto.ArtiVO;
import com.vinea.dto.XmlVO;

public class ArtiParser {
	
	private ArtiVO vo = null;
	private XPath xpath;
	private Document document;
	
	public ArtiParser(String filePath) throws Exception {
		
		vo = new ArtiVO();
		
		document = DocumentBuilderFactory.newInstance().newDocumentBuilder()
				.parse(filePath);
		
		xpath = XPathFactory.newInstance().newXPath();
		
		/* 논문 UID */
		String uid = (String) xpath.evaluate("//UID/text()", document, XPathConstants.STRING);
		System.out.println("[UID]\n" + uid);
		/* 논문번호 */
		String arti_no = (String) xpath.evaluate("//identifier[@type='art_no']/@value", document,
				XPathConstants.STRING);
		System.out.println("[논문번호]\n" + arti_no);
		/* 논문제목 */
		String arti_title = (String) xpath.evaluate("//title[@type='item']", document, XPathConstants.STRING);
		System.out.println("[논문제목]\n" + arti_title);
		/* 학술지명(저널명) */
		String jrnl_title = (String) xpath.evaluate("//title[@type='source']", document, XPathConstants.STRING);
		/* 발행년도 */
		String pub_year = (String) xpath.evaluate("//pub_info/@pubyear", document, XPathConstants.STRING);
		System.out.println("[발행년도]\n" + pub_year);
		/* 발행일자 */
		String pub_date = (String) xpath.evaluate("//pub_info/@sortdate", document, XPathConstants.STRING);
		System.out.println("[발행일자]\n" + pub_date);
		/* 자료 열람 여부 */
		String oa = (String) xpath.evaluate("//pub_info/@journal_oas_gold", document, XPathConstants.STRING);
		System.out.println("[자료열람여부]\n" + oa);
		/* 권 번호 */
		String volume = (String) xpath.evaluate("//pub_info/@vol", document, XPathConstants.STRING);
		System.out.println("[권 번호]\n" + volume);
		/* 호 번호 */
		String issue = (String) xpath.evaluate("//pub_info/@issue", document, XPathConstants.STRING);
		System.out.println("[호 번호]\n" + issue);
		/* 부록 수 */
		String arti_sup = (String) xpath.evaluate("//pub_info/@supplement", document, XPathConstants.STRING);
		System.out.println("[부록 수]\n" + arti_sup);
		/* 페이지 수 */
		String page_cnt = (String) xpath.evaluate("//page/@page_count", document, XPathConstants.STRING);
		System.out.println("[페이지 수]\n" + page_cnt);
		/* 시작 페이지 */
		String arti_bp = (String) xpath.evaluate("//page", document, XPathConstants.STRING);
		System.out.println("[시작페이지]\n" + arti_bp);
		/* 종료 페이지 */
		String arti_ep = (String) xpath.evaluate("//page", document, XPathConstants.STRING);
		System.out.println("[종료페이지]\n" + arti_ep);
		/* DOI */
		String doi = (String) xpath.evaluate("//identifier[@type='doi']/@value", document, XPathConstants.STRING);
		// String doi = (String) xpath.evaluate("//identifier[@type='xref_doi']/@value",
		// document, XPathConstants.STRING);
		System.out.println("[DOI]\n" + doi);
		/* 초록 */
		String arti_ab = (String) xpath.evaluate("//abstract_text/p", document, XPathConstants.STRING);
		System.out.println("[초록]\n" + arti_ab);
		/* 국제표준연속간행물번호(ISSN) */
		String issn = (String) xpath.evaluate("//identifier[@type='issn']/@value", document, XPathConstants.STRING);
		System.out.println("[ISSN]\n" + issn);
		/* 전자국제표준연속간행물번호(EISSN) */
		String eissn = (String) xpath.evaluate("//identifier[@type='eissn']/@value", document,
				XPathConstants.STRING);
		System.out.println("[EISSN]\n" + eissn);
		/* 참고문헌 수 */
		String cite_cnt = (String) xpath.evaluate("//references/@count", document, XPathConstants.STRING);
		System.out.println("[참고문헌 수]\n" + cite_cnt);
		
		vo.setUid(uid);
		vo.setArti_no(Integer.parseInt(arti_no));
		
		vo.setArti_title(arti_title);
		vo.setJrnl_title(jrnl_title);
		
		vo.setPub_year(pub_year);
		vo.setPub_date(pub_date);
		
		vo.setOA(oa);
		
		vo.setVolume(volume);
		vo.setIssue(issue);
		vo.setArti_sup(arti_sup);
		
		vo.setPage_cnt(Integer.parseInt(page_cnt));
		vo.setArti_bp(arti_bp);
		vo.setArti_ep(arti_ep);

		vo.setArti_ab(arti_ab);
		
		vo.setDoi(doi);
		vo.setIssn(issn);
		vo.setEissn(eissn);
		
		vo.setCite_cnt(Integer.parseInt(cite_cnt));
			

	}
	
	public ArtiVO returnVO(){
		return vo;
	}

}
