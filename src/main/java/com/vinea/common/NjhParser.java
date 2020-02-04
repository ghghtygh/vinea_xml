package com.vinea.common;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
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

	private String filePath = "";

	public NjhParser(String filePath) throws Exception {

		this.filePath = filePath;

		logger = LoggerFactory.getLogger(NjhParser.class);

		listvo = new ArrayList<ArtiVO>();

		xpath = XPathFactory.newInstance().newXPath();

	}

	public void Test1() throws Exception {

		FileReader fr = null;

		BufferedReader br = null;

		try {

			fr = new FileReader(filePath);
			br = new BufferedReader(fr);

			int count = 0;
			int rec_count = 0;
			int tmp_rec = 0;
			String str = null;
			Date date = null;
			date = new Date();
			long start = date.getTime();

			Boolean m_rec = false;

			String recTag = "";
			while ((str = br.readLine()) != null) {

				if (str.contains("<REC")) {
					m_rec = true;

				}

				if (m_rec) {
					recTag += str;
				}

				if (str.contains("</REC>")) {

					// rec 태그 개수 증가
					rec_count++;

					// str에 그만추가
					m_rec = false;
				}

				if (rec_count > tmp_rec) {
					tmp_rec = rec_count;
					// REC 태그 완성

					
					System.out.println(recTag);
					
					//String -> dom 객체
					Node node = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new ByteArrayInputStream(recTag.getBytes())).getDocumentElement();
									
					ArtiVO vo = parseREC(node);
					
					logger.info(vo.toStringMultiline());
					
					recTag = "";
					break;
				}

				count++;
			}
			date = new Date();
			long end = date.getTime();

			logger.info("REC 태그 : " + Integer.toString(rec_count));
			logger.info("전체 라인 : " + Integer.toString(count));
			logger.info("걸린시간 :" + Long.toString(((end - start) / 1000)));

		} catch (Exception e) {

			e.printStackTrace();

		} finally {

			if (fr != null)
				fr.close();

			if (br != null)
				br.close();

		}

	}
	
	

	public boolean CanParse() {

		try {

			document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(filePath);

			return true;

		} catch (Exception e) {

			return false;

		}

	}

	public void DoParse() throws Exception {

		/** 논문 XML(API) 데이터의 가장 상위의 노드를 지정 **/
		NodeList recs = (NodeList) xpath.evaluate("//REC", document, XPathConstants.NODESET);

		for (int i = 0, n = recs.getLength(); i < n; i++) {

			ArtiVO vo = parseREC((Node) recs.item(i));
			
			

			listvo.add(vo);
		}

	}


	public ArtiVO parseREC(Node rec) throws Exception {

		ArtiVO vo = new ArtiVO();

		/** TB_ARTI(논문정보) 테이블에 저장할 내용 파싱 시작 **/
		/* 논문번호 */
		vo.setArti_no((String) xpath.evaluate(".//identifier[@type='art_no']/@value", rec, XPathConstants.STRING));
		/* 논문UID */
		vo.setArti_uid((String) xpath.evaluate(".//UID/text()", rec, XPathConstants.STRING));
		/* 논문제목 */
		vo.setArti_title((String) xpath.evaluate(".//title[@type='item']", rec, XPathConstants.STRING));
		/* 학술지명 */
		vo.setArti_source_title((String) xpath.evaluate(".//title[@type='source']", rec, XPathConstants.STRING));
		/* 발행년도 */
		vo.setArti_year((String) xpath.evaluate(".//pub_info/@pubyear", rec, XPathConstants.STRING));
		/* 발행일자 */
		vo.setArti_date((String) xpath.evaluate(".//pub_info/@sortdate", rec, XPathConstants.STRING));
		/* 권번호 */
		vo.setArti_vol((String) xpath.evaluate(".//pub_info/@vol", rec, XPathConstants.STRING));
		/* 호번호 */
		vo.setArti_issue((String) xpath.evaluate(".//pub_info/@issue", rec, XPathConstants.STRING));
		/* 부록수 */
		vo.setArti_sup((String) xpath.evaluate(".//pub_info/@supplement", rec, XPathConstants.STRING));
		/* DOI 식별자 번호 */
		vo.setArti_doi(
				(String) xpath.evaluate(".//identifier[contains(@type, 'doi')]/@value", rec, XPathConstants.STRING));
		/* 초록 */
		vo.setArti_ab((String) xpath.evaluate(".//abstract_text/p", rec, XPathConstants.STRING));
		/* 국제연속간행물번호 */
		vo.setArti_issn((String) xpath.evaluate(".//identifier[@type='issn']/@value", rec, XPathConstants.STRING));
		/* 전자국제연속간행물번호 */
		vo.setArti_eissn((String) xpath.evaluate(".//identifier[@type='eissn']/@value", rec, XPathConstants.STRING));
		/* 참고문헌수 */
		/** 각 API(XML) 파일이  노드명이 달라서 조건문 사용 **/
		if (((String) xpath.evaluate(".//references/@count", rec, XPathConstants.STRING)).equals("")) {

			vo.setArti_cite_cnt((String) xpath.evaluate(".//refs/@count", rec, XPathConstants.STRING));

		} else {

			vo.setArti_cite_cnt((String) xpath.evaluate(".//references/@count", rec, XPathConstants.STRING));

		}

		/* 논문 페이지수 */
		vo.setArti_page_cnt((String) xpath.evaluate(".//page/@page_count", rec, XPathConstants.STRING));
		/* 논문 시작페이지 */	
		vo.setArti_bp((String) xpath.evaluate(".//page/@begin", rec, XPathConstants.STRING));
		/* 논문 종료페이지 */	
		vo.setArti_ep((String) xpath.evaluate(".//page/@end", rec, XPathConstants.STRING));
		/* 논문 자료열람여부 */
		vo.setArti_oa((String) xpath.evaluate(".//pub_info/@journal_oas_gold", rec, XPathConstants.STRING));

		/* 간행물 아이디 */
		vo.setArti_item_id((String) xpath.evaluate("./static_data/item/ids/text()", rec, XPathConstants.STRING));

		/* 간행물 사용여부 */
		vo.setArti_item_avail((String) xpath.evaluate("./static_data/item/ids/@avail", rec, XPathConstants.STRING));

		/* 간행물 종류 */
		vo.setArti_item_type(
				(String) xpath.evaluate("./static_data/item/bib_pagecount/@type", rec, XPathConstants.STRING));

		/* 간행물_페이지 수 */
		vo.setArti_item_page(
				(String) xpath.evaluate("./static_data/item/bib_pagecount/text()", rec, XPathConstants.STRING));

		/* 도서 페이지 수 */
		vo.setArti_book_page(
				(String) xpath.evaluate("./static_data/item/book_pages/text()", rec, XPathConstants.STRING));

		/* 도서 제본 정보 */
		vo.setArti_book_bind(
				(String) xpath.evaluate("./static_data/item/book_desc/bk_binding/text()", rec, XPathConstants.STRING));

		/* 도서 출판사 */
		vo.setArti_book_publ((String) xpath.evaluate("./static_data/item/book_desc/bk_publisher/text()", rec,
				XPathConstants.STRING));

		/* 도서 주문 정보 */
		vo.setArti_book_prepay(
				(String) xpath.evaluate("./static_data/item/book_desc/bk_prepay/text()", rec, XPathConstants.STRING));
		
		/* 카테고리(연구분야) */
		vo.setArti_ctgr_name((String) xpath.evaluate("./static_data/fullrecord_metadata/category_info/headings/heading",
				rec, XPathConstants.STRING));

		/* 카테고리(연구분야) 부제 */
		NodeList subList = (NodeList) xpath.evaluate(
				"./static_data/fullrecord_metadata/category_info/subheadings/subheading", rec, XPathConstants.NODESET);

		String subhs = "";
		String subjs = "";
		for (int i = 0, n = subList.getLength(); i < n; i++) {

			String subh = subList.item(i).getTextContent();

			/** 부제는 2개 이상이 나올 수 있으므로 구분자 '|'로 구분 **/
			subhs += (subh + "|");

		}
		
		vo.setArti_ctgr_subh(subhs);

		/* 카테고리(연구분야) 주제 */
		NodeList subjList = (NodeList) xpath.evaluate(
				"./static_data/fullrecord_metadata/category_info/subjects/subject[@ascatype='traditional']", rec,
				XPathConstants.NODESET);

		for (int i = 0, n = subjList.getLength(); i < n; i++) {

			String subj = subjList.item(i).getTextContent();
			
			/** 연구분야 당 주제는 2개 이상이 나올 수 있으므로 구분자 '|'로 구분 **/
			subjs += (subj + "|");
	
		}
		
		vo.setArti_ctgr_subj(subjs);		
		/** TB_ARTI(논문정보) 테이블에 저장할 내용 파싱  종료 **/

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/** TB_KWRD_PLUS(간행물_키워드정보) 테이블에 저장할 내용 파싱  시작 **/		
		/* 간행물 키워드 정보는 여러개 있으므로 리스트로 저장 */
		List<KwrdplusVO> list_kwrdplus = new ArrayList<KwrdplusVO>();

		NodeList keywordsPlusNodeList = (NodeList) xpath.evaluate("./static_data/item/keywords_plus/keyword", rec,
				XPathConstants.NODESET);

		for (int j = 0, m = keywordsPlusNodeList.getLength(); j < m; j++) {

			KwrdplusVO kwrdplusVO = new KwrdplusVO();

			Node keywordsPlusNode = keywordsPlusNodeList.item(j);

			kwrdplusVO.setKwrdp_uid(vo.getArti_uid());

			kwrdplusVO.setKwrdp_name((String) xpath.evaluate("./text()", keywordsPlusNode, XPathConstants.STRING));

			list_kwrdplus.add(kwrdplusVO);
		}

		vo.setList_kwrdplus(list_kwrdplus);
		/** TB_KWRD_PLUS(간행물_키워드정보) 테이블에 저장할 내용 파싱  종료 **/

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/** TB_AUTH(저자 정보) 테이블에 저장할 내용 파싱  시작 **/
		/* 한 논문에 여러 저자가 존재하므로 리스트로 저장 */
		List<AuthVO> list_auth = new ArrayList<AuthVO>();

		NodeList nameNodeList = (NodeList) xpath.evaluate("./static_data/summary/names/name", rec,
				XPathConstants.NODESET);

		for (int i = 0, n = nameNodeList.getLength(); i < n; i++) {

			AuthVO authVO = new AuthVO();

			Node node = (Node) nameNodeList.item(i);

			/* TB_ARTI의 논문 UID를 가져와 DB 저장 */
			authVO.setAuth_uid(vo.getArti_uid());
			
			/* 저자 해당 아이디 */
			authVO.setAuth_dais((String) xpath.evaluate("./@daisng_id", node, XPathConstants.STRING));
			/* 저자 주소 번호_연구기관과 매칭시킬때 필요 */
			authVO.setAuth_addr_no((String) xpath.evaluate("./@addr_no", node, XPathConstants.STRING));
			/* 저자 이름_레코드 표기 */
			authVO.setAuth_dply((String) xpath.evaluate("./display_name", node, XPathConstants.STRING));
			/* 저자 이메일 주소 */
			authVO.setAuth_email((String) xpath.evaluate("./email_addr", node, XPathConstants.STRING));
			/* 저자 풀네임 */
			authVO.setAuth_full((String) xpath.evaluate("./full_name", node, XPathConstants.STRING));
			/* 저자 이름 */
			authVO.setAuth_first((String) xpath.evaluate("./first_name", node, XPathConstants.STRING));
			/* 저자 성 */
			authVO.setAuth_last((String) xpath.evaluate("./last_name", node, XPathConstants.STRING));
			/* 저자 wos 기준 이름 */
			authVO.setAuth_wos((String) xpath.evaluate("./wos_standard", node, XPathConstants.STRING));
			
			/* 저자 seq_no */
			authVO.setAuth_seq(parseInt((String) xpath.evaluate("./@seq_no", node, XPathConstants.STRING)));
			/** 저자의 seq_no가 1일때 주저자로 표시 **/
			if ((String) xpath.evaluate("../name[@seq_no = '1']", node, XPathConstants.STRING) != null) {
				authVO.setAuth_lead("Y");
			}

			/* 저자의 교신 여부 */
			authVO.setAuth_repr((String) xpath.evaluate("./@reprint", node, XPathConstants.STRING));
			/* 저자 역할 */
			authVO.setAuth_role((String) xpath.evaluate("./@role", node, XPathConstants.STRING));

			list_auth.add(authVO);

		}

		vo.setList_auth(list_auth);
		/** TB_AUTH(저자 정보) 테이블에 저장할 내용 파싱  종료 **/

		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/** TB_COAUTH(공저자 정보) 테이블에 저장할 내용 파싱  시작 **/
		/* 공저자는 여러명이므로 리스트에 저장 */
		List<CoauthVO> list_coauth = new ArrayList<CoauthVO>();

		NodeList nodelist1 = (NodeList) xpath.evaluate("./static_data/contributors/contributor/name", rec,
				XPathConstants.NODESET);

		for (int i = 0, n = nodelist1.getLength(); i < n; i++) {

			CoauthVO coauthVO = new CoauthVO();

			Node node = (Node) nodelist1.item(i);

			/* TB_ARTI의 논문 UID를 가져와 DB 저장 */
			coauthVO.setCoauth_uid(vo.getArti_uid());
			
			/* 공저자 이름_레코드 표기 */
			coauthVO.setCoauth_dply((String) xpath.evaluate("./display_name", node, XPathConstants.STRING));
			/* 공저자 풀네임 */
			coauthVO.setCoauth_full((String) xpath.evaluate("./full_name", node, XPathConstants.STRING));
			/* 공저자 이름 */
			coauthVO.setCoauth_first((String) xpath.evaluate("./first_name", node, XPathConstants.STRING));
			/* 공저자 성 */
			coauthVO.setCoauth_last((String) xpath.evaluate("./last_name", node, XPathConstants.STRING));
			/* 공저자 아이디(orcid_id)_과학자와 다른학문자를 구별하기 위한 식별자 코드 */
			coauthVO.setCoauth_orcid((String) xpath.evaluate("./@orcid_id", node, XPathConstants.STRING));
			/* 공저자 연구아이디(research_id) */
			coauthVO.setCoauth_rid((String) xpath.evaluate("./@r_id", node, XPathConstants.STRING));
			/* 공저자 역할 */
			coauthVO.setCoauth_role((String) xpath.evaluate("./@role", node, XPathConstants.STRING));
			/* 공저자 seq_no */
			coauthVO.setCoauth_seq(parseInt((String) xpath.evaluate("./@seq_no", node, XPathConstants.STRING)));

			list_coauth.add(coauthVO);
		}

		vo.setList_coauth(list_coauth);
		/** TB_COAUTH(공저자 정보) 테이블에 저장할 내용 파싱  종료 **/
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/** TB_CONF(학회 정보) 테이블에 저장할 내용 파싱  시작 **/
		List<ConfVO> list_conf = new ArrayList<ConfVO>();

		NodeList nodelist2 = (NodeList) xpath.evaluate("./static_data/summary/conferences/conference", rec,
				XPathConstants.NODESET);

		for (int i = 0, n = nodelist2.getLength(); i < n; i++) {

			ConfVO confVO = new ConfVO();

			Node node = (Node) nodelist2.item(i);
			
			/* TB_ARTI의 논문 UID를 가져와 DB 저장 */
			confVO.setConf_uid(vo.getArti_uid());
			
			/* 학회 아이디 */
			confVO.setConf_cid((String) xpath.evaluate("./@conf_id", node, XPathConstants.STRING));
			/* 학회명 */
			confVO.setConf_title((String) xpath.evaluate("./conf_titles/conf_title", node, XPathConstants.STRING));
			/* 학회 날짜 */
			confVO.setConf_date((String) xpath.evaluate("./conf_dates/conf_date", node, XPathConstants.STRING));
			/* 학회 시작일 */
			confVO.setConf_start((String) xpath.evaluate("./conf_dates/conf_date/@conf_start", node, XPathConstants.STRING));
			/* 학회 종료일 */
			confVO.setConf_end((String) xpath.evaluate("./conf_dates/conf_date/@conf_end", node, XPathConstants.STRING));
			/* 학회 장소_도시 */
			confVO.setConf_city((String) xpath.evaluate("./conf_locations/conf_location/conf_city", node, XPathConstants.STRING));
			/* 학회 장소_주 */
			confVO.setConf_state((String) xpath.evaluate("./conf_locations/conf_location/conf_state", node, XPathConstants.STRING));
			/* 학회 장소_나라(나라 정보는 논문 데이터에 없어서 임시로 공백표기) */
			confVO.setConf_ctry("");
			
			/** TB_CONF(학회 정보) 아래 TB_SPON(후원기관 정보) 테이블에 저장할 내용 파싱  시작 **/
			List<SponVO> list_spon = new ArrayList<SponVO>();

			NodeList nodelist3 = (NodeList) xpath.evaluate("./sponsors/sponsor", node, XPathConstants.NODESET);

			for (int i1 = 0, n1 = nodelist3.getLength(); i1 < n1; i1++) {

				SponVO sponVO = new SponVO();

				Node node2 = (Node) nodelist3.item(i);

				/* TB_CONF의 학회정보 아이디와 후원기관 아이디 매칭 */
				sponVO.setSpon_conf_id(confVO.getConf_cid());
				/* 후원기관명 */
				sponVO.setSpon_name((String) xpath.evaluate("./text()", node2, XPathConstants.STRING));

				list_spon.add(sponVO);

			}
			/** TB_CONF(학회 정보) 아래 TB_SPON(후원기관 정보) 테이블에 저장할 내용 파싱  종료 **/
			
			confVO.setList_spon(list_spon);
			list_conf.add(confVO);

		}

		vo.setList_conf(list_conf);
		/** TB_CONF(학회 정보) 테이블에 저장할 내용 파싱  종료 **/
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/** TB_DTYPE(문서유형) 테이블에 저장할 내용 파싱  시작 **/
		List<DtypeVO> list_dtype = new ArrayList<DtypeVO>();

		NodeList nodelist5 = (NodeList) xpath.evaluate("./static_data/summary/doctypes", rec, XPathConstants.NODESET);

		for (int i = 0, n = nodelist5.getLength(); i < n; i++) {

			Node node = (Node) nodelist5.item(i);

			DtypeVO dtypeVO = new DtypeVO();

			/* TB_ARTI의 논문 UID를 가져와 DB 저장 */
			dtypeVO.setDtype_uid(vo.getArti_uid());

			String dtype_names = "";

			NodeList doctypeList = (NodeList) xpath.evaluate("./doctype", node, XPathConstants.NODESET);

			for (int i1 = 0, n1 = doctypeList.getLength(); i1 < n1; i1++) {
				Node doctypeNode = doctypeList.item(i1);

				String dtype_name = (String) xpath.evaluate("./text()", doctypeNode, XPathConstants.STRING);

				dtype_names += dtype_name;
				/** 문서유형은 논문당 2개 이상이 나올 수 있으므로 구분자 '|'로 구분 **/
				dtype_names += "|";

			}

			dtypeVO.setDtype_name(dtype_names);

			list_dtype.add(dtypeVO);
		}

		vo.setList_dtype(list_dtype);
		/** TB_DTYPE(문서유형) 테이블에 저장할 내용 파싱  종료 **/
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/** TB_GRNT(자금기관) 테이블에 저장할 내용 파싱  시작 **/
		List<GrntVO> list_grnt = new ArrayList<GrntVO>();

		NodeList nodelist6 = (NodeList) xpath.evaluate("./static_data/fullrecord_metadata/fund_ack", rec,
				XPathConstants.NODESET);

		for (int i = 0, n = nodelist6.getLength(); i < n; i++) {

			Node node = (Node) nodelist6.item(i);

			GrntVO grntVO = new GrntVO();
			/* TB_ARTI의 논문 UID를 가져와 DB 저장 */
			grntVO.setGrnt_uid(vo.getArti_uid());
			
			/* 자금 후원정보(요약) */
			grntVO.setGrnt_text((String) xpath.evaluate("./fund_text/p/text()", node, XPathConstants.STRING));
			/* 자금기관 아이디 */
			grntVO.setGrnt_gid((String) xpath.evaluate("./grants/grant/grant_ids/grant_id", node, XPathConstants.STRING));
			/* 자금기관 정보 */
			grntVO.setGrnt_agcy((String) xpath.evaluate("./grants/grant/grant_agency/text()", node, XPathConstants.STRING));
	
			list_grnt.add(grntVO);

		}

		vo.setList_grnt(list_grnt);
		/** TB_GRNT(자금기관) 테이블에 저장할 내용 파싱  종료 **/
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/** TB_KWRD(논문 키워드) 테이블에 저장할 내용 파싱  시작 **/
		List<KwrdVO> list_kwrd = new ArrayList<KwrdVO>();

		NodeList nodelist7 = (NodeList) xpath.evaluate("./static_data/fullrecord_metadata/keywords/keyword", rec,
				XPathConstants.NODESET);

		for (int i = 0, n = nodelist7.getLength(); i < n; i++) {

			Node node = (Node) nodelist7.item(i);

			KwrdVO kwrdVO = new KwrdVO();
			
			/* TB_ARTI의 논문 UID를 가져와 DB 저장 */
			kwrdVO.setKwrd_uid(vo.getArti_uid());
			
			/* 키워드명 */
			kwrdVO.setKwrd_name((String) xpath.evaluate("./text()", node, XPathConstants.STRING));

			list_kwrd.add(kwrdVO);

		}

		vo.setList_kwrd(list_kwrd);
		/** TB_KWRD(논문 키워드) 테이블에 저장할 내용 파싱  종료 **/
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/** TB_REFR(참고문헌 정보) 테이블에 저장할 내용 파싱  시작 **/
		List<RefrVO> list_refr = new ArrayList<RefrVO>();

		NodeList nodelist8 = (NodeList) xpath.evaluate("./static_data/fullrecord_metadata/references/reference", rec,
				XPathConstants.NODESET);

		for (int i = 0, n = nodelist8.getLength(); i < n; i++) {

			Node node = (Node) nodelist8.item(i);

			RefrVO refrVO = new RefrVO();
			
			/* TB_ARTI의 논문 UID를 가져와 DB 저장 */
			refrVO.setRefr_uid(vo.getArti_uid());
			
			/* 참고문헌(논문) UID */
			refrVO.setRefr_ruid((String) xpath.evaluate("./uid", node, XPathConstants.STRING));
			/* 참고문헌(논문) 제목 */
			refrVO.setRefr_title((String) xpath.evaluate("./citedTitle", node, XPathConstants.STRING));
			/* 참고문헌(논문) 발행년도 */
			refrVO.setRefr_year((String) xpath.evaluate("./year", node, XPathConstants.STRING));
			/* 참고문헌(논문) 저자 */
			refrVO.setRefr_auth((String) xpath.evaluate("./citedAuthor", node, XPathConstants.STRING));
			/* 연구기관 */
			refrVO.setRefr_orgn((String) xpath.evaluate("./citedWork", node, XPathConstants.STRING));
			/* 참고문헌(논문) 권번호 */
			refrVO.setRefr_vol((String) xpath.evaluate("./volume", node, XPathConstants.STRING));
			/* 참고문헌(논문) 호번호 */
			/** 참고문헌의 호번호는 논문 데이터에 존재하지 않아 임시로 공백표기 **/
			refrVO.setRefr_issue("");
			/* 참고(인용한) 페이지 번호 */
			refrVO.setRefr_page((String) xpath.evaluate("./page", node, XPathConstants.STRING));
			/* 참고문헌(논문) DOI 식별자 번호 */
			refrVO.setRefr_doi((String) xpath.evaluate("./doi", node, XPathConstants.STRING));

			list_refr.add(refrVO);

		}

		vo.setList_refr(list_refr);
		/** TB_REFR(참고문헌 정보) 테이블에 저장할 내용 파싱  종료 **/
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/** TB_BOOKNOTE 테이블에 저장할 내용 파싱  시작 **/
		List<BooknoteVO> list_booknote = new ArrayList<BooknoteVO>();

		NodeList nodelist9 = (NodeList) xpath.evaluate("./static_data/item/book_notes/book_note", rec,
				XPathConstants.NODESET);

		for (int i = 0, n = nodelist9.getLength(); i < n; i++) {

			Node node = (Node) nodelist9.item(i);

			BooknoteVO booknoteVO = new BooknoteVO();

			/* TB_ARTI의 논문 UID를 가져와 DB 저장 */
			booknoteVO.setNote_uid(vo.getArti_uid());

			/* 생략 */
			booknoteVO.setNote_name("");

			list_booknote.add(booknoteVO);

		}

		vo.setList_booknote(list_booknote);
		/** TB_BOOKNOTE 테이블에 저장할 내용 파싱  종료 **/
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/** TB_ORGN(연구기관) 테이블에 저장할 내용 파싱  시작 **/
		List<OrgnVO> list_orgn = new ArrayList<OrgnVO>();

		NodeList nodelist10 = (NodeList) xpath.evaluate(
				"./static_data/fullrecord_metadata/addresses/address_name/address_spec", rec, XPathConstants.NODESET);

		for (int i = 0, n = nodelist10.getLength(); i < n; i++) {

			Node node = (Node) nodelist10.item(i);

			OrgnVO orgnVO = new OrgnVO();

			/* TB_ARTI의 논문 UID를 가져와 DB 저장 */
			orgnVO.setOrgn_uid(vo.getArti_uid());
			
			/* 기관의 주소번호_저자의 주소번호 매칭시 필요 */
			orgnVO.setOrgn_addr_no((String) xpath.evaluate("./@addr_no", node, XPathConstants.STRING));
			/* 기관명 */
			/** 속성이 없는 노드의 정보를 가져오기 위한 정규표현 **/
			orgnVO.setOrgn_name((String) xpath.evaluate("./organizations/organization[count(@*)=0]", node, XPathConstants.STRING));
			/* 기관명 풀네임 */
			orgnVO.setOrgn_full((String) xpath.evaluate("./full_address", node, XPathConstants.STRING));
			/* 자세한 기관명 */
			orgnVO.setOrgn_pref((String) xpath.evaluate("./organizations/organization[@pref = 'Y']", node, XPathConstants.STRING));
			/* 기관 주소정보_도시 */
			orgnVO.setOrgn_city((String) xpath.evaluate("./city", node, XPathConstants.STRING));
			/* 기관 주소정보_나라 */
			orgnVO.setOrgn_ctry((String) xpath.evaluate("./country", node, XPathConstants.STRING));
			/* 기관 주소정보_주 */
			orgnVO.setOrgn_state((String) xpath.evaluate("./state", node, XPathConstants.STRING));
			/* 기관 주소정보_도로명 */
			orgnVO.setOrgn_street((String) xpath.evaluate("./street", node, XPathConstants.STRING));
			/* 하위기관명 */
			orgnVO.setOrgn_sub((String) xpath.evaluate("./suborganizations/suborganization", node, XPathConstants.STRING));

			list_orgn.add(orgnVO);

		}

		vo.setList_orgn(list_orgn);
		/** TB_ORGN(연구기관) 테이블에 저장할 내용 파싱  종료 **/
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		/** TB_PUBL(출판사 정보) 테이블에 저장할 내용 파싱  시작 **/
		List<PublVO> list_publ = new ArrayList<PublVO>();

		NodeList nodelist11 = (NodeList) xpath.evaluate("./static_data/summary/publishers/publisher", rec,
				XPathConstants.NODESET);

		for (int i = 0, n = nodelist11.getLength(); i < n; i++) {

			Node node = (Node) nodelist11.item(i);

			PublVO publVO = new PublVO();
			
			/* TB_ARTI의 논문 UID를 가져와 DB 저장 */
			publVO.setPubl_uid(vo.getArti_uid());

			/* 출판사 주소정보_전체주소명 */
			publVO.setPubl_addr((String) xpath.evaluate("./address_spec/full_address", node, XPathConstants.STRING));
			/* 출판사 주소정보_도시 */
			publVO.setPubl_city((String) xpath.evaluate("./address_spec/city", node, XPathConstants.STRING));
			/* 출판사 주소정보_나라 */
			/** 현재 논문데이터에 나라정보가 없으므로 임시로 공백표기 **/
			publVO.setPubl_ctry("");
			/* 츨판사 주소정보_주 */
			/** 현재 논문데이터에 주정보가 없으므로 임시로 공백표기 **/
			publVO.setPubl_state("");
			/* 출판사명_레코드 표기 */
			publVO.setPubl_dply((String) xpath.evaluate("./names/name/display_name", node, XPathConstants.STRING));
			/* 출판사명_풀네임 */
			publVO.setPubl_full((String) xpath.evaluate("./names/name/full_name", node, XPathConstants.STRING));

			list_publ.add(publVO);

		}

		vo.setList_publ(list_publ);


		return vo;
	}
	/** TB_PUBL(출판사 정보) 테이블에 저장할 내용 파싱  종료 **/
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	/** 테이블의 자료형이 정수형인경우 정규표현식 사용하여 정수형으로 반환 **/
	public int parseInt(String str) {

		/* 정규표현식 */
		String restr = str.replaceAll("[^0-9]", "");

		if (restr.equals("")) {
			return 0;
		} else {
			return Integer.parseInt(restr);
		}

	}

	public List<ArtiVO> returnList() {

		return listvo;
	}

}
