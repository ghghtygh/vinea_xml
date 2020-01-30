package com.vinea.dto;

import java.util.List;

public class ConfVO {
	
	private int conf_id;
	private String conf_cid;
	private String conf_uid;
	private String conf_title;
	private String conf_date;
	private String conf_start;
	private String conf_end;
	private String conf_city;
	private String conf_state;
	private String conf_ctry;
	
	private List<SponVO> list_spon;
	
	
	
	public String getConf_cid() {
		return conf_cid;
	}
	public void setConf_cid(String conf_cid) {
		this.conf_cid = conf_cid;
	}
	public List<SponVO> getList_spon() {
		return list_spon;
	}
	public void setList_spon(List<SponVO> list_spon) {
		this.list_spon = list_spon;
	}
	public int getConf_id() {
		return conf_id;
	}
	public void setConf_id(int conf_id) {
		this.conf_id = conf_id;
	}
	public String getConf_uid() {
		return conf_uid;
	}
	public void setConf_uid(String conf_uid) {
		this.conf_uid = conf_uid;
	}
	public String getConf_title() {
		return conf_title;
	}
	public void setConf_title(String conf_title) {
		this.conf_title = conf_title;
	}
	public String getConf_date() {
		return conf_date;
	}
	public void setConf_date(String conf_date) {
		this.conf_date = conf_date;
	}
	public String getConf_start() {
		return conf_start;
	}
	public void setConf_start(String conf_start) {
		this.conf_start = conf_start;
	}
	public String getConf_end() {
		return conf_end;
	}
	public void setConf_end(String conf_end) {
		this.conf_end = conf_end;
	}
	public String getConf_city() {
		return conf_city;
	}
	public void setConf_city(String conf_city) {
		this.conf_city = conf_city;
	}
	public String getConf_state() {
		return conf_state;
	}
	public void setConf_state(String conf_state) {
		this.conf_state = conf_state;
	}
	public String getConf_ctry() {
		return conf_ctry;
	}
	public void setConf_ctry(String conf_ctry) {
		this.conf_ctry = conf_ctry;
	}

	
	
}
