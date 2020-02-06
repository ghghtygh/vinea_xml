package com.vinea.service;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.vinea.common.NjhParser;
import com.vinea.dao.XmlDAO;
import com.vinea.dto.ArtiVO;
import com.vinea.dto.AuthVO;
import com.vinea.dto.BooknoteVO;
import com.vinea.dto.ConfVO;
import com.vinea.dto.DtypeVO;
import com.vinea.dto.GrntVO;
import com.vinea.dto.KwrdVO;
import com.vinea.dto.OrgnVO;
import com.vinea.dto.PublVO;
import com.vinea.dto.RefrVO;
import com.vinea.dto.XmlFileVO;

@Service
public class XmlServiceImpl implements XmlService{
	
	private NjhParser parser;
	
	private FileReader fr;
	private BufferedReader br;
	
	Logger logger = LoggerFactory.getLogger(XmlServiceImpl.class);
	
	
	@Inject
	private XmlDAO dao;
	
	
	/** 파싱된 논문 건수 반환 **/
	@Override
	public int countXml() throws Exception{
		
		return dao.countXml();
	}
	
	/** 요청 페이지에 따른 논문 목록 조회 **/
	@Override
	public List<ArtiVO> selectXmlList(Map<String,Object> map){
	
		List<ArtiVO> list_artiVO = new ArrayList<ArtiVO>();
		
		list_artiVO = dao.selectXmlList(map);
		
		for (ArtiVO vo : list_artiVO){
			
			vo.setList_auth(dao.selectAuthList(vo.getUid()));
		}
		
		return list_artiVO;
	}
	
	/** 논문 상세보기
	@Override
	public ArtiVO article_detail(int arti_id) throws Exception{
		
		ArtiVO vo = dao.selectOneXml(arti_id);
		
		/* 키워드 정보 
		vo.setList_kwrd(dao.selectKwrdList(vo.getArti_uid()));		
		/* 저자 정보 
		vo.setList_auth(dao.selectAuthList(vo.getArti_uid()));		
		/* 참고문헌 정보 
		vo.setList_refr(dao.selectRefrList(vo.getArti_uid()));		
		/* 저자 연구기관 정보 
	    vo.setList_orgn(dao.selectOrgnList(vo.getArti_uid()));	    
	    /* 발행기관 정보 
	    vo.setList_publ(dao.selectPublList(vo.getArti_uid()));
		
		return vo;
	}  **/
	
	/** 논문 상세보기  **/
	@Override
	public ArtiVO article_detail(String arti_no) throws Exception{
		
		ArtiVO vo = dao.selectOneXml(arti_no);
		
		/* 키워드 정보  */
		vo.setList_kwrd(dao.selectKwrdList(vo.getUid()));		
		/* 저자 정보  */
		vo.setList_auth(dao.selectAuthList(vo.getUid()));		
		/* 참고문헌 정보  */
		vo.setList_refr(dao.selectRefrList(vo.getUid()));		
		/* 저자 연구기관 정보  */
	    vo.setList_orgn(dao.selectOrgnList(vo.getUid()));	    
	    /* 발행기관 정보 */
	    vo.setList_publ(dao.selectPublList(vo.getUid()));
		
		return vo;
	}
	
	/** 파싱된 논문 데이터 DB에 저장 **/
	@Override
	public void createListVO(String filePath) throws Exception{
		
		parser = new NjhParser(filePath);
		
		if(!parser.CanParse()){
			return;
		}
		
		parser.DoParse();
		
		List<ArtiVO> list = parser.returnList();
		
		for(ArtiVO vo : list){
			
			createVO(vo);
			
		}
		
	}
	
	/** 논문 정보 VO 객체 DB 에 저장 **/
	@Override
	public void createVO(ArtiVO vo) throws Exception{
		
		dao.insertArti(vo);
		
		/* 저자 정보 리스트 */
		for(AuthVO authVO : vo.getList_auth()){
			dao.insertAuth(authVO);
		}
		
		/* 도서기록 정보 리스트 */
		for(BooknoteVO booknoteVO : vo.getList_booknote()){
			dao.insertBooknote(booknoteVO);
		}	
		
		/* 공저자 정보 리스트(사용안함)
		 * for(CoauthVO coauthVO : vo.getList_coauth()){
			dao.insertCoauth(coauthVO);
		}*/
		
		/* 학회 정보 리스트 */
		for(ConfVO confVO : vo.getList_conf()){
			dao.insertConf(confVO);
			
		/* 후원기관 정보 리스트(사용안함)
		 * for (SponVO sponVO : confVO.getList_spon()){
			dao.insertSpon(sponVO);
		}*/			
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
		
		/* 간행물 키워드 정보 리스트(사용안함)
		 * for(KwrdplusVO kwrdplusVO : vo.getList_kwrdplus()){
			dao.insertKwrdp(kwrdplusVO);
		}*/
		
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
				
	}
		
	
	/** chk 동작 부분 **/
	@Override
	public List<ArtiVO> checkList(String filePath) throws Exception{
		
		parser = new NjhParser(filePath);
		
		
		if(parser.CanParse()){
			parser.DoParse();
			return parser.returnList();
		}
		else{
			
			return null;
		}
		
	}
	@Override
	public void Test() throws Exception{
		
		List<String> list = new ArrayList<String>();
		
		//list.add("C:\\Users\\vinea\\iCloudDrive\\2017_CORE\\WR_2017_20180509131811_CORE_0001.xml");
		//list.add("C:\\Users\\vinea\\iCloudDrive\\2017_CORE\\WR_2017_20180509131811_CORE_0002.xml");
		
		list.add("C:\\Users\\vinea\\iCloudDrive\\2017_CORE\\WR_2017_20180509131811_CORE_0003.xml");
		list.add("C:\\Users\\vinea\\iCloudDrive\\2017_CORE\\WR_2017_20180509131811_CORE_0004.xml");
		list.add("C:\\Users\\vinea\\iCloudDrive\\2017_CORE\\WR_2017_20180509131811_CORE_0005.xml");
		
		for(String str : list){
			
			articleTest(str);
		}
	}
	
	/** 원본 데이터 파싱 테스트 **/	
	@Override
	public void articleTest(String filePath) throws Exception{
		
		//filePath = "C:\\Users\\vinea\\iCloudDrive\\2017_CORE\\WR_2017_20180509131811_CORE_0001.xml";
		
		//filePath = "D:\\2017_CORE\\WR_2017_20180509131811_CORE_0001.xml";
		
		/* 파일 이름 세팅 */
		String fileName = null;
		String[] array = filePath.split("\\\\");
		for (int i=0;i<array.length;i++){
			if(array[i].contains(".xml")){
				fileName=array[i];
			}
		}
		
		parser = new NjhParser();
		
		try{
			
			fr = new FileReader(filePath);
			br = new BufferedReader(fr);
			
			/* uid 태그 문자열 자르기 위한 Index */
			int beginIndex = 0;
			
			/* 라인 수*/
			int lineCnt = 0;
			
			/* REC 태그 개수 */
			int recCnt = 0;
			
			/* xml 읽어올 문자열 */
			String str = null;
			
			/* REC 태그 사이에 있는지 여부 */
			Boolean m_rec = false;
			
			/* 원하는 열을 찾기위해서 */
			int recLineCnt = 0;
			
			/* UID 저장*/
			String uidStr = "";
			
			/* REC 태그 문자열 저장*/
			String recStr = "";
			
			/* 시작 시간 체크 */
			Date date = null;
			date = new Date();
			long start = date.getTime();
			
			/* 원본 데이터 VO 객체에 저장 */
			XmlFileVO vo = new XmlFileVO();
			
			while((str=br.readLine())!=null){
				
				
				
				/* REC 태그 시작*/
				if(str.contains("<REC r_id_")){
					m_rec = true;
					vo = new XmlFileVO();
				}
				
				if(m_rec){
					
					recLineCnt++;
					
					recStr+=str;
					
					/* UID 세팅 */
					//if(str.contains("<UID>")){
					if(recLineCnt==2){
						
						beginIndex = str.indexOf("WOS");
						
						uidStr = str.substring(beginIndex, (str.substring(beginIndex).indexOf("</UID>")+beginIndex));
						
						vo.setUid(uidStr);
						
						/* UID 확인*/
						//logger.info("<UID> : "+vo.getUid());
						
					}
					
					/*REC 태그 종료*/
					if(str.contains("</REC>")){
						recCnt+=1;
						
						vo.setContent(recStr);
						vo.setFile_name(fileName);
						
						/* VO 확인*/
						//logger.info(vo.getUid());
						
						/* VO 데이터베이스에 저장 */
						dao.insertXmlFile(vo);
						
						recStr = "";
						m_rec = false;
						vo = null;
						
						recLineCnt = 0;
						//break;
					}
				}
			}
			/* 끝난 시간 체크 */
			date = new Date();
			long end = date.getTime();
			
			logger.info("REC 태그 개수 : " + Integer.toString(recCnt));
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
	
	
}
