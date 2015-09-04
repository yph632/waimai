package com.chen.service;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chen.dao.AccountMapper;
import com.chen.dao.AccountRoleMapper;
import com.chen.dao.RoleMapper;
import com.chen.entity.Account;
import com.chen.entity.Role;
import com.chen.util.Const;

@Service
@Transactional
public class AccountService {

	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private AccountRoleMapper accountRoleMapper;
	
	public Account isBusinessByPhone(String phone) {
		return accountMapper.isBusinessByPhone(phone);
	}

	public Account userLogin(String phone, String password){
		Account account = accountMapper.isBusinessByPhone(phone);
		Role role = roleMapper.findByName(Const.ROLE_USER);
		if(account != null && password.equals(account.getAcpassword())){
			if(accountRoleMapper.findByAccountAndRoleId(account.getId(), role.getId()) != null){
				return account;
			}
		}
		return null;
	}
	
	public Account businessLogin(String phone, String password) {
		Account account = accountMapper.findAccountByPhone(phone);
		Role role = roleMapper.findByName(Const.ROLE_BUSINESS);
		if(account != null && password.equals(account.getAcpassword())){
			if(accountRoleMapper.findByAccountAndRoleId(account.getId(), role.getId()) != null){
				return account;
			}
		}
		return null;
	}

	public int updatePassword(Account account) {
		return accountMapper.updatePassword(account);
	}

	public Account findAccountByPhone(String phone) {
		return accountMapper.findAccountByPhone(phone);
	}

	public int resetPassword(String phone, String password) {
		Account account = accountMapper.findAccountByPhone(phone);
		if(account != null){
			account.setAcpassword(DigestUtils.md5Hex(password));
			return accountMapper.resetPassword(account);
		}else{
			return -1;
		}
	}
	
}
