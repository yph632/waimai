package com.chen;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;

public class Test {

	public static void main(String[] args) {
		Properties prop = new Properties();
		try {
			prop.load(Test.class.getClassLoader().getResourceAsStream("config.properties"));
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String ak = prop.getProperty("qiniu.ak");//"fTHk_0D6hVrcc8kVuz6TfQBLz-yO7Pe4hY2qhlFT";
		String sk = prop.getProperty("qiniu.sk");//"j8newmH_q3YmOxMdS3f0fbGyQh_8j9jOoq_mDuH2";
		String bucket = prop.getProperty("qiniu.bucket");//"rwaimai";
		UploadManager uploadManager = new UploadManager();
		File file = new File("F:/picture/11111.jpg");//(22222.jpg);
		
			Auth auth = Auth.create(ak, sk);
			String token = auth.uploadToken(bucket);
			try {
				Response resp = uploadManager.put(file, null, token);
				StringMap result = resp.jsonToMap();
				System.out.println(result.get("key").toString());
			} catch (QiniuException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

	}

}
