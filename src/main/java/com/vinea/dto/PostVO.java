package com.vinea.dto;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class PostVO {
	 
	
	// 게시글 번호
	private int postNum;
	
	// 게시글 제목
    private String title;
    
    // 게시글 내용
    private String content;
    
    // 작성 유저 번호
    private int writer;
    
    // 작성일
    private String wrtDt;
    
    // 수정일
    private String reDt;
    
    // 첨부파일명
    private List<Map<String,Object>> fileNames;
 
    // 조회 수
    private int viewCnt;
    
    // 유저 아이디
    private String wrtId;
    
    // 첨부파일 여부
    private int countFiles;
    
	public int getPostNum() {
		return postNum;
	}
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getWriter() {
		return writer;
	}
	public void setWriter(int writer) {
		this.writer = writer;
	}
	public String getWrtDt() {
		return wrtDt;
	}
	public void setWrtDt(String wrtDt) {
		this.wrtDt = wrtDt;
	}
	public String getReDt() {
		return reDt;
	}
	public void setReDt(String reDt) {
		this.reDt = reDt;
	}
	public List<Map<String,Object>> getFileNames() {
		return fileNames;
	}
	public void setFileNames(List<Map<String,Object>> fileNames) {
		this.fileNames = fileNames;
	}
	public long getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getWrtId() {
		return wrtId;
	}
	public void setWrtId(String wrtId) {
		this.wrtId = wrtId;
	}
	public int getCountFiles() {
		return countFiles;
	}
	public void setCountFiles(int countFiles) {
		this.countFiles = countFiles;
	}
	
    
 
}
