package com.chen.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.chen.entity.Business;
import com.chen.entity.Order;
import com.chen.entity.OrderItem;
import com.chen.exception.ForbiddenException;
import com.chen.exception.NotFoundException;
import com.chen.service.BusinessService;
import com.chen.service.OrderService;
import com.chen.util.Const;
import com.chen.util.Pager;
import com.chen.util.QiniuUtil;
import com.chen.util.ServletUtil;

@Controller
@RequestMapping("/shangjia/manage")
public class BusinessController {

	@Autowired
	private BusinessService businessService;
	
	@Autowired
	private QiniuUtil qiniuUtil;
	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value = "/shop", method = RequestMethod.GET)
	public String showBusinessInfo(Model model, HttpSession session){
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		Business businessInfo = businessService.findBusinessInfoById(business.getId());
		model.addAttribute("businessInfo", businessInfo);
		return "shangjia/shopinfo";
	}
	
	@RequestMapping(value = "/shop/edit", method = RequestMethod.GET)
	public String editShopInfo(Model model, HttpSession session){
		String token = qiniuUtil.getToken();
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		Business businessInfo = businessService.findBusinessInfoById(business.getId());
		model.addAttribute("businessInfo", businessInfo);
		model.addAttribute("token", token);
		return "shangjia/shopedit";
	}
	
	@RequestMapping(value = "/shop/edit", method = RequestMethod.POST)
	@ResponseBody
	public Message editShopInfo(Business business, HttpSession session){
		Business businessTemp = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		if(businessTemp == null || !business.getId().equals(businessTemp.getId())){
			return new Message("error", "�Ƿ��û�");
		}
		Business businessInfo = businessService.findBusinessInfoById(business.getId());
		if(!business.equals(businessInfo)){
			businessService.updateBusinessInfo(business);
		}
		return new Message("success", "edit business success");
	}
	
	/**
     * ��ʾ�̼ҵ����ж���
     */
	@RequestMapping(value = "/orders", method = RequestMethod.GET)
	public String orders(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(value = "p", required = false, defaultValue = "1")int pageNo){
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		Map<String, Object> param = ServletUtil.builderParam(request);
		param.put("bsid", business.getId());
		Pager<Order> page = orderService.findOrderByBusinessId(pageNo, param);
		model.addAttribute("page", page);
		return "shangjia/orders";
	}
	
	/**
	 **���ݶ����ţ���ʾ��������ϸ��Ϣ
     */
	@RequestMapping(value = "/orders/{orderCode}", method = RequestMethod.GET)
	public String showOrderInfo(@PathVariable String orderCode, HttpSession session, Model model){
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		Order order = orderService.findOrderByOrderCode(orderCode);
		if(order != null){
			List<OrderItem> orderItems = orderService.findOrderItemByOrderId(order.getId());
			model.addAttribute("orderItems", orderItems);
			model.addAttribute("order", order);
		}
		model.addAttribute("business", business);
		return "shangjia/orders-info";
	}
	
	/**
	 * �޸Ķ���״̬
	 */
	@RequestMapping(value="/orders/{orderid:\\d+}/{orderstate}", method = RequestMethod.GET)
	public String editOrderState(@PathVariable Long orderid, @PathVariable String orderstate,
			HttpSession session,
			RedirectAttributes redirectAttributes){
		Business business = (Business)session.getAttribute(Const.BUSINESS_IN_SESSION);
		Order order = orderService.findOrderByOrderId(orderid);
		if(order == null){
			throw new NotFoundException();
		}
		if(!order.getBsid().equals(business.getId())){
			throw new ForbiddenException();
		}
		orderService.changeOrderState(order, orderstate, true);
		redirectAttributes.addFlashAttribute("message","����״̬�ı�ɹ�");
        return "redirect:/shangjia/manage/orders/"+order.getOrdercode();
	}
}
