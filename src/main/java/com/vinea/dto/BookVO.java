package com.vinea.dto;

import java.util.List;

public class BookVO {

	private int book_id;
	private String book_item_id;
	private int book_pages;
	private String book_bind;
	private String book_publ;
	private String book_prepay;
	
	private List<BooknoteVO> list_booknote;
	
	public List<BooknoteVO> getList_booknote() {
		return list_booknote;
	}
	public void setList_booknote(List<BooknoteVO> list_booknote) {
		this.list_booknote = list_booknote;
	}
	public int getBook_id() {
		return book_id;
	}
	public void setBook_id(int book_id) {
		this.book_id = book_id;
	}
	public String getBook_item_id() {
		return book_item_id;
	}
	public void setBook_item_id(String book_item_id) {
		this.book_item_id = book_item_id;
	}
	public int getBook_pages() {
		return book_pages;
	}
	public void setBook_pages(int book_pages) {
		this.book_pages = book_pages;
	}
	public String getBook_bind() {
		return book_bind;
	}
	public void setBook_bind(String book_bind) {
		this.book_bind = book_bind;
	}
	public String getBook_publ() {
		return book_publ;
	}
	public void setBook_publ(String book_publ) {
		this.book_publ = book_publ;
	}
	public String getBook_prepay() {
		return book_prepay;
	}
	public void setBook_prepay(String book_prepay) {
		this.book_prepay = book_prepay;
	}
	
	
	
}
