package com.chen.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.chen.entity.Business;
import com.chen.service.BusinessService;
import com.chen.util.Const;
import com.chen.util.Pager;

@Controller
public class IndexController {

	@Autowired
	private BusinessService businessService;
	
	/**
	 * 
	 * @param model
	 * @param request
	 * @param p 页码
	 * @param category 商家类型
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model){
		List<Business> businessList = businessService.findAllBusinessForShow();
		model.addAttribute("shopTypes", Const.BUSINESS_TYPES);
        model.addAttribute("businessList",businessList);
		return "index";
	}
	
}
