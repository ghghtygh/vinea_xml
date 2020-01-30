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
import com.vinea.dto.AuthVO;
import com.vinea.dto.CoauthVO;
import com.vinea.dto.ConfVO;
import com.vinea.dto.CtgrVO;
import com.vinea.dto.DtypeVO;
import com.vinea.dto.GrntVO;
import com.vinea.dto.KwrdVO;
import com.vinea.dto.KwrdplusVO;
import com.vinea.dto.RefrVO;
import com.vinea.dto.SponVO;

public class NjhParser {
	
	Logger logger;
	
	private List<ArtiVO> listvo;
	
	private XPath xpath;
	private Document document;
	
	private String strpath = "";
	
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
		
		
		
	//TB_ARTI >> 시작 
		
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
		
		
		if (((String) xpath.evaluate(".//references/@count",
				rec, XPathConstants.STRING)).equals(strpath)){
			
			vo.setArti_cite_cnt(parseInt((String) xpath.evaluate(".//refs/@count",
					rec, XPathConstants.STRING)));
			
		}else{
			
			vo.setArti_cite_cnt(parseInt((String) xpath.evaluate(".//references/@count",
					rec, XPathConstants.STRING)));
			
		}
		
		
		vo.setArti_page_cnt(parseInt((String) xpath.evaluate(".//page/@page_count",
				rec, XPathConstants.STRING)));
		
		// 현재없음
		vo.setArti_bp((String) xpath.evaluate(".//page",
				rec, XPathConstants.STRING));
		// 현재없음
		vo.setArti_ep((String) xpath.evaluate(".//page",
				rec, XPathConstants.STRING));
		
		vo.setArti_oa((String) xpath.evaluate(".//pub_info/@journal_oas_gold",
				rec, XPathConstants.STRING));
		
		// 간행물 아이디
		vo.setArti_item_id((String)xpath.evaluate("./static_data/item/ids/text()",
				rec, XPathConstants.STRING));
		
		// 사용가능 여부
		vo.setArti_item_avail((String) xpath.evaluate("./static_data/item/ids/@avail",
				rec, XPathConstants.STRING));
		
		// 간행물 종류
		vo.setArti_item_type((String) xpath.evaluate("./static_data/item/bib_pagecount/@type",
				rec, XPathConstants.STRING));
		
		// PAGECOUNT
		vo.setArti_item_page(parseInt((String) xpath.evaluate("./static_data/item/bib_pagecount/text()",
				rec, XPathConstants.STRING)));
		
		// 책 페이지 수
		vo.setArti_book_page(parseInt((String) xpath.evaluate("./static_data/item/book_pages/text()",
				rec, XPathConstants.STRING)));
		
		// 책 제본
		vo.setArti_book_bind((String) xpath.evaluate("./static_data/item/book_desc/bk_binding/text()",
				rec, XPathConstants.STRING));
		
		// 책 출판사
		vo.setArti_book_publ((String) xpath.evaluate("./static_data/item/book_desc/bk_publisher/text()",
				rec, XPathConstants.STRING));
		
		// 책 주문 정보
		vo.setArti_book_prepay((String) xpath.evaluate("./static_data/item/book_desc/bk_prepay/text()",
				rec, XPathConstants.STRING));
		
		
	// 끝 << TB_ARTI 
		
		
	// TB_KWRD_PLUS >> 시작
			
		List<KwrdplusVO> list_kwrdplus = new ArrayList<KwrdplusVO>();
		
		NodeList keywordsPlusNodeList = (NodeList) xpath.evaluate("./static_data/item/keywords_plus/keyword",
				rec, XPathConstants.NODESET);
		
		
		for (int j = 0, m = keywordsPlusNodeList.getLength(); j < m; j++) {
			
			KwrdplusVO kwrdplusVO = new KwrdplusVO();
			
			Node keywordsPlusNode = keywordsPlusNodeList.item(j);
			
			
			kwrdplusVO.setKwrdp_uid(vo.getArti_uid());
			
			kwrdplusVO.setKwrdp_name((String) xpath.evaluate("./text()",
					keywordsPlusNode, XPathConstants.STRING ));
			
			list_kwrdplus.add(kwrdplusVO);
		}
		
		vo.setList_kwrdplus(list_kwrdplus);
		
	// 끝  << TB_KWRD_PLUS
		
		
		
		
		
	// TB_AUTH >> 시작
		
		List<AuthVO> list_auth = new ArrayList<AuthVO>();
		
		NodeList nameNodeList = (NodeList) xpath.evaluate(strpath, rec, XPathConstants.NODESET);
		
		for (int i = 0, n = nameNodeList.getLength(); i < n; i++) {
			
			AuthVO authVO = new AuthVO();
			
			Node node = (Node) nameNodeList.item(i);
			
			authVO.setAuth_uid(vo.getArti_uid());
			
			authVO.setAuth_dais(parseInt(strpath));
			
			authVO.setAuth_addr_no(parseInt(strpath));
			
			authVO.setAuth_dply(strpath);
			
			authVO.setAuth_email(strpath);
			
			authVO.setAuth_first(strpath);
			
			authVO.setAuth_full(strpath);
			
			authVO.setAuth_last(strpath);
			
			authVO.setAuth_lead(strpath);
			
			authVO.setAuth_repr(strpath);
			
			authVO.setAuth_role(strpath);
			
			
			
			authVO.setAuth_seq(parseInt(strpath));
			
			authVO.setAuth_wos(strpath);
			
			list_auth.add(authVO);
			
		}
		
		vo.setList_auth(list_auth);
		
	// 끝 << TB_AUTH
		
		
	// TB_COAUTH >> 시작
		
		List<CoauthVO> list_coauth = new ArrayList<CoauthVO>();
		
		NodeList nodelist1 = (NodeList) xpath.evaluate(strpath, rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist1.getLength(); i < n; i++){
			
			CoauthVO coauthVO = new CoauthVO();
			
			Node node = (Node) nodelist1.item(i);
			
			coauthVO.setCoauth_uid(vo.getArti_uid());
			
			coauthVO.setCoauth_dply(strpath);
			
			coauthVO.setCoauth_first(strpath);
			
			coauthVO.setCoauth_last(strpath);
			
			coauthVO.setCoauth_full(strpath);
			
			coauthVO.setCoauth_orcid(parseInt(strpath));
			
			coauthVO.setCoauth_rid(strpath);
			
			coauthVO.setCoauth_role(strpath);
			
			coauthVO.setCoauth_seq(parseInt(strpath));
			
			
			list_coauth.add(coauthVO);
		}
		
		vo.setList_coauth(list_coauth);
		
	// 끝 << TB_COAUTH
		
		
	// TB_CONF >> 시작
		
		List<ConfVO> list_conf = new ArrayList<ConfVO>();
		
		NodeList nodelist2 = (NodeList) xpath.evaluate(strpath, rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist2.getLength(); i < n; i++){
			
			ConfVO confVO = new ConfVO();
			
			Node node = (Node) nodelist2.item(i);
			
			confVO.setConf_uid(strpath);
			confVO.setConf_id(parseInt(strpath));
			
			confVO.setConf_city(strpath);
			confVO.setConf_state(strpath);
			confVO.setConf_ctry(strpath);
			confVO.setConf_date(strpath);
			confVO.setConf_end(strpath);
			
			confVO.setConf_start(strpath);
			
			confVO.setConf_title(strpath);
			
			List<SponVO> list_spon = new ArrayList<SponVO>();
			
//			NodeList nodelist3 = (NodeList) xpath.evaluate(strpath, , XPathConstants.NODESET);
//			
//			for(int i1 = 0, n1 = nodelist3.getLength(); i1 < n1; i1++){
//				
//				SponVO sponVO = new SponVO();
//				
//				
//				list_spon.add(sponVO);
//			
//			}
			
			
			confVO.setList_spon(list_spon);
		}
		
		vo.setList_conf(list_conf);
		
	// 끝 << TB_CONF	
		
		
	// TB_CTGR >> 시작
		
		List<CtgrVO> list_ctgr = new ArrayList<CtgrVO>();
		
		NodeList nodelist4 = (NodeList) xpath.evaluate(strpath, rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist4.getLength(); i < n; i++){
			
			CtgrVO ctgrVO = new CtgrVO();
			
			Node node = (Node) nodelist4.item(i);
			
			ctgrVO.setCtgr_uid(vo.getArti_uid());
			
			ctgrVO.setCtgr_name(strpath);
			ctgrVO.setCtgr_sub(strpath);
			ctgrVO.setCtgr_subj(strpath);
			
			list_ctgr.add(ctgrVO);
		}
		
		
		
		vo.setList_ctgr(list_ctgr);
		
	// 끝 << TB_CTGR
		
	// TB_DTYPE >> 시작
		
		List<DtypeVO> list_dtype = new ArrayList<DtypeVO>();
		
		NodeList nodelist5 = (NodeList) xpath.evaluate(strpath, rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist5.getLength(); i < n; i++){
			
			Node node = (Node) nodelist5.item(i);
			
			DtypeVO dtypeVO = new DtypeVO();
			
			dtypeVO.setDtype_uid(vo.getArti_uid());
			
			dtypeVO.setDtype_name(strpath);
			
			list_dtype.add(dtypeVO);
		}
		
		vo.setList_dtype(list_dtype);
		
	// 끝 << TB_DTYPE
		
	// TB_GRNT >> 시작
		
		List<GrntVO> list_grnt = new ArrayList<GrntVO>();
		
		NodeList nodelist6 = (NodeList) xpath.evaluate(strpath, rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist6.getLength(); i < n; i++){
			
			Node node = (Node) nodelist6.item(i);
			
			GrntVO grntVO = new GrntVO();
			
			grntVO.setGrnt_uid(vo.getArti_uid());
			
			grntVO.setGrnt_agcy(strpath);
			
			grntVO.setGrnt_id(strpath);
			
			grntVO.setGrnt_text(strpath);
			
			list_grnt.add(grntVO);
			
		}
		
		vo.setList_grnt(list_grnt);
	// 끝 << TB_GRNT
		
	// TB_KWRD >> 시작
		
		List<KwrdVO> list_kwrd = new ArrayList<KwrdVO>();
		
		NodeList nodelist7 = (NodeList) xpath.evaluate(strpath, rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist7.getLength(); i < n; i++){
			
			Node node = (Node) nodelist7.item(i);
			
			KwrdVO kwrdVO = new KwrdVO();
			
			kwrdVO.setKwrd_uid(vo.getArti_uid());
			
			kwrdVO.setKwrd_name(strpath);
			
			list_kwrd.add(kwrdVO);
			
		}
		
		vo.setList_kwrd(list_kwrd);
		
	// 끝 << TB_KWRD
		
	// TB_REFR >> 시작
		
		List<RefrVO> list_refr = new ArrayList<RefrVO>();
		
		NodeList nodelist8 = (NodeList) xpath.evaluate(strpath, rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist8.getLength(); i < n; i++){
			
			Node node = (Node) nodelist8.item(i);
			
			RefrVO refrVO = new RefrVO();
			
			refrVO.setRefr_uid(vo.getArti_uid());
			
			refrVO.setRefr_auth(strpath);
			refrVO.setRefr_doi(strpath);
			refrVO.setRefr_issue(strpath);
			refrVO.setRefr_no(strpath);
			refrVO.setRefr_orgn(strpath);
			refrVO.setRefr_page(strpath);
			refrVO.setRefr_ruid(parseInt(strpath));
			refrVO.setRefr_title(strpath);
			refrVO.setRefr_vol(strpath);
			refrVO.setRefr_year(strpath);
			
			list_refr.add(refrVO);
			
		}
		
		vo.setList_refr(list_refr);
		
	// 끝 << TB_REFR
		

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
