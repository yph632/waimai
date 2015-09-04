package com.chen.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

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
import com.chen.dto.ShopCarItem;
import com.chen.entity.Business;
import com.chen.entity.Food;
import com.chen.exception.NotFoundException;
import com.chen.service.BusinessService;
import com.chen.service.FoodService;
import com.google.gson.Gson;

@Controller
@RequestMapping("/restaurant")
public class RestaurantController {

	@Autowired
	private BusinessService businessService;

	@Autowired
	private FoodService foodService;
	
	/**
	 * 入店铺，并判断店铺是否有Cookie
	 * @param id business 的id
	 * @param model
	 * @param Cookie car
	 * @return
	 */
	@RequestMapping(value = "/{id:\\d++}", method=RequestMethod.GET)
	public String showRestaurant(@PathVariable Long id,
			Model model, @CookieValue(required=false) String car){
		Business business = businessService.findBusinessById(id);
		if(business == null){
			throw new NotFoundException();
		}
		/////////////////判断Cookie的值,也可以通过客户端判断//////////////////////
		ShopCar shopCar = null;
		if(StringUtils.isNotEmpty(car)){
			shopCar = new Gson().fromJson(car, ShopCar.class);
		}
		if(shopCar != null){
			List<FoodItem> foodItems = foodService.findFoodItemListByShopCar(shopCar);
			model.addAttribute("foodItems", foodItems);
			if(!shopCar.getBid().equals(business.getId())){
				//如果该cookie不是本商店的订单，返回request 值close为yes。用于收缩购物车
				model.addAttribute("close", "yes"); 
			}
		}
		/////////////////判断cookie结束//////////////////////
		Map<String, List<Food>> foodMap = foodService.findRestaurantMapByBid(business.getId());
		model.addAttribute("business", business);
		model.addAttribute("foodMap", foodMap);
		return "/restaurant";
	}
	
	
	//放入购物车，并获取当前餐品的JSON数据
	
    @RequestMapping(value = "/food",method = RequestMethod.GET)
    @ResponseBody
    public Message findFoodByBidAndfid(Long bid,Long fid,
    		@CookieValue(required = false)String car,
    		HttpServletResponse response) {
        Food food = foodService.findFoodById(fid);
        Business business = businessService.findBusinessById(bid);
        if(food == null || business == null) {
            //throw new NotFoundException();
        	return new Message("error", "非法请求，服务器拒绝");
        }
        /*if(!food.getBsid().equals(bid)){
        	return new Message("error", "该店铺无该商品，服务器拒绝");
        }*/
        if(!food.getFsales()){
        	return new Message("error","该商品暂时下架，请选择其他商品");
        }else{
        	return new Message("success", food);
        }
    }
	
    
//放入购物车，并获取当前餐品的JSON数据
	
    @RequestMapping(value = "/food/add",method = RequestMethod.GET)
    @ResponseBody
    public Message addFoodByBidAndfid(Long bid,Long fid,
    		@CookieValue(required = false)String car,
    		HttpServletResponse response) {
        Food food = foodService.findFoodById(fid);
        Business business = businessService.findBusinessById(bid);
        Gson gson = new Gson();
        if(food == null || business == null) {
            //throw new NotFoundException();
        	return new Message("error", "非法请求，服务器拒绝");
        }
        if(!food.getBsid().equals(bid)){
        	return new Message("error", "该店铺无该商品，服务器拒绝");
        }
        if(!food.getFsales()){
        	return new Message("error", "该商品暂时下架，请选择其他商品");
        }
        //判断成功，继续下一步
        ShopCar shopCar = new ShopCar();
        if(StringUtils.isNotEmpty(car)){
        	//如果Cookie中已经有购物车对象，那么将cookie转换为购物车对象
        	shopCar = gson.fromJson(car, ShopCar.class);
        	if(!shopCar.getBid().equals(bid)){
        		//如果cookie中的bid和正要添加的bid不同，则清空cookie
        		shopCar.setBid(null);
        		shopCar.getShopCarItems().clear();
        	}
        }else{//如果cookie中没有值，则创建一个shopCar
        	shopCar = new ShopCar();
        }
        shopCar.setBid(bid);
        shopCar.savaShopCarItem(new ShopCarItem(fid, 1));
        Cookie cookie = new Cookie("car", gson.toJson(shopCar));
        cookie.setPath("/");
        cookie.setMaxAge(60*10);
        response.addCookie(cookie);
        //finally
        return new Message("success", food);
    }
   
}

/*//获取当前餐品的JSON数据
@RequestMapping(value = "/food",method = RequestMethod.GET)
@ResponseBody
public Food findByBidAndfid(Long bid,Long fid) {
    Food food = foodService.findFoodById(fid);
    if(food.getBsid().equals(bid)){
    	return food;
    }else{
    	return null;
    }
}*/

/*public String showRestaurant(@PathVariable Long id,
		Model model){
	Business business = businessService.findBusinessById(id);
	if(business == null){
		throw new NotFoundException();
	}
	
	Map<String, List<Food>> foodMap = foodService.findRestaurantMapByBid(business.getId());
	model.addAttribute("business", business);
	model.addAttribute("foodMap", foodMap);
	return "/restaurant";
}*/
