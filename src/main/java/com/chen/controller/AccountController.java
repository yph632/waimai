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
	 *   �޸��˺ŵ�����
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
				return new Message("success", "�����޸ĳɹ�");
			}else{
				Logger.error("�����������쳣��");
				return new Message("error", "������æ�����Ժ�����");
			}
		}else{
			return new Message("error", "�����ʽ����");
		}
	}
	
	/**
	 * �ض������������ҳ��
	 * @param url ��¼��������ҳ����һ����ҳ
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
	 * post���󣬽����ֻ��ţ������ֻ���֤�룬����ת������д��֤���jspҳ��
	 * @param phone
	 * @param redirectAttributes
	 * @param session 
	 * @return
	 */
	@RequestMapping(value = "/password/reset", method = RequestMethod.POST)
	public String resetPassword(String phone, RedirectAttributes redirectAttributes, HttpSession session){
		Account account = accountService.findAccountByPhone(phone);
		if(account != null){
			//���Ͷ�Ϣ֪ͨ
			String code = commonsService.sendValidateCode(phone);
			
			Map<String,Object> map = new HashMap<String, Object>();
            map.put("phone",phone);
            map.put("code",code);
            map.put("time", DateTime.now());
            //��������Ż���	
            session.setAttribute("validateCode",map);

            redirectAttributes.addFlashAttribute("phone",phone);
            //��������Ż���
            session.setAttribute("confirm_phone", phone);
            return "redirect:/account/password/reset/confirm";
        } else {
            redirectAttributes.addFlashAttribute("message","���˺Ų�����");
            return "redirect:/account/password/reset";
		}
	}
	
	@RequestMapping(value = "/password/reset/confirm", method = RequestMethod.GET)
	public String resetPasswordConfirm(){
		return "account/resetconfirm";
	}
	
	/**
	 * ��֤�ֻ��ź���֤�룬�ɹ�����ת�޸�ҳ��
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
		//ȡ��session�е�ֵ����÷��뻺��
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
	 * ��������ϸ���ת�޸�����dejspҳ��
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
	 * �������룬������������õ����һ�������ύ��������м�飬����������
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
				
	            redirectAttributes.addFlashAttribute("message","�������óɹ�");
	            return new StringBuffer("redirect:").append(url_back).toString();
			}else{
				return "redirect:/account/password/reset";
			}
		}
	}
	
	/**
	 * �˳��˺ţ�ɾ�����˺ŵ�session
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/shangjia/manage/login";
	}
	
	
}
