package com.vinea.dto;

import java.util.List;

public class ItemVO {

	private String item_id;
	private String item_uid;
	private String item_avail;
	private String item_type;
	private String item_page;
	
	
	private List<KwrdplusVO> list_kwrdplus;
	private List<BookVO> list_book;
	
	
	public List<KwrdplusVO> getList_kwrdplus() {
		return list_kwrdplus;
	}
	public void setList_kwrdplus(List<KwrdplusVO> list_kwrdplus) {
		this.list_kwrdplus = list_kwrdplus;
	}
	public List<BookVO> getList_book() {
		return list_book;
	}
	public void setList_book(List<BookVO> list_book) {
		this.list_book = list_book;
	}
	public String getItem_id() {
		return item_id;
	}
	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}
	public String getItem_uid() {
		return item_uid;
	}
	public void setItem_uid(String item_uid) {
		this.item_uid = item_uid;
	}
	public String getItem_avail() {
		return item_avail;
	}
	public void setItem_avail(String item_avail) {
		this.item_avail = item_avail;
	}
	public String getItem_type() {
		return item_type;
	}
	public void setItem_type(String item_type) {
		this.item_type = item_type;
	}
	public String getItem_page() {
		return item_page;
	}
	public void setItem_page(String item_page) {
		this.item_page = item_page;
	}

	
}
