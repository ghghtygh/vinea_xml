package com.vinea.service;

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
		// TODO Auto-generated method stub
		try{
	         
	         dao.insertArti(vo);
	         /* 저자 정보 리스트 */
	         dao.insertAuthList(vo.getList_auth());
	         
	         for(CtgryVO ctgryVO : vo.getList_ctgry()){
	        	 dao.insertCtgry(ctgryVO);
	        	 
	         }
	         /* 도서기록 정보 리스트 */
	         for(BooknoteVO booknoteVO : vo.getList_booknote()){
	            dao.insertBooknote(booknoteVO);
	         } 
	         
	         /* 학회 정보 리스트 */
	         for(ConfVO confVO : vo.getList_conf()){
	            dao.insertConf(confVO);      
	         }
	         
	         /* 문서유형 정보 리스트 */
	         for(DtypeVO dtypeVO : vo.getList_dtype()){
	            dao.insertDtype(dtypeVO);
	         }
	         
	         /* 보조금 정보 리스트 */
	         for(GrntVO grntVO : vo.getList_grnt()){
	            dao.insertGrnt(grntVO);
	         }
	         
	         /* 키워드 정보 리스트 */
	         for(KwrdVO kwrdVO : vo.getList_kwrd()){
	            dao.insertKwrd(kwrdVO);
	         }
	         
	         
	         /* 저자 연구기관 정보 리스트 */
	         for(OrgnVO orgnVO : vo.getList_orgn()){
	            dao.insertOrgn(orgnVO);
	         }
	         
	         /* 발행기관 정보 리스트 */
	         for(PublVO publVO : vo.getList_publ()){
	            dao.insertPubl(publVO);
	         }
	         
	         /* 참고문헌 정보 리스트 */
	         for(RefrVO refrVO : vo.getList_refr()){
	            dao.insertRefr(refrVO);
	         }
	         
	         //updateParse(vo.getUid());
	         
	      }catch(Exception e){
	         logger.info("CREATEVO - INSERT 오류 발생 >> "+vo.getUid());
	         e.printStackTrace();
	         updateError(vo.getUid());
	         
	      }
	}

	@Override
	public void insertVOList(List<ArtiVO> list) throws Exception {
		// TODO Auto-generated method stub
		/*throws 처리 */
	      try{
	         
	         dao.insertArtiList(list);
	         
	         for (ArtiVO vo : list){
	        	 for(CtgryVO ctgryVO : vo.getList_ctgry()){
	            	 dao.insertCtgry(ctgryVO);
	             }
	            dao.insertAuthList(vo.getList_auth());
	            dao.insertBooknoteList(vo.getList_booknote());
	            dao.insertConfList(vo.getList_conf());
	            dao.insertDtypeList(vo.getList_dtype());
	            dao.insertGrntList(vo.getList_grnt());
	            dao.insertKwrdList(vo.getList_kwrd());
	            dao.insertOrgnList(vo.getList_orgn());
	            dao.insertPublList(vo.getList_publ());
	            dao.insertRefrList(vo.getList_refr());
	         }
	         
	         /*for(ArtiVO vo : list){
	            updateParse(vo.getUid());
	         }*/
	         
	      }catch(Exception e){
	      /* 파싱은 됬는데 INSERT 에러 검출 (보통 컬럼 길이문제 ) */
	         
	         for(ArtiVO vo : list){
	            /* INSERT 에러: 어디에서 에러나는지 검출 */
	            
	            createVO(vo);
	            
	         }
	      }
	}

	/** 파싱된 논문 데이터 DB에 저장 **/
	@Override
	public void createListVO(String filePath) throws Exception {

		parser = new XmlParser(filePath);

		if (!parser.CanParse()) {
			return;
		}

		parser.DoParse();

		List<ArtiVO> list = parser.returnList();

		for (ArtiVO vo : list) {

			createVO(vo);

		}

	}
	@Override
	public XmlFileVO parseOneXml(String file_name) throws Exception {
		// TODO Auto-generated method stub
		xmlFileVO = new XmlFileVO();
	      parser = new XmlParser();
	      
	      
	      if((xmlFileVO = dao.selectOneXmlFile(file_name)) != null){
	         
	         
	         createVO(parser.parseRecStr(xmlFileVO.getContent()));
	            
	         return xmlFileVO;
	         
	         
	      }else{
	         return null;
	      }
	}

	@Override
	public void parseXmlList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		xmlFileVO = new XmlFileVO();
	      parser = new XmlParser();
	      
	      List<ArtiVO> list = new ArrayList<ArtiVO>();
	      
	      for(XmlFileVO vo : dao.selectXmlFileList(map)){
	         
	         try{
	            
	            list.add(parser.parseRecStr(vo.getContent()));
	            
	         }catch(Exception e){
	         /* 파싱에러 검출 */
	            
	            updateError(vo.getUid());
	            logger.info("PARSING 오류발생 >>>"+vo.getUid());
	         }
	      }
	      
	      insertVOList(list);
	}

	@Override
	public void updateError(String uid) throws Exception {
		// TODO Auto-generated method stub
		dao.updateErrorYN(uid);
	}

	/** 파싱 현황 불러오기 **/
	   @Override
	   public List<XmlFileVO> selectXmlFileCount() throws Exception{
	      return dao.selectXmlFileCount();
	   }
	   
	   /** 원본파일명과 파싱된 태그 개수 반환**/
	   @Override
	   public List<XmlFileVO> selectParseYN() throws Exception{
	      return dao.selectParseYN();
	   }
}
