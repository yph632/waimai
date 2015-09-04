package com.chen.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chen.dao.FoodMapper;
import com.chen.dao.FoodTypeMapper;
import com.chen.dto.FoodItem;
import com.chen.dto.ShopCar;
import com.chen.dto.ShopCarItem;
import com.chen.entity.Business;
import com.chen.entity.Food;
import com.chen.entity.FoodType;
import com.chen.util.Const;
import com.chen.util.Pager;


@Service
@Transactional
public class FoodService {

	@Autowired
	private FoodMapper foodMapper;
	
	@Autowired
	private FoodTypeMapper foodTypeMapper;

	public Pager<Food> findFoodByPager(int pageNo, Map<String, Object> params) {
		
		Long count = foodMapper.count(params);
		Pager<Food> pager = new Pager<Food>(pageNo, count.intValue(), 10);
		params.put("pageStart", pager.getStart());
		params.put("pageSize", pager.getPageSize());
		List<Food> foodList = foodMapper.findFoodByMap(params);
		pager.setItems(foodList);
		return pager;
	}



	public Long saveFood(Business business, Food food) {
		food.setFsales(Const.FOOD_SALE);
		food.setBsid(business.getId());
        return foodMapper.saveFood(food);
	}



	public Food findFoodById(Long id) {
		return foodMapper.findFoodById(id);
	}



	public int delFood(Long id) {
		return foodMapper.delFood(id);
	}



	public int editFood(Food food) {
		return foodMapper.editFood(food);
	}



	public int editIsSales(Boolean fsales, Integer id) {
		return foodMapper.editIsSales(fsales, id);
	}



	/**
	 * 通过Business 的id查找店铺
	 * @param bid
	 * @return
	 */
	public Map<String, List<Food>> findRestaurantMapByBid(Long bid) {
		Map<String, List<Food>> mapList = new HashMap<String, List<Food>>();
		List<FoodType> foodTypes = foodTypeMapper.findAllFoodTypeByBusinessId(bid);
		for(FoodType foodType: foodTypes){
			List<Food> foodList = foodMapper.findFoodsByFoodTypeid(foodType.getId());
			mapList.put(foodType.getFtname(), foodList);
		}
		
		return mapList;
	}

	/**
	 * 通过shopCar查找FoodItem的list
	 * @param shopCar
	 * @return
	 */
	public List<FoodItem> findFoodItemListByShopCar(ShopCar shopCar) {
		List<FoodItem> foodItems = new ArrayList<FoodItem>();
		for(ShopCarItem scItem: shopCar.getShopCarItems()){
			Food food = findFoodById(scItem.getFoodId());
			FoodItem foodItem = new FoodItem(food, scItem.getNum());
			foodItems.add(foodItem);
		}
		return foodItems;
	}



	public List<Food> findFoodListByTopTen(Long businessId){
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("pageStart", 0);
		params.put("pageSize", 10);
		List<Food> foods = foodMapper.findFoodByMap(params);
		return foods;
	}





	

}
