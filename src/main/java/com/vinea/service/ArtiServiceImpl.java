package com.vinea.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.vinea.dao.ArtiDAO;
import com.vinea.dto.ArtiVO;

@Service
public class ArtiServiceImpl implements ArtiService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Inject
	private ArtiDAO dao;

	/** 파싱된 논문 건수 반환 **/
	@Override
	public int countXml(Map<String, Object> map) throws Exception {

		return dao.countXml(map);
	}

	/** 요청 페이지에 따른 논문 목록 조회 **/
	@Override
	public List<ArtiVO> selectXmlList(Map<String, Object> map) {

		List<ArtiVO> list_artiVO = new ArrayList<ArtiVO>();

		list_artiVO = dao.selectXmlList(map);

		for (ArtiVO vo : list_artiVO) {

			vo.setList_auth(dao.selectAuthList(vo.getUid()));
		}

		return list_artiVO;
	}

	/* 상세페이지 */
	/** 논문 상세보기 **/
	@Override
	public ArtiVO article_detail(String uid) throws Exception {

		ArtiVO vo = dao.selectOneXml(uid);
		
		/* 카테고리 정보 */
		vo.setList_ctgry(dao.selectCtgryList(vo.getUid()));
		/* 키워드 정보 */
		vo.setList_kwrd(dao.selectKwrdList(vo.getUid()));
		/* 저자 정보 */
		vo.setList_auth(dao.selectAuthList(vo.getUid()));
		/* 참고문헌 정보 */
		vo.setList_refr(dao.selectRefrList(vo.getUid()));
		/* 저자 연구기관 정보 */
		vo.setList_orgn(dao.selectOrgnList(vo.getUid()));
		/* 발행기관 정보 */
		vo.setList_publ(dao.selectPublList(vo.getUid()));

		return vo;
	}

}
