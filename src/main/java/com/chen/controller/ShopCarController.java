package com.chen.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chen.dto.FoodItem;
import com.chen.dto.Message;
import com.chen.dto.ShopCar;
import com.chen.entity.Account;
import com.chen.entity.Business;
import com.chen.entity.Food;
import com.chen.entity.Order;
import com.chen.exception.ForbiddenException;
import com.chen.exception.NotFoundException;
import com.chen.service.BusinessService;
import com.chen.service.FoodService;
import com.chen.service.OrderService;
import com.chen.util.Const;
import com.google.gson.Gson;

@Controller
@RequestMapping("shopcar")
public class ShopCarController {

	@Autowired
	private FoodService foodService;
	
	@Autowired
	private BusinessService businessService;
	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value = "/checkout",method = RequestMethod.GET)
    public String checkout(@CookieValue(required = false) String car,Model model) {
        List<FoodItem> foodItems = null;
        Business business = null;
        
        if(StringUtils.isNotEmpty(car)) {
            ShopCar shopCar = new Gson().fromJson(car,ShopCar.class);
            foodItems = foodService.findFoodItemListByShopCar(shopCar);
            business = businessService.findBusinessById(shopCar.getBid());
        }
        model.addAttribute("business",business);
        model.addAttribute("foodItems",foodItems);
        return "shopcar";
    }

	@RequestMapping(value = "/checkout", method = RequestMethod.POST)
	@ResponseBody
	public Message saveOrder(@CookieValue(required = false) String car,
			Order order, Model model, HttpSession session){
		List<FoodItem> foodItems = null;
		Business business = (Business) session.getAttribute(Const.BUSINESS_IN_SESSION);
		ShopCar shopCar = null;
		if(StringUtils.isNotEmpty(car)){
			shopCar = new Gson().fromJson(car, ShopCar.class);
		}
		
		if(shopCar == null){
			//throw new ForbiddenException();
			new Message("error", "购物车为空，请选择商品后再购买");
		}
		//获取session中的值，判断session是否已经存在，和继续一下操作
		Account account = (Account) session.getAttribute(Const.ACCOUNT_IN_SESSION);
		if(account == null){
			account = orderService.saveOrder(order, account, shopCar);
			session.setAttribute(Const.ACCOUNT_IN_SESSION, account);
		}else{
			account = orderService.saveOrder(order, account, shopCar);
		}
		return new Message("success", "订单处理成功");
	}
	

    /**
     * 清空购物车
     * @param response
     * @return
     */
    @RequestMapping(value = "/clean",method = RequestMethod.GET)
    @ResponseBody
    public String cleanShopCar(HttpServletResponse response) {
        Cookie cookie = new Cookie("car","");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
        return "yes";
    }


    /**
     * 从购物车中删除项
     * @return
     */
    @RequestMapping(value = "/del/{id:\\d+}",method = RequestMethod.GET)
    @ResponseBody
    public Food removeItemFromCar(@PathVariable Long id,@CookieValue String car,HttpServletResponse response) {

        Food food = foodService.findFoodById(id);
        if(food == null) {
            throw new NotFoundException();
        }

        Gson gson = new Gson();

        ShopCar shopCar = gson.fromJson(car,ShopCar.class);
        shopCar.removeItem(id);

        Cookie cookie = new Cookie("car",gson.toJson(shopCar));
        cookie.setMaxAge(60*60*24);
        cookie.setPath("/");
        response.addCookie(cookie);

        return food;
    }
	
}
