package com.chen.entity;

import java.io.Serializable;

public class Food implements Serializable{
	
	private static final long serialVersionUID = 1L;

	
	private Long id;
	private String fname;
	private String fphoto;
	private Integer findex;
	private Float fprice;
	private Boolean fsales;//表示是否商家true、为上架，false为下架
	private Long ftid;
	private Long bsid;
	private FoodType foodType;
	
	public Float getFprice() {
		return fprice;
	}
	public void setFprice(Float fprice) {
		this.fprice = fprice;
	}
	
	
	public FoodType getFoodType() {
		return foodType;
	}
	public void setFoodType(FoodType foodType) {
		this.foodType = foodType;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getFphoto() {
		return fphoto;
	}
	public void setFphoto(String fphoto) {
		this.fphoto = fphoto;
	}
	public Integer getFindex() {
		return findex;
	}
	public void setFindex(Integer findex) {
		this.findex = findex;
	}
	public Boolean getFsales() {
		return fsales;
	}
	public void setFsales(Boolean fsales) {
		this.fsales = fsales;
	}
	public Long getFtid() {
		return ftid;
	}
	public void setFtid(Long ftid) {
		this.ftid = ftid;
	}
	public Long getBsid() {
		return bsid;
	}
	public void setBsid(Long bsid) {
		this.bsid = bsid;
	}
	
	
}
