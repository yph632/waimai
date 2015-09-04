package com.chen.util;

import org.joda.time.DateTime;

import com.chen.entity.Account;
import com.chen.entity.Business;

public class OrderCodeUtil {

	public static String getGeratedOrderCode(Account account, Business business){
	
		//规则 时间戳+用户ID+商家ID
	    return new StringBuffer("D").
	    		append(DateTime.now().toString("yyMMddHHmmssms")).
	    		append("U").
	    		append(account.getId()).
	    		append("B").
	    		append(business.getId()).toString(); 
	}
	
}
