package com.chen.entity;

import java.io.Serializable;

public class Order implements Serializable{

	private static final long serialVersionUID = 1L;

	private Long id;
	private String ordercode; //������
	private String orderman; //�����������������˿��ܺ�����½�˺����ֲ�һ��
	private String ordertel;//�����˵绰
	private Float orderprice; //���ͽ��
	private Float orderpostprice; //�����������ͷ�
 	private String ordercontent; //���������µ���Ϣ
 	private String orderaddress;
	private String orderpaytype; //��������
	private String orderstate;//��������״̬
	private String ordercreatetime; //��������ʱ��
	private Long acid;
	private Long bsid;
	

	public String getOrderaddress() {
		return orderaddress;
	}

	public void setOrderaddress(String orderaddress) {
		this.orderaddress = orderaddress;
	}

	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getOrdercode() {
		return ordercode;
	}
	
	public void setOrdercode(String ordercode) {
		this.ordercode = ordercode;
	}
	
	public String getOrderman() {
		return orderman;
	}
	
	public void setOrderman(String orderman) {
		this.orderman = orderman;
	}
	
	public String getOrdertel() {
		return ordertel;
	}
	
	public void setOrdertel(String ordertel) {
		this.ordertel = ordertel;
	}
	
	public Float getOrderprice() {
		return orderprice;
	}
	
	public void setOrderprice(Float orderprice) {
		this.orderprice = orderprice;
	}
	
	public Float getOrderpostprice() {
		return orderpostprice;
	}
	
	public void setOrderpostprice(Float orderpostprice) {
		this.orderpostprice = orderpostprice;
	}
	public String getOrdercontent() {
		return ordercontent;
	}
	
	public void setOrdercontent(String ordercontent) {
		this.ordercontent = ordercontent;
	}
	
	public String getOrderpaytype() {
		return orderpaytype;
	}
	public void setOrderpaytype(String orderpaytype) {
		this.orderpaytype = orderpaytype;
	}
	
	public String getOrderstate() {
		return orderstate;
	}
	
	public void setOrderstate(String orderstate) {
		this.orderstate = orderstate;
	}
	public String getOrdercreatetime() {
		return ordercreatetime;
	}
	
	public void setOrdercreatetime(String ordercreatetime) {
		this.ordercreatetime = ordercreatetime;
	}
	
	public Long getAcid() {
		return acid;
	}
	
	public void setAcid(Long acid) {
		this.acid = acid;
	}
	
	public Long getBsid() {
		return bsid;
	}
	
	public void setBsid(Long bsid) {
		this.bsid = bsid;
	}
	
	
 	
 	
}
