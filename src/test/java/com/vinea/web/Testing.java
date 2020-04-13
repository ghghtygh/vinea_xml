package com.vinea.web;

import java.io.BufferedReader;
import java.io.FileReader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.vinea.common.XmlParser;
import com.vinea.dto.ArtiVO;
import com.vinea.dto.AuthVO;
import com.vinea.dto.GrntVO;
import com.vinea.dto.OrgnVO;

public class Testing {

	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	
	public Testing(){
		
		
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		new Testing();
		
		String testRec = "";
		XmlParser xmlParser = new XmlParser();
		
		FileReader fr;
		BufferedReader br;
		String rl;
		
		String uidSt = "<UID>";
		int lenSt = uidSt.length();
		String uidEd = "</UID>";
		String uid;
		
		StringBuilder recBuf;
		Boolean inRec;
		
		int i=0;
		long beforeTime = System.currentTimeMillis();
		
		try{
			
			fr = new FileReader("F:\\vinea\\WOS\\2017_CORE\\WR_2017_20180509131811_CORE_0002.xml");
			br = new BufferedReader(fr);
			recBuf = new StringBuilder();
			uid="";
			inRec = false;
			
			while((rl=br.readLine())!=null){
				
				
				if(rl.contains("<REC r_id")){
					inRec = true;
				}
				
				if (inRec){
					recBuf.append(rl);
					
					if (rl.contains("<UID>")){
						
						uid = rl.substring(rl.indexOf(uidSt)+lenSt,rl.indexOf(uidEd));
						
					}
					
					if(rl.contains("</REC>")){
						i++;
						
						//System.out.println(uid);
						//System.out.println(recBuf);

						testRec = recBuf.toString();
						
						
						recBuf.setLength(0);
						recBuf.trimToSize();
						inRec=false;
						
						break;
					}
				}
				
			}
			
			fr.close();
			br.close();
				
			
			
			
			
			
		}catch(Exception e){
			
		}finally{
			long afterTime = System.currentTimeMillis(); // 코드 실행 후에 시간 받아오기
			double secDiffTime = (afterTime - beforeTime)/1000.0; //두 시간에 차 계산
			System.out.println("시간차이(초) : "+secDiffTime);
			System.out.println("길이 : "+Integer.toString(i));
		}
		
		ArtiVO artiVO = new ArtiVO();
		
		try {
			artiVO = xmlParser.parseRecStr(testRec);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*
		System.out.println(artiVO.toStringMultiline());
		
		for(AuthVO authVO : artiVO.getList_auth()){
			System.out.println(authVO.toStringMultiline());
		}
		
		for(OrgnVO orgnVO : artiVO.getList_orgn()){
			System.out.println(orgnVO.toStringMultiline());
		}*/
		
		for(GrntVO grntVO: artiVO.getList_grnt()){
			System.out.println(grntVO.toStringMultiline());
		}
		
	}
}
