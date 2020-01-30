package com.vinea.dto;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class DtypeVO {

	
	private int dtype_id;
	private String dtype_uid;
	private String dtype_name;
	
	
	public int getDtype_id() {
		return dtype_id;
	}
	public void setDtype_id(int dtype_id) {
		this.dtype_id = dtype_id;
	}
	public String getDtype_uid() {
		return dtype_uid;
	}
	public void setDtype_uid(String dtype_uid) {
		this.dtype_uid = dtype_uid;
	}
	public String getDtype_name() {
		return dtype_name;
	}
	public void setDtype_name(String dtype_name) {
		this.dtype_name = dtype_name;
	}

	public String toStringMultiline() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

	
}
