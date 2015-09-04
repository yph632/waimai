package com.chen.util;

import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;

public class ServletUtil {

	public static Map<String, Object> builderParam(HttpServletRequest request) {
		Enumeration<String> names = request.getParameterNames();
		Map<String, Object> params = new HashMap<String, Object>();
		while (names.hasMoreElements()) {
			String key = names.nextElement();
			String value = request.getParameter(key);
			System.out.println(key);
			if(key.startsWith("_") && StringUtils.isNotEmpty(value)){
				try {
					value = new String(value.getBytes("ISO8859-1"), "UTF-8");
					request.setAttribute(key, value);
					params.put(key, value);
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}
		}
		return params;
	}

	
	public static String getIp(HttpServletRequest request){
		String ip = request.getRemoteAddr();
		if("0:0:0:0:0:0:0:1".equals(ip)){
			ip = "127.0.0.1";
		}
		return ip;
	}
	
	
	public static String getNowtime(){
		return DateTime.now().toString("yyyy-MM-dd HH:mm");
	}
	
	public static String getNowDate(){
		return DateTime.now().toString("yyyy-MM-dd HH:mm");
	}
	
}
