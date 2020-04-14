package com.vinea.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.vinea.common.XmlParser;
import com.vinea.dao.ParseDAO;
import com.vinea.dto.ArtiVO;
import com.vinea.dto.BooknoteVO;
import com.vinea.dto.ConfVO;
import com.vinea.dto.CtgryVO;
import com.vinea.dto.DtypeVO;
import com.vinea.dto.GrntVO;
import com.vinea.dto.KwrdVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.PublVO;
import com.vinea.dto.RefrVO;
import com.vinea.dto.XmlFileVO;

@Service
public class ParseServiceImpl implements ParseService {

	/* 파싱 파일 정보 관련 VO 객체 선언 */
	private XmlFileVO xmlFileVO;

	/* 파싱 동작 */
	private XmlParser parser;

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Inject
	private ParseDAO dao;

	@Override
	public void createVO(ArtiVO vo) throws Exception {
		// TODO 논문 정보 1개 저장 (사용X)
		/*
		try {

			// 논문 정보
			dao.insertArti(vo);

			// 저자 정보 리스트
			dao.insertAuthList(vo.getList_auth());

			// 카테고리 정보 리스트 
			for (CtgryVO ctgryVO : vo.getList_ctgry()) {
				dao.insertCtgry(ctgryVO);

			}
			// 도서기록 정보 리스트 
			for (BooknoteVO booknoteVO : vo.getList_booknote()) {
				dao.insertBooknote(booknoteVO);
			}

			// 학회 정보 리스트 
			for (ConfVO confVO : vo.getList_conf()) {
				dao.insertConf(confVO);
			}

			// 문서유형 정보 리스트 
			for (DtypeVO dtypeVO : vo.getList_dtype()) {
				dao.insertDtype(dtypeVO);
			}

			// 보조금 정보 리스트 
			for (GrntVO grntVO : vo.getList_grnt()) {
				dao.insertGrnt(grntVO);
			}

			// 키워드 정보 리스트 
			for (KwrdVO kwrdVO : vo.getList_kwrd()) {
				dao.insertKwrd(kwrdVO);
			}

			// 저자 연구기관 정보 리스트 
			for (OrgnVO orgnVO : vo.getList_orgn()) {
				dao.insertOrgn(orgnVO);
			}

			// 발행기관 정보 리스트 
			for (PublVO publVO : vo.getList_publ()) {
				dao.insertPubl(publVO);
			}

			// 참고문헌 정보 리스트 
			for (RefrVO refrVO : vo.getList_refr()) {
				dao.insertRefr(refrVO);
			}

			//updateParse(vo.getUid());

		} catch (Exception e) {
			logger.info("CREATEVO - INSERT 오류 발생 >> " + vo.getUid());
			e.printStackTrace();
			updateError(vo.getUid());

		}
		*/
	}

	@Override
	public void createListVO(String filePath) throws Exception {
		// TODO 로컬 파일 DB 저장 (사용X)
		
		/*
		parser = new XmlParser(filePath);

		if (!parser.CanParse()) {
			return;
		}

		parser.DoParse();

		List<ArtiVO> list = parser.returnList();

		for (ArtiVO vo : list) {

			createVO(vo);

		}
		*/
	}

	
	@Override
	public XmlFileVO parseOneXml(String file_name) throws Exception {
		// TODO XML 파일명에 따른  RECORD 태그 1개 파싱 (사용X)
		
		/*
		xmlFileVO = new XmlFileVO();
		parser = new XmlParser();

		if ((xmlFileVO = dao.selectOneXmlFile(file_name)) != null) {

			createVO(parser.parseRecStr(xmlFileVO.getContent()));

			return xmlFileVO;

		} else {
			return null;
		}
		*/
		
		return null;
	}

	@Override
	public void parseXmlList(Map<String, Object> map) throws Exception {
		// TODO XML 파일명에 따른  RECORD 태그 여러개 파싱

		parser = new XmlParser();

		// 파싱한 데이터 저장할 배열
		List<ArtiVO> list = new ArrayList<ArtiVO>();

		for (XmlFileVO vo : dao.selectXmlFileList(map)) {
			
			try {
				
				list.add(parser.parseRecStr(vo.getContent()));
				
			} catch (Exception e) {
				// 파싱 에러 발생
				
				logger.info("Error - parseXmlList : "+vo.getUid());
				updateError(vo.getUid());
				
			}
		}
		
		
		insertVOList(list);
	}

	@Override
	public void insertVOList(List<ArtiVO> list) throws Exception {
		// TODO 논문정보 리스트 DB 저장
				
		
		Boolean m_err = false;	// ArtiVO 리스트 중 에러 발생 여부
		
		if (list==null){
			return;
		}
		
		try{
			
			dao.insertArtiList(list);
			
		} catch (Exception e) {
			// INSERT 에러
			m_err = true;
		}
		
		for (ArtiVO vo : list) {
			
			try {
				
				if(m_err){
					
					dao.insertArti(vo);
				}
				
				dao.insertCtgryList(vo.getList_ctgry());
				dao.insertAuthList(vo.getList_auth());
				dao.insertBooknoteList(vo.getList_booknote());
				dao.insertConfList(vo.getList_conf());
				dao.insertDtypeList(vo.getList_dtype());
				dao.insertGrntList(vo.getList_grnt());
				dao.insertKwrdList(vo.getList_kwrd());
				dao.insertOrgnList(vo.getList_orgn());
				dao.insertOrgnPrefList(vo.getList_pref());
				dao.insertPublList(vo.getList_publ());
				dao.insertRefrList(vo.getList_refr());
				
			} catch (Exception e) {
				// INSERT 에러
				updateError(vo.getUid());
				logger.info("Error - insertVOList : "+ vo.getUid());
			}
		}

	}

	@Override
	public void updateError(String uid) throws Exception {
		// TODO 에러 발생, 해당 데이터 ERROR 처리
		dao.updateErrorYN(uid);
	}

	@Override
	public List<XmlFileVO> selectXmlFileCount() throws Exception {
		return dao.selectXmlFileCount();
	}

	/** 원본파일명과 파싱된 태그 개수 반환 **/
	@Override
	public List<XmlFileVO> selectParseYN() throws Exception {
		return dao.selectParseYN();
	}
}
