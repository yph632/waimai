package com.chen.util;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;

@Component
public class QiniuUtil {

	private Logger logger  = LoggerFactory.getLogger(QiniuUtil.class);
	
	@Value("${qiniu.ak}")
	private String ak; //七牛ak
	
	@Value("${qiniu.sk}")	
	private String sk; //七牛sk
	
	@Value("${qiniu.bucket}")
	private String bucket; //选择的七牛空间名称
	
	private static UploadManager uploadManager = new UploadManager();
	
	public String getToken(){
		Auth auth = Auth.create(ak, sk);
		String token = auth.uploadToken(bucket);
		return token;
	}
	
	public String uploadFile(byte[] bytes){
		if(bytes == null){
			System.out.println("bytes is null");
		}
		String token = getToken();
		try {
			Response response = uploadManager.put(bytes, null, token);
			StringMap resultMap = response.jsonToMap();
			logger.debug("七牛云key{}",resultMap.get("key").toString());
			return resultMap.get("key").toString();
		} catch (QiniuException e) {
			logger.error("七牛上传文件异常{}, {}",e.getMessage(), e.getLocalizedMessage());
			throw new RuntimeException("上传文件到七牛云存储异常",e);
			//e.printStackTrace();
		}
	}
}
