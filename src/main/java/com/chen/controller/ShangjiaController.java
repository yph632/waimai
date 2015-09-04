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
	 * �̼�ע�Ჽ��1 ��֤�ֻ���ע����
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
            //��֤ͨ������֤�ֻ����Ƿ��Ѿ������̼�
            Account account = accountService.isBusinessByPhone(map.get("phone").toString());
            if(account == null){
            	//������ֻ��ſ���ע�ᣬ������һ��
            	message = new Message("success"); //{state:"success"}
                session.setAttribute("phoneCode", phone);
            }else{
            	message = new Message("error","���ֻ��Ѿ������̼��˺�");
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
	 * �̼�ע�Ჽ��2
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
			return new Message("success", "�˺�������ȷ");
		}else{
			return new Message("error", "�˺Ż��������");
		}
		
	}
	
	/**
	 * �̼ҹ������ҳ
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
		//����
		
		
        model.addAttribute("dataMap",map);
		return "shangjia/home";
	}
	
	
}
