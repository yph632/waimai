package com.chen.entity;

import java.io.Serializable;

public class Account implements Serializable{

	private static final long serialVersionUID = 1L;

	private Long id;
	private String acname;
	private String acpassword;
	private String accreatetime;
	private String aclogintime;
	private String acloginip;
	private String acnickname;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getAcname() {
		return acname;
	}
	public void setAcname(String acname) {
		this.acname = acname;
	}
	public String getAcpassword() {
		return acpassword;
	}
	public void setAcpassword(String acpassword) {
		this.acpassword = acpassword;
	}
	public String getAccreatetime() {
		return accreatetime;
	}
	public void setAccreatetime(String accreatetime) {
		this.accreatetime = accreatetime;
	}
	public String getAclogintime() {
		return aclogintime;
	}
	public void setAclogintime(String aclogintime) {
		this.aclogintime = aclogintime;
	}
	public String getAcloginip() {
		return acloginip;
	}
	public void setAcloginip(String acloginip) {
		this.acloginip = acloginip;
	}
	public String getAcnickname() {
		return acnickname;
	}
	public void setAcnickname(String acnickname) {
		this.acnickname = acnickname;
	}
	
}
