package com.chen.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chen.dto.Message;
import com.chen.entity.Account;
import com.chen.entity.Business;
import com.chen.service.AccountService;
import com.chen.service.BusinessService;
import com.chen.service.CommonsService;
import com.chen.util.Const;

@Controller
@RequestMapping("/account")
public class AccountController {

	
	private Logger Logger = LoggerFactory.getLogger(AccountController.class);
	
	@Autowired
	private AccountService accountService;
	@Autowired
	private BusinessService businessService;
	@Autowired
	private CommonsService commonsService;

	
	@RequestMapping(value = "/alterPwd", method = RequestMethod.GET)
	public String resetPassword(){
		return "account/alterpwd";
	}
	
	/**
	 *   修改账号的密码
	 * @param oldPwd
	 * @param newPwd
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/alterPwd", method = RequestMethod.POST)
	@ResponseBody
	public Message motifyPassword(String oldPwd, String newPwd,
			HttpSession session){
		Account account = (Account) session.getAttribute(Const.ACCOUNT_IN_SESSION);
		if(account != null && account.getAcpassword().equals(oldPwd)
				&& newPwd != null){
			account.setAcpassword(newPwd);
			if(accountService.updatePassword(account) > 0){
				return new Message("success", "密码修改成功");
			}else{
				Logger.error("服务器发生异常！");
				return new Message("error", "服务器忙，请稍后重试");
			}
		}else{
			return new Message("error", "请求格式错误");
		}
	}
	
	/**
	 * 重定向到忘记密码的页面
	 * @param url 记录来到该网页的上一个网页
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/password/reset", method = RequestMethod.GET)
	public String toResetPwd(@RequestParam(required = false, defaultValue = "/user/login")String url,
			HttpSession session){
		session.setAttribute("reset_back", url);
		return "account/resetpassword";
	}
	
	/**
	 * post请求，接受手机号，发送手机验证码，请求转发到填写验证码的jsp页面
	 * @param phone
	 * @param redirectAttributes
	 * @param session 
	 * @return
	 */
	@RequestMapping(value = "/password/reset", method = RequestMethod.POST)
	public String resetPassword(String phone, RedirectAttributes redirectAttributes, HttpSession session){
		Account account = accountService.findAccountByPhone(phone);
		if(account != null){
			//发送短息通知
			String code = commonsService.sendValidateCode(phone);
			
			Map<String,Object> map = new HashMap<String, Object>();
            map.put("phone",phone);
            map.put("code",code);
            map.put("time", DateTime.now());
            //最佳做法放缓存	
            session.setAttribute("validateCode",map);

            redirectAttributes.addFlashAttribute("phone",phone);
            //最佳做法放缓存
            session.setAttribute("confirm_phone", phone);
            return "redirect:/account/password/reset/confirm";
        } else {
            redirectAttributes.addFlashAttribute("message","该账号不存在");
            return "redirect:/account/password/reset";
		}
	}
	
	@RequestMapping(value = "/password/reset/confirm", method = RequestMethod.GET)
	public String resetPasswordConfirm(){
		return "account/resetconfirm";
	}
	
	/**
	 * 验证手机号和验证码，成功？跳转修改页面
	 * @param phone
	 * @param code
	 * @param session
	 * @param redirectAttributes
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/password/reset/confirm", method = RequestMethod.POST)
	public String resetPasswordConfirm(String phone, String code, 
			HttpSession session, RedirectAttributes redirectAttributes){
		//取出session中的值，最好放入缓存
		phone = (String) session.getAttribute("confirm_phone");
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("validateCode");
		if(StringUtils.isEmpty(phone) || StringUtils.isEmpty(code)){
			return "redirect:/account/password/reset";
		}else{
			try{
				commonsService.validateCode(phone, code, map);
				session.removeAttribute("validateCode");
				session.removeAttribute("confirm_phone");
				session.setAttribute("reset_phone",phone);
				return "redirect:/account/password/resetnew";
			}catch(Exception ex){
				redirectAttributes.addFlashAttribute("message",ex.getMessage());
                return "redirect:/account/password/reset";
			}
		}
	}
	
	/**
	 * 如果条件合格，跳转修改密码dejsp页面
	 * @param session
	 * @return
	 */
	@RequestMapping(value =  "/password/resetnew", method = RequestMethod.GET)
	public String resetNewPassword(HttpSession session){
		String phone = (String) session.getAttribute("reset_phone");
		if(phone == null){
			return "redirect:/account/password/reset";
		}else{
			return "account/resetnew";
		}
	}
	
	/**
	 * 忘记密码，对密码进行重置的最后一步，对提交的密码进行检查，并更新密码
	 * @param password
	 * @param session
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/password/resetnew", method = RequestMethod.POST)
	public String resetNewPassword(String password, HttpSession session,
			RedirectAttributes redirectAttributes){
		String phone = (String) session.getAttribute("reset_phone");
		if(phone == null || StringUtils.isEmpty(password)){
			return "redirect:/account/password/reset";
		}else{
			if(accountService.resetPassword(phone, password) > 0){
				String url_back = (String) session.getAttribute("reset_back");
				session.removeAttribute("reset_phone");
				session.removeAttribute("reset_back");
				
	            redirectAttributes.addFlashAttribute("message","密码重置成功");
	            return new StringBuffer("redirect:").append(url_back).toString();
			}else{
				return "redirect:/account/password/reset";
			}
		}
	}
	
	/**
	 * 退出账号，删除该账号的session
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/shangjia/manage/login";
	}
	
	
}
