package com.chen.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chen.dto.Message;
import com.chen.entity.Account;
import com.chen.entity.Business;
import com.chen.entity.Order;
import com.chen.entity.OrderItem;
import com.chen.exception.ForbiddenException;
import com.chen.exception.NotFoundException;
import com.chen.service.AccountService;
import com.chen.service.BusinessService;
import com.chen.service.OrderService;
import com.chen.util.Const;
import com.squareup.okhttp.Request;

@Controller
@RequestMapping("/u")
public class UserController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private AccountService accountService;
	@Autowired
	private BusinessService BusinessService;
	
	/**
	 * 普通账号登陆，请求转发到登陆的jsp页面
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String accountLogin(){
		return "account/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public Message userLogin(String phone, String password,
			HttpSession session){
		password = DigestUtils.md5Hex(password);
		Account account = accountService.userLogin(phone, password);
		if(account != null){
			session.setAttribute(Const.ACCOUNT_IN_SESSION, account);
			return new Message("success", "账号密码正确");
		}else{
			return new Message("error", "账号或密码错误");
		}
		
	}
	
	@RequestMapping(value = "/orders/{orderid:\\d+}/cancel", method = RequestMethod.GET)
	public String changeOrderState(@PathVariable Long orderid, HttpSession session,
			RedirectAttributes redirectAttributes){
		Account account = (Account) session.getAttribute(Const.ACCOUNT_IN_SESSION);
		Order order = orderService.findOrderByOrderId(orderid);
		if(order == null || account == null){
			throw new NotFoundException();
		}
		if(!order.getAcid().equals(account.getId())){
			throw new ForbiddenException();
		}
		orderService.changeOrderState(order, "cancel", false);
		redirectAttributes.addFlashAttribute("message","订单状态改变成功");
        return "redirect:/u/orders/"+order.getOrdercode();
	}
	
	@RequestMapping(value = "/orders", method = RequestMethod.GET)
	public String orderList(HttpSession session ,Model model){
		Account account = (Account) session.getAttribute(Const.ACCOUNT_IN_SESSION);
		List<Order> orderList = orderService.findOrderByAccountId(account.getId());
		model.addAttribute("orderList", orderList);
		return "orders";
	}
	
	@RequestMapping(value = "/orders/{orderCode}", method = RequestMethod.GET)
	public String showOrderItem(@PathVariable String orderCode, Model model, HttpSession session){
		Order order = orderService.findOrderByOrderCode(orderCode);
		if(order != null){
			Business business = BusinessService.findBusinessById(order.getBsid());
			List<OrderItem> orderItems = orderService.findOrderItemByOrderId(order.getId());
			model.addAttribute("business", business);
			model.addAttribute("order", order);
			model.addAttribute("orderItems",orderItems);
		}
		return "orders-info";
	}
	
}
