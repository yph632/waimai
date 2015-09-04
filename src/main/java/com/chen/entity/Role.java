package com.chen.entity;

import java.io.Serializable;

public class Role implements Serializable{

	
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String rolename;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	
}
