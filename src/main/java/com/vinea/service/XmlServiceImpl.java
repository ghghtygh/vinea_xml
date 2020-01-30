package com.vinea.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.vinea.common.NjhParser;
import com.vinea.dao.XmlDAO;
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
import com.vinea.dto.XmlVO;

@Service
public class XmlServiceImpl implements XmlService{
	
	private NjhParser parser;
	
	@Inject
	private XmlDAO dao;
	
	/* 해당 경로의 XML파일 VO객체로 파싱 */
	@Override
	public XmlVO createVO(String filePath) throws Exception{
		
		ParseXml px = new ParseXml(filePath);
		
		return px.returnVO();
	}
	
	@Override
	public XmlVO readVO(int id){
		
		return dao.readVO(id);
	}
	
	/* XML 개수 리턴 */
	@Override
	public int countXml() throws Exception{
		
		return dao.countXml();
	}
	
	/* 요청 페이지에 따른 XML 목록 리턴*/
	@Override
	public List<XmlVO> selectXmlList(Map<String,Object> map){
	
		
		return dao.selectXmlList(map);
	}
	
	/* XML DB에 저장 */
	@Override
	public void insertVO(XmlVO vo) throws Exception{
		
		dao.insertVO(vo);
	}
	
	/** 파싱된 XML(논문)List 데이터 DB에 저장 **/
	@Override
	public void createListVO(String filePath) throws Exception{
		
		parser = new NjhParser(filePath);
		
		List<ArtiVO> list = parser.returnList();
		
		for(ArtiVO vo : list){
			
			dao.insertArti(vo);
			
			for(AuthVO authVO : vo.getList_auth()){
				dao.insertAuth(authVO);
			}
			
			for(BooknoteVO booknoteVO : vo.getList_booknote()){
				dao.insertBooknote(booknoteVO);
			}
			
			for(CoauthVO coauthVO : vo.getList_coauth()){
				dao.insertCoauth(coauthVO);
			}
			
			for(ConfVO confVO : vo.getList_conf()){
				dao.insertConf(confVO);
				
				for (SponVO sponVO : confVO.getList_spon()){
					dao.insertSpon(sponVO);
				}
			}
			
			for(DtypeVO dtypeVO : vo.getList_dtype()){
				dao.insertDtype(dtypeVO);
			}
			
			
			for(GrntVO grntVO : vo.getList_grnt()){
				dao.insertGrnt(grntVO);
			}
			
			for(KwrdVO kwrdVO : vo.getList_kwrd()){
				dao.insertKwrd(kwrdVO);
			}
			
			for(KwrdplusVO kwrdplusVO : vo.getList_kwrdplus()){
				dao.insertKwrdp(kwrdplusVO);
			}
			
			for(OrgnVO orgnVO : vo.getList_orgn()){
				
				dao.insertOrgn(orgnVO);
			}
			
			for(PublVO publVO : vo.getList_publ()){
				dao.insertPubl(publVO);
			}
			
			for(RefrVO refrVO : vo.getList_refr()){
				dao.insertRefr(refrVO);
			}
			
		}
		
	}
	
	/* 전체 XML 목록 리턴 */
	@Override
	public List<XmlVO> selectXml(){
		return dao.selectXml();
	}
}
