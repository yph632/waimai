package com.chen.service;

import java.util.Map;

import org.apache.commons.lang3.RandomStringUtils;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chen.exception.ServiceException;

@Service
@Transactional
public class CommonsService {

	private Logger logger = LoggerFactory.getLogger(CommonsService.class);
	
	/**
	 * 发送手机验证码
	 * @param phone
	 * @return code
	 */
	public String sendValidateCode(String phone) {
		String code = RandomStringUtils.randomNumeric(6);
		logger.debug("手机号为： {} 的验证码为:  {}",phone, code);
		System.out.println("验证码为：" + code);
		/////////发送短信的业务//////////
		
		///////////////////////
		
		return code;
	}

	/**
     * 表单提交验证验证码是否正确
     * @param phone
     * @param code
     * @param map
     */
    public void validateCode(String phone, String code, Map<String, Object> map) {

        //1. 验证时间是否在5分钟内
        //2. 验证手机号和验证码是否正确
    	
        if (map != null){

            DateTime createTime = (DateTime) map.get("time");
            String oldPhone = (String) map.get("phone");
            String oldCode = (String) map.get("code");

            if (createTime.plusMinutes(5).isAfterNow()) {
                if (!(oldCode.equals(code) && oldPhone.equals(phone))) {
                    throw new ServiceException("验证码错误.");
                }
            } else {
                throw new ServiceException("验证码已过期");
            }
        }else{
            throw new ServiceException("验证码错误");
        }
    }

}
