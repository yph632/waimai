package com.chen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chen.dao.FoodTypeMapper;
import com.chen.entity.FoodType;

@Service
@Transactional
public class FoodTypeService {

	@Autowired
	private FoodTypeMapper foodTypeMapper;
	
	public List<FoodType> findAllFoodTypeByBusinessId(Long businessid) {
		return foodTypeMapper.findAllFoodTypeByBusinessId(businessid);
	}

	public int saveFoodType(FoodType foodType) {
		return foodTypeMapper.saveFoodType(foodType);
	}

	public FoodType findFoodTypeById(Long typeid) {
		return foodTypeMapper.findFoodTypeById(typeid);
	}

	public int editFoodType(FoodType foodType) {
		return foodTypeMapper.editFoodType(foodType);
	}

	public int delFoodTypeById(Long typeid) {
		return foodTypeMapper.delFoodTypeById(typeid);
	}
	
}
