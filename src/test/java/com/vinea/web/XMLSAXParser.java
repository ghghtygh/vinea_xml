package com.vinea.web;

import java.util.jar.Attributes;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class XMLSAXParser extends DefaultHandler {

   // SAXParserFactory     
   private SAXParserFactory parserFactory;
   
   // SAXParser     
   private SAXParser parser;
   
   // xml 파일 명    
   private String fileName;

   // 시작 태그명
   private String startTagName;

   // 끝 태그명
   private String endTagName;
   
   // String buffer
   private StringBuffer buffer = new StringBuffer();
   
   private String uid;
   private String content;
   
   
   // 생성자
   public XMLSAXParser() {}

   public XMLSAXParser(String fileName) {
       super();
       try {
           parserFactory = SAXParserFactory.newInstance();
           parser = parserFactory.newSAXParser();
       } catch(Exception e) {
           System.out.println("Exception >> " + e.toString());
       }

       this.fileName = fileName;
   }

   // 문서의 시작
   public void startDocument(){
       //System.out.println("start document!!");
   }
   
   // 문서의 종료
   public void endDocument(){
       //System.out.println("end document!!");
   }
   
   // 시작 태그 인식했을 때 처리
   public void startElement(String url, String name, String elementName, Attributes attrs) 
       throws SAXException {
       startTagName = elementName;      
       //reset
       buffer.setLength(0); 
   }

   // 시작태그와 끝태그 사이의 내용을 인식 했을 때 처리
   public void characters(char[] str, int start, int len) throws SAXException {
       buffer.append(str, start, len);
       
       if(this.startTagName.equals("records")){
    	   this.content = buffer.toString().trim();
       }
       
   }
   // 끝태그를 인식 했을 때 처리
   public void endElement(String url, String localName, String name) {
       endTagName = name;
   }
   
   // parse
   public void parse() {
       try {
           parser.parse(fileName, this);
           
       } catch(Exception e) {
           System.out.println("XMLSAXParser Exception " + e.toString());
       }
   }
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
   
}

