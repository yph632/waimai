package com.chen.dao;

import org.apache.ibatis.annotations.Update;

import com.chen.entity.Account;
//创建陈润航

public interface AccountMapper {

	
	public Account isBusinessByPhone(String phone);

	public Account findAccountByPhone(String phone);
	
	public void save(Account account);

	@Update("update t_account set acpassword = #{acpassword} where id = #{id}")
	public int updatePassword(Account account);

	@Update("update t_account set acpassword = #{acpassword} where id= #{id}")
	public int resetPassword(Account account);

	
	
}
