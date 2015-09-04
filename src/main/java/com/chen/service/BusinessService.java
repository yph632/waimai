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
		//1.  ��֤��ǰ�˺��Ƿ����
		Account account = accountMapper.findAccountByPhone(business.getBstel());
		if(account == null){
			//2.�����ֻ����봴��һ���µ��˺ţ��������һ������ͨ�����Ÿ�֪�û�
			String password = RandomStringUtils.randomAlphanumeric(6);
			logger.debug("this phone is {}, this password is{}",business.getBstel(),password);	
			//���Ͷ���
				/*
				 * ���Ͷ��Ŵ���
				 */
				//
				account = new Account();
				account.setAcname(business.getBstel());
				account.setAccreatetime(ServletUtil.getNowtime());
				account.setAcpassword(password);
				account.setAcnickname(business.getBstel());
				accountMapper.save(account);
		}
		//���˺����Ϊ�̼�Ȩ��
		//a.��role���в����̼�Ȩ�޵�id
		Role role = roleMapper.findByName(Const.ROLE_BUSINESS);
		accountRoleMapper.save(account.getId(), role.getId());
		
		//���̼����˺Ž��а�
		business.setAcid(account.getId());
		
		/*//ͼƬ�洢
		try {
			String photoKey = qiniuUtil.uploadFile(photo.getBytes());
			business.setBscardphoto(photoKey);
		} catch (IOException e) {
			System.out.println(e.getMessage());
			throw new ServiceException("��ţ�ļ��ϴ�ʧ��",e);
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
