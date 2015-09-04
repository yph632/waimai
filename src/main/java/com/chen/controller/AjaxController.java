package com.chen.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chen.dao.AccountMapper;
import com.chen.dto.Message;
import com.chen.entity.Account;
import com.chen.entity.Business;
import com.chen.entity.Food;
import com.chen.entity.Order;
import com.chen.exception.ServiceException;
import com.chen.service.AccountService;
import com.chen.service.CommonsService;
import com.chen.service.FoodService;
import com.chen.service.OrderService;
import com.chen.util.Const;

@Controller
@RequestMapping("/api")
public class AjaxController {

	private Logger Logger = LoggerFactory.getLogger(AjaxController.class);
	
	@Autowired
	private CommonsService commonsService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private FoodService foodService;
	
	@RequestMapping(value = "/sms/validatecode", method = RequestMethod.POST)
	@ResponseBody
	public String sendValidateCode(String phone, HttpSession session){
		Account account = accountService.isBusinessByPhone(phone);
		if(account != null){
			//Logger.debug("this phone is available");
			//return "no";
		}else{
			Logger.debug("this phone is available");
		}
		String code = commonsService.sendValidateCode(phone);
		//最有做法是使用缓存
		///以后更新为缓存实现
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("phone", phone);
		map.put("time",DateTime.now());
		map.put("code", code);
		session.setAttribute("validateCode", map);
		Logger.debug("this phone's code is {} ,请在5分钟之内提交验证码", code);
		return "yes";
	}

	/**
    * 发送验证码
    * @param phone
    * @param session
    * @return
    */
   @RequestMapping(value = "/sms/user/validatecode",method = RequestMethod.POST)
   @ResponseBody
   public String sendValidateCode2(String phone,HttpSession session) {
       String code = commonsService.sendValidateCode(phone);

       Map<String,Object> map = new HashMap<String, Object>();
       map.put("phone",phone);
       map.put("code",code);
       map.put("time", DateTime.now());

       session.setAttribute("validateCode",map);
       return "yes";
   }

    @SuppressWarnings("unchecked")
	@RequestMapping(value = "/sms/validatecallback",method = RequestMethod.POST)
    @ResponseBody
    public Message validateSmsCode(String phone,String code,HttpSession session) {
        Map<String,Object> map = (Map<String, Object>) session.getAttribute("validateCode");
        Message message = new Message();
        try {
            commonsService.validateCode(phone, code, map);
            message.setState("success");
        } catch (ServiceException ex) {
            message.setState("error");
            message.setMessage(ex.getMessage());
        }
        return  message;
    }
    
    @RequestMapping(value = "/manage/home", method = RequestMethod.GET)
	@ResponseBody
    public Message home(HttpSession session, Model model){
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		if(business == null){
			return new Message("error","账号为登陆");
		}
		List <Food> foods = foodService.findFoodListByTopTen(business.getId());
		for(int i = 0; i < foods.size(); i++){
			
		}
		//return new Message("success", map);
		return null;
	}
	
}
