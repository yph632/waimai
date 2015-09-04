package com.chen.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chen.dto.Message;
import com.chen.entity.Account;
import com.chen.entity.Business;
import com.chen.entity.Food;
import com.chen.entity.Order;
import com.chen.exception.ServiceException;
import com.chen.service.AccountService;
import com.chen.service.BusinessService;
import com.chen.service.CommonsService;
import com.chen.service.FoodService;
import com.chen.service.OrderService;
import com.chen.util.Const;
import com.chen.util.QiniuUtil;
import com.chen.util.ServletUtil;
import com.mysql.jdbc.interceptors.SessionAssociationInterceptor;

@Controller
@RequestMapping("/shangjia")
public class ShangjiaController {

	@Autowired
	private CommonsService CommonsService;
	
	@Autowired
	private BusinessService BusinessService;
	@Autowired
	private FoodService foodService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private QiniuUtil qiniuUtil;
	
	@RequestMapping(value="/step1", method = RequestMethod.GET)
	public String shenqing1(){
		return "shangjia/shenqing1";
	}
	
	/**
	 * 商家注册步奏1 验证手机和注册码
	 * @param phone
	 * @param code
	 * @param session
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/step1" ,method = RequestMethod.POST)
    @ResponseBody
    public Message shenqing1Submit(String phone,String code, HttpSession session) {
        Map<String,Object> map = (Map<String, Object>) session.getAttribute("validateCode");

        Message message = null;

        try {
            CommonsService.validateCode(phone, code, map);
            session.removeAttribute("validateCode");
            //验证通过后，验证手机号是否已经绑定了商家
            Account account = accountService.isBusinessByPhone(map.get("phone").toString());
            if(account == null){
            	//如果该手机号可以注册，进入下一步
            	message = new Message("success"); //{state:"success"}
                session.setAttribute("phoneCode", phone);
            }else{
            	message = new Message("error","该手机已经绑定了商家账号");
            }
        }catch (ServiceException ex) {
            message = new Message("error",ex.getMessage());//{state:"error",message:"xx"}
        }
        return message;
    }
	
	
	@RequestMapping(value="/step2", method = RequestMethod.GET)
	public String shenqing2(HttpSession session, Model model){
		String phone = (String) session.getAttribute("phoneCode");
		if(phone == null){
			return "redirect:/shangjia";
		}else{
			String token = qiniuUtil.getToken();
			model.addAttribute("token", token);
			return "shangjia/shenqing_2";
		}
	}
	
	/**
	 * 商家注册步骤2
	 * @param business
	 * @param phone
	 * @return
	 */
	@RequestMapping(value="/step2", method = RequestMethod.POST)
	public String saveShenqing2(Business business){
		//if(business == null || phone == null){
		//	return "redirect:/shangjia/step1";
		//}
		BusinessService.saveBusiness(business);
		return "redirect:/shangjia/shenqingsuc";
	}
	
	@RequestMapping(value="/shenqingsuc", method = RequestMethod.GET)
	public String shenQingSuc(){
		return "shangjia/shenqing_result";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(){
		return "shangjia/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public Message businessLogin(String phone, String password,
			HttpSession session){
		password = DigestUtils.md5Hex(password);
		Account account = accountService.businessLogin(phone, password);
		if(account != null){
			Business business = BusinessService.findBusinessByAcid(account.getId());
			session.setAttribute(Const.ACCOUNT_IN_SESSION, account);
			session.setAttribute(Const.BUSINESS_IN_SESSION, business);
			return new Message("success", "账号密码正确");
		}else{
			return new Message("error", "账号或密码错误");
		}
		
	}
	
	/**
	 * 商家管理的主页
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/manage/home", method = RequestMethod.GET)
	public String home(HttpSession session, Model model){
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		if(business == null){
			return "redirect:/shangjia/login";
		}
		Map<String,Object> map = orderService.getBusinessStatistics(business.getId());
		//排名
		
		
        model.addAttribute("dataMap",map);
		return "shangjia/home";
	}
	
	
}
