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
import com.vinea.dto.BooknoteVO;
import com.vinea.dto.CoauthVO;
import com.vinea.dto.ConfVO;
import com.vinea.dto.DtypeVO;
import com.vinea.dto.GrntVO;
import com.vinea.dto.KwrdVO;
import com.vinea.dto.KwrdplusVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.PublVO;
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
				rec, XPathConstants.STRING)).equals("")){
			
			vo.setArti_cite_cnt((String) xpath.evaluate(".//refs/@count",
					rec, XPathConstants.STRING));
			
		}else{
			
			vo.setArti_cite_cnt((String) xpath.evaluate(".//references/@count",
					rec, XPathConstants.STRING));
			
		}
		
		
		vo.setArti_page_cnt((String) xpath.evaluate(".//page/@page_count",
				rec, XPathConstants.STRING));
		
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
		vo.setArti_item_page((String) xpath.evaluate("./static_data/item/bib_pagecount/text()",
				rec, XPathConstants.STRING));
		
		// 책 페이지 수
		vo.setArti_book_page((String) xpath.evaluate("./static_data/item/book_pages/text()",
				rec, XPathConstants.STRING));
		
		// 책 제본
		vo.setArti_book_bind((String) xpath.evaluate("./static_data/item/book_desc/bk_binding/text()",
				rec, XPathConstants.STRING));
		
		// 책 출판사
		vo.setArti_book_publ((String) xpath.evaluate("./static_data/item/book_desc/bk_publisher/text()",
				rec, XPathConstants.STRING));
		
		// 책 주문 정보
		vo.setArti_book_prepay((String) xpath.evaluate("./static_data/item/book_desc/bk_prepay/text()",
				rec, XPathConstants.STRING));
		
		
		//logger.info((String) xpath.evaluate("./static_data/fullrecord_metadata/category_info/headings/heading", rec, XPathConstants.STRING));

	      /** 카테고리 소제목 (구분자로 구분 바람) **/
	      NodeList subList = (NodeList) xpath.evaluate("./static_data/fullrecord_metadata/category_info/subheadings/subheading", rec, XPathConstants.NODESET);

	      String subhs = "";
	      String subjs="";
	      for (int i = 0, n = subList.getLength(); i < n; i++) {

	         String subh = subList.item(i).getTextContent();
	         
	         subhs+=(subh+"|");
	         
	         //logger.info(subh);
	      }

	      /** 카테고리 주제 (구분자로 구분 바람) **/
	      NodeList subjList = (NodeList) xpath.evaluate(
	            "./static_data/fullrecord_metadata/category_info/subjects/subject[@ascatype='traditional']", rec, XPathConstants.NODESET);

	      for (int i = 0, n = subjList.getLength(); i < n; i++) {

	         String subj = subjList.item(i).getTextContent();
	         subjs+=(subj+"|");
	         //logger.info(subj);
	      }

		//logger.info(subhs);
		//logger.info(subjs);
		
		vo.setArti_ctgr_name((String) xpath.evaluate("./static_data/fullrecord_metadata/category_info/headings/heading",
				rec, XPathConstants.STRING));
		
		vo.setArti_ctgr_subh(subhs);
		
		vo.setArti_ctgr_subj(subjs);
		
		
		
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
		
		NodeList nameNodeList = (NodeList) xpath.evaluate("./static_data/summary/names/name",
				rec, XPathConstants.NODESET);
		
		for (int i = 0, n = nameNodeList.getLength(); i < n; i++) {
			
			AuthVO authVO = new AuthVO();
			
			Node node = (Node) nameNodeList.item(i);
			
			authVO.setAuth_uid(vo.getArti_uid());
			
			authVO.setAuth_dais((String) xpath.evaluate("./@daisng_id", node, XPathConstants.STRING));
			
			authVO.setAuth_addr_no((String) xpath.evaluate("./@addr_no", node, XPathConstants.STRING));
			
			authVO.setAuth_dply((String) xpath.evaluate("./display_name", node, XPathConstants.STRING));
			
			authVO.setAuth_email((String) xpath.evaluate("./email_addr", node, XPathConstants.STRING));
			
			authVO.setAuth_first((String) xpath.evaluate("./first_name", node, XPathConstants.STRING));
			
			authVO.setAuth_full((String) xpath.evaluate("./full_name", node, XPathConstants.STRING));
			
			authVO.setAuth_last((String) xpath.evaluate("./last_name", node, XPathConstants.STRING));
			
			if ((String) xpath.evaluate("../name[@seq_no = '1']", node, XPathConstants.STRING) != null) {
				authVO.setAuth_lead("Y");
			}
			
			authVO.setAuth_repr((String) xpath.evaluate("./@reprint", node, XPathConstants.STRING));
			
			authVO.setAuth_role((String) xpath.evaluate("./@role", node, XPathConstants.STRING));
			
			
			
			authVO.setAuth_seq(parseInt((String) xpath.evaluate("./@seq_no", node, XPathConstants.STRING)));
			
			authVO.setAuth_wos((String) xpath.evaluate("./wos_standard", node, XPathConstants.STRING));
			
			list_auth.add(authVO);
			
		}
		
		vo.setList_auth(list_auth);
		
	// 끝 << TB_AUTH
		
		
	// TB_COAUTH >> 시작
		
		List<CoauthVO> list_coauth = new ArrayList<CoauthVO>();
		
		NodeList nodelist1 = (NodeList) xpath.evaluate("./static_data/contributors/contributor/name", rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist1.getLength(); i < n; i++){
			
			CoauthVO coauthVO = new CoauthVO();
			
			Node node = (Node) nodelist1.item(i);
			
			coauthVO.setCoauth_uid(vo.getArti_uid());
			
			coauthVO.setCoauth_dply((String) xpath.evaluate("./display_name", node, XPathConstants.STRING));
			
			coauthVO.setCoauth_first((String) xpath.evaluate("./first_name", node, XPathConstants.STRING));
			
			coauthVO.setCoauth_last((String) xpath.evaluate("./last_name", node, XPathConstants.STRING));
			
			coauthVO.setCoauth_full((String) xpath.evaluate("./full_name", node, XPathConstants.STRING));
			
			coauthVO.setCoauth_orcid((String) xpath.evaluate("./@orcid_id", node, XPathConstants.STRING));
			
			coauthVO.setCoauth_rid((String) xpath.evaluate("./@r_id", node, XPathConstants.STRING));
			
			coauthVO.setCoauth_role((String) xpath.evaluate("./@role", node, XPathConstants.STRING));
			
			coauthVO.setCoauth_seq(parseInt((String) xpath.evaluate("./@seq_no", node, XPathConstants.STRING)));
			
			list_coauth.add(coauthVO);
		}
		
		vo.setList_coauth(list_coauth);
		
	// 끝 << TB_COAUTH
		
		
	// TB_CONF >> 시작
		
		List<ConfVO> list_conf = new ArrayList<ConfVO>();
		
		NodeList nodelist2 = (NodeList) xpath.evaluate("./static_data/summary/conferences/conference", rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist2.getLength(); i < n; i++){
			
			ConfVO confVO = new ConfVO();
			
			Node node = (Node) nodelist2.item(i);
			
			confVO.setConf_uid(vo.getArti_uid());
			confVO.setConf_cid((String) xpath.evaluate("./@conf_id", node, XPathConstants.STRING));
			
			confVO.setConf_city((String) xpath.evaluate("./conf_locations/conf_location/conf_city", node, XPathConstants.STRING));
			confVO.setConf_state((String) xpath.evaluate("./conf_locations/conf_location/conf_state", node, XPathConstants.STRING));
			confVO.setConf_ctry("");
			confVO.setConf_date((String) xpath.evaluate("./conf_dates/conf_date", node, XPathConstants.STRING));
			confVO.setConf_end((String) xpath.evaluate("./conf_dates/conf_date/@conf_end", node, XPathConstants.STRING));
			
			confVO.setConf_start((String) xpath.evaluate("./conf_dates/conf_date/@conf_start", node, XPathConstants.STRING));
			
			confVO.setConf_title((String) xpath.evaluate("./conf_titles/conf_title", node, XPathConstants.STRING));
			
			
			// TB_SPON >> 시작
			List<SponVO> list_spon = new ArrayList<SponVO>();
			
			
			NodeList nodelist3 = (NodeList) xpath.evaluate("./sponsors/sponsor", node, XPathConstants.NODESET);
			
			for(int i1 = 0, n1 = nodelist3.getLength(); i1 < n1; i1++){
				
				SponVO sponVO = new SponVO();
				
				Node node2 = (Node) nodelist3.item(i);
				
				sponVO.setSpon_conf_id(confVO.getConf_cid());
				
				sponVO.setSpon_name((String) xpath.evaluate("./text()", node2, XPathConstants.STRING));
				
				list_spon.add(sponVO);
			
			}
			
			// 끝 << TB_SPON
			confVO.setList_spon(list_spon);
			
			
		}
		
		vo.setList_conf(list_conf);
		
	// 끝 << TB_CONF	
		
		
	// TB_DTYPE >> 시작
		
		List<DtypeVO> list_dtype = new ArrayList<DtypeVO>();
		
		NodeList nodelist5 = (NodeList) xpath.evaluate("./static_data/summary/doctypes", rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist5.getLength(); i < n; i++){
			
			Node node = (Node) nodelist5.item(i);
			
			DtypeVO dtypeVO = new DtypeVO();
			
			dtypeVO.setDtype_uid(vo.getArti_uid());
			
			//구분자 아직 안함 
			
			String dtype_names="";
			
			NodeList doctypeList = (NodeList) xpath.evaluate("./doctype", node, XPathConstants.NODESET);
			
			for(int i1 = 0, n1 = doctypeList.getLength(); i1 < n1; i1++){
				Node doctypeNode = doctypeList.item(i1);
				
				String dtype_name=(String) xpath.evaluate("./text()", doctypeNode,XPathConstants.STRING);
				
				dtype_names+=dtype_name;
				dtype_names+="|";
				//logger.info(vo.getArti_uid()+": "+dtype_name);
				
			}
			
			
			//logger.info(vo.getArti_uid()+": "+dtype_names);
			
			dtypeVO.setDtype_name(dtype_names);
			
			list_dtype.add(dtypeVO);
		}
		
		vo.setList_dtype(list_dtype);
		
	// 끝 << TB_DTYPE
		
	// TB_GRNT >> 시작
		
		List<GrntVO> list_grnt = new ArrayList<GrntVO>();
		
		NodeList nodelist6 = (NodeList) xpath.evaluate("./static_data/fullrecord_metadata/fund_ack", rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist6.getLength(); i < n; i++){
			
			Node node = (Node) nodelist6.item(i);
			
			GrntVO grntVO = new GrntVO();
			
			grntVO.setGrnt_uid(vo.getArti_uid());
			
			grntVO.setGrnt_agcy((String) xpath.evaluate("./grants/grant/grant_agency/text()", node, XPathConstants.STRING));
			
			grntVO.setGrnt_gid((String) xpath.evaluate("./grants/grant/grant_ids/grant_id", node, XPathConstants.STRING));
			
			grntVO.setGrnt_text((String) xpath.evaluate("./fund_text/p/text()", node, XPathConstants.STRING));
			
			list_grnt.add(grntVO);
			
		}
		
		vo.setList_grnt(list_grnt);
	// 끝 << TB_GRNT
		
	// TB_KWRD >> 시작
		
		List<KwrdVO> list_kwrd = new ArrayList<KwrdVO>();
		
		NodeList nodelist7 = (NodeList) xpath.evaluate("./static_data/fullrecord_metadata/keywords/keyword", rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist7.getLength(); i < n; i++){
			
			Node node = (Node) nodelist7.item(i);
			
			KwrdVO kwrdVO = new KwrdVO();
			
			kwrdVO.setKwrd_uid(vo.getArti_uid());
			
			kwrdVO.setKwrd_name((String) xpath.evaluate("./text()", node, XPathConstants.STRING));
			
			list_kwrd.add(kwrdVO);
			
		}
		
		vo.setList_kwrd(list_kwrd);
		
	// 끝 << TB_KWRD
		
	// TB_REFR >> 시작
		
		List<RefrVO> list_refr = new ArrayList<RefrVO>();
		
		NodeList nodelist8 = (NodeList) xpath.evaluate("./static_data/fullrecord_metadata/references/reference", rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist8.getLength(); i < n; i++){
			
			Node node = (Node) nodelist8.item(i);
			
			RefrVO refrVO = new RefrVO();
			
			refrVO.setRefr_uid(vo.getArti_uid());
			
			refrVO.setRefr_auth((String) xpath.evaluate("./citedAuthor", node, XPathConstants.STRING));
			refrVO.setRefr_doi((String) xpath.evaluate("./doi", node, XPathConstants.STRING));
			refrVO.setRefr_issue("");
			refrVO.setRefr_orgn((String) xpath.evaluate("./citedWork", node, XPathConstants.STRING));
			refrVO.setRefr_page((String) xpath.evaluate("./page", node, XPathConstants.STRING));
			refrVO.setRefr_ruid((String) xpath.evaluate("./uid", node, XPathConstants.STRING));
			refrVO.setRefr_title((String) xpath.evaluate("./citedTitle", node, XPathConstants.STRING));
			refrVO.setRefr_vol((String) xpath.evaluate("./volume", node, XPathConstants.STRING));
			refrVO.setRefr_year((String) xpath.evaluate("./year", node, XPathConstants.STRING));
			
			list_refr.add(refrVO);
			
		}
		
		vo.setList_refr(list_refr);
		
	// 끝 << TB_REFR
		
	// TB_BOOKNOTE >> 시작
		
		List<BooknoteVO> list_booknote = new ArrayList<BooknoteVO>();
		
		NodeList nodelist9 = (NodeList) xpath.evaluate("./static_data/item/book_notes/book_note", rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist9.getLength(); i < n; i++){
			
			Node node = (Node) nodelist9.item(i);
			
			BooknoteVO booknoteVO = new BooknoteVO();

			booknoteVO.setNote_uid(vo.getArti_uid());
			
			
			// 구분자 아직 안함
			booknoteVO.setNote_name("");
			
			list_booknote.add(booknoteVO);
			
		}
		
		vo.setList_booknote(list_booknote);
		
	// 끝 << TB_BOOKNOTE
		
	// TB_ORGN >> 시작
		
		List<OrgnVO> list_orgn = new ArrayList<OrgnVO>();
		
		NodeList nodelist10 = (NodeList) xpath.evaluate("./static_data/fullrecord_metadata/addresses/address_name/address_spec", rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist10.getLength(); i < n; i++){
			
			Node node = (Node) nodelist10.item(i);
			
			OrgnVO orgnVO = new OrgnVO();
			
			orgnVO.setOrgn_uid(vo.getArti_uid());
			
			
			orgnVO.setOrgn_addr_no((String) xpath.evaluate("./@addr_no", node, XPathConstants.STRING));
			orgnVO.setOrgn_city((String) xpath.evaluate("./city", node, XPathConstants.STRING));
			orgnVO.setOrgn_ctry((String) xpath.evaluate("./country", node, XPathConstants.STRING));
			orgnVO.setOrgn_full((String) xpath.evaluate("./full_address", node, XPathConstants.STRING));
			orgnVO.setOrgn_name((String) xpath.evaluate("./organizations/organization[count(@*)=0]", node, XPathConstants.STRING));
			orgnVO.setOrgn_pref((String) xpath.evaluate("./organizations/organization[@pref = 'Y']", node, XPathConstants.STRING));
			orgnVO.setOrgn_state((String) xpath.evaluate("./state", node, XPathConstants.STRING));
			orgnVO.setOrgn_street((String) xpath.evaluate("./street", node, XPathConstants.STRING));
			orgnVO.setOrgn_sub((String) xpath.evaluate("./suborganizations/suborganization", node, XPathConstants.STRING));
			
			list_orgn.add(orgnVO);
			
		}
		
		vo.setList_orgn(list_orgn);
		
	// 끝 << TB_ORGN
		
	// TB_PUBL >> 시작
		
		List<PublVO> list_publ = new ArrayList<PublVO>();
		
		NodeList nodelist11 = (NodeList) xpath.evaluate("./static_data/summary/publishers/publisher", rec, XPathConstants.NODESET);
		
		for(int i = 0, n = nodelist11.getLength(); i < n; i++){
			
			Node node = (Node) nodelist11.item(i);
			
			PublVO publVO = new PublVO();
			
			publVO.setPubl_uid(vo.getArti_uid());
			
			publVO.setPubl_addr((String) xpath.evaluate("./address_spec/full_address", node, XPathConstants.STRING));
			publVO.setPubl_city((String) xpath.evaluate("./address_spec/city", node, XPathConstants.STRING));
			publVO.setPubl_ctry("");
			publVO.setPubl_dply((String) xpath.evaluate("./names/name/display_name", node, XPathConstants.STRING));
			publVO.setPubl_full((String) xpath.evaluate("./names/name/full_name", node, XPathConstants.STRING));
			publVO.setPubl_state("");
			
			list_publ.add(publVO);
			
		}
		
		vo.setList_publ(list_publ);
		
	// 끝 << TB_PUBL
		
		
		
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
