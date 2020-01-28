package com.vinea.service;

public class PostPager {

	
	// 페이지마다 게시글 수
    private int pageSize = 10;
    
    // 블럭마다 페이지 수
    private int rangeSize = 5;
    
    // 현재 페이지
    private int nowPage = 1;
    
    // 현재 블럭
    private int nowRange = 1;
    
    // 총 게시글 수
    private int listCnt;
    
    // 총 페이지 수
    private int pageCnt;
    
    // 총 블럭 수
    private int rangeCnt;
    
    // 블럭 시작 페이지
    private int startPage = 1;
    
    // 블럭 마지막 페이지
    private int endPage = 1;
    
    
    private int startIndex = 0;
    
    // 이전 페이지
    private int prevPage;
    
    // 다음 페이지
    private int nextPage;

    public PostPager(int cnt,int now) {
    	
    	// 현재 페이지 설정
    	setNowPage(now);
    	
    	// 총 게시글 수 설정
    	setListCnt(cnt);
    	
    	// 총 페이지 수 설정
    	setPageCnt(cnt);
    	
    	// 총 블럭 수 설정
    	setRangeCnt(pageCnt);
    	
    	// 현재 블럭 및 이전,다음 페이지 설정
    	rangeSetting(nowPage);
    	
    	
    	setStartIndex(nowPage);
    	
    }
    public void rangeSetting(int nowPage) {
    	
    	setNowRange(nowPage);
    	this.startPage = (nowRange-1)*rangeSize+1;
    	this.endPage= startPage+rangeSize-1;
    	
    	if(endPage > pageCnt){
            this.endPage = pageCnt;
        }
        
        this.prevPage = nowPage - 1;
        this.nextPage = nowPage + 1;
    }
    
	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getRangeSize() {
		return rangeSize;
	}

	public void setRangeSize(int rangeSize) {
		this.rangeSize = rangeSize;
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getNowRange() {
		return nowRange;
	}

	public void setNowRange(int nowPage) {
		this.nowRange = (int)((nowPage-1)/rangeSize)+1;
	}

	public int getListCnt() {
		return listCnt;
	}

	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}

	public int getPageCnt() {
		return pageCnt;
	}

	public void setPageCnt(int cnt) {
		this.pageCnt = (int)Math.ceil(cnt*1.0/pageSize);
	}

	public int getRangeCnt() {
		return rangeCnt;
	}

	public void setRangeCnt(int pageCnt) {
		this.rangeCnt = (int)Math.ceil(pageCnt*1.0/rangeSize);
		
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(int startIndex) {
		this.startIndex = (nowPage-1)*pageSize;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}
    
    
}
