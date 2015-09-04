package com.chen.service;



import java.util.List;

import org.apache.commons.lang3.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chen.dao.AccountMapper;
import com.chen.dao.AccountRoleMapper;
import com.chen.dao.BusinessMapper;
import com.chen.dao.RoleMapper;
import com.chen.entity.Account;
import com.chen.entity.Business;
import com.chen.entity.Role;
import com.chen.util.Const;
import com.chen.util.QiniuUtil;
import com.chen.util.ServletUtil;


@Service
@Transactional
public class BusinessService {

	@Autowired
	private BusinessMapper businessMapper;
	
	@Autowired
	private AccountMapper accountMapper;

	@Autowired
	private RoleMapper roleMapper;
	
	@Autowired
	private AccountRoleMapper accountRoleMapper;
	
	@Autowired
	private QiniuUtil qiniuUtil;
	
	private Logger logger = LoggerFactory.getLogger(BusinessService.class);
	
	public void saveBusiness(Business business) {
		//1.  验证当前账号是否存在
		Account account = accountMapper.findAccountByPhone(business.getBstel());
		if(account == null){
			//2.根据手机号码创建一个新的账号，随机产生一个密码通过短信告知用户
			String password = RandomStringUtils.randomAlphanumeric(6);
			logger.debug("this phone is {}, this password is{}",business.getBstel(),password);	
			//发送短信
				/*
				 * 发送短信代码
				 */
				//
				account = new Account();
				account.setAcname(business.getBstel());
				account.setAccreatetime(ServletUtil.getNowtime());
				account.setAcpassword(password);
				account.setAcnickname(business.getBstel());
				accountMapper.save(account);
		}
		//将账号添加为商家权限
		//a.从role表中查找商家权限的id
		Role role = roleMapper.findByName(Const.ROLE_BUSINESS);
		accountRoleMapper.save(account.getId(), role.getId());
		
		//将商家与账号进行绑定
		business.setAcid(account.getId());
		
		/*//图片存储
		try {
			String photoKey = qiniuUtil.uploadFile(photo.getBytes());
			business.setBscardphoto(photoKey);
		} catch (IOException e) {
			System.out.println(e.getMessage());
			throw new ServiceException("七牛文件上传失败",e);
			//e.printStackTrace();
		}*/
		//business.setBscardphoto("===");
		businessMapper.save(business);
		
	}

	public Business findBusinessByAcid(Long acid) {
		return businessMapper.findBusinessByAcid(acid);
	}

	public List<Business> findAllBusinessForShow() {
		return businessMapper.findAllBusinessForShow();
	}

	public Business findBusinessById(Long id) {
		return businessMapper.findBusinessById(id);
	}

	public int updateBusinessInfo(Business business) {
		return businessMapper.updateBusinessInfo(business);
	}

	public Business findBusinessInfoById(Long bid) {
		return businessMapper.findBusinessById(bid);
	}
	
}
