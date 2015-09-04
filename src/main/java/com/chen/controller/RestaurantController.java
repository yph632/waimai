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
	 * ����̣����жϵ����Ƿ���Cookie
	 * @param id business ��id
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
		/////////////////�ж�Cookie��ֵ,Ҳ����ͨ���ͻ����ж�//////////////////////
		ShopCar shopCar = null;
		if(StringUtils.isNotEmpty(car)){
			shopCar = new Gson().fromJson(car, ShopCar.class);
		}
		if(shopCar != null){
			List<FoodItem> foodItems = foodService.findFoodItemListByShopCar(shopCar);
			model.addAttribute("foodItems", foodItems);
			if(!shopCar.getBid().equals(business.getId())){
				//�����cookie���Ǳ��̵�Ķ���������request ֵcloseΪyes�������������ﳵ
				model.addAttribute("close", "yes"); 
			}
		}
		/////////////////�ж�cookie����//////////////////////
		Map<String, List<Food>> foodMap = foodService.findRestaurantMapByBid(business.getId());
		model.addAttribute("business", business);
		model.addAttribute("foodMap", foodMap);
		return "/restaurant";
	}
	
	
	//���빺�ﳵ������ȡ��ǰ��Ʒ��JSON����
	
    @RequestMapping(value = "/food",method = RequestMethod.GET)
    @ResponseBody
    public Message findFoodByBidAndfid(Long bid,Long fid,
    		@CookieValue(required = false)String car,
    		HttpServletResponse response) {
        Food food = foodService.findFoodById(fid);
        Business business = businessService.findBusinessById(bid);
        if(food == null || business == null) {
            //throw new NotFoundException();
        	return new Message("error", "�Ƿ����󣬷������ܾ�");
        }
        /*if(!food.getBsid().equals(bid)){
        	return new Message("error", "�õ����޸���Ʒ���������ܾ�");
        }*/
        if(!food.getFsales()){
        	return new Message("error","����Ʒ��ʱ�¼ܣ���ѡ��������Ʒ");
        }else{
        	return new Message("success", food);
        }
    }
	
    
//���빺�ﳵ������ȡ��ǰ��Ʒ��JSON����
	
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
        	return new Message("error", "�Ƿ����󣬷������ܾ�");
        }
        if(!food.getBsid().equals(bid)){
        	return new Message("error", "�õ����޸���Ʒ���������ܾ�");
        }
        if(!food.getFsales()){
        	return new Message("error", "����Ʒ��ʱ�¼ܣ���ѡ��������Ʒ");
        }
        //�жϳɹ���������һ��
        ShopCar shopCar = new ShopCar();
        if(StringUtils.isNotEmpty(car)){
        	//���Cookie���Ѿ��й��ﳵ������ô��cookieת��Ϊ���ﳵ����
        	shopCar = gson.fromJson(car, ShopCar.class);
        	if(!shopCar.getBid().equals(bid)){
        		//���cookie�е�bid����Ҫ��ӵ�bid��ͬ�������cookie
        		shopCar.setBid(null);
        		shopCar.getShopCarItems().clear();
        	}
        }else{//���cookie��û��ֵ���򴴽�һ��shopCar
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

/*//��ȡ��ǰ��Ʒ��JSON����
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
