package com.chen.entity;

import java.io.Serializable;

public class OrderItem implements Serializable{

	private static final long serialVersionUID = 1L;

	Long id;
	private String itemname;
	private Float itemprice;
	private int itemnum;
	private Long orderid;
	private Long foodid;
	private Long bsid; //∑Ω±„≤È’“≈≈√˚
	
	public Long getBsid() {
		return bsid;
	}

	public void setBsid(Long bsid) {
		this.bsid = bsid;
	}

	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getItemname() {
		return itemname;
	}
	
	public void setItemname(String itemname) {
		this.itemname = itemname;
	}
	
	public Float getItemprice() {
		return itemprice;
	}
	
	public void setItemprice(Float itemprice) {
		this.itemprice = itemprice;
	}
	
	
	
	
	public int getItemnum() {
		return itemnum;
	}

	public void setItemnum(int itemnum) {
		this.itemnum = itemnum;
	}

	public Long getOrderid() {
		return orderid;
	}

	public void setOrderid(Long orderid) {
		this.orderid = orderid;
	}

	public Long getFoodid() {
		return foodid;
	}
	
	public void setFoodid(Long foodid) {
		this.foodid = foodid;
	}
	
	
}
