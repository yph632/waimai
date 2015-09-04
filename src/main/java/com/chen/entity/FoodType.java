package com.chen.entity;

import java.io.Serializable;

public class FoodType implements Serializable{

	private static final long serialVersionUID = 1L;

	
	private Long id;
	private String ftname;
	private Integer ftindex;//表示商品的默认排序
	private Long bsid;//为方便查找，添加的冗余字段
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFtname() {
		return ftname;
	}
	public void setFtname(String ftname) {
		this.ftname = ftname;
	}
	public Integer getFtindex() {
		return ftindex;
	}
	public void setFtindex(Integer ftindex) {
		this.ftindex = ftindex;
	}
	public Long getBsid() {
		return bsid;
	}
	public void setBsid(Long bsid) {
		this.bsid = bsid;
	}
	
	
	
}
