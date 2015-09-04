package com.chen.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.chen.entity.Food;
/**
 * @Author 陈润航
 * */
public interface FoodMapper {

	
	public Long count(Map<String, Object> params);

	public List<Food> findFoodByMap(Map<String, Object> params);

	public Long saveFood(Food food);

	public Food findFoodById(Long id);

	@Delete("delete from t_food where id = #{id} ")
	public int delFood(Long id);

	
	public int editFood(Food food);

	@Update("update t_food set fsales= #{fsales} where id=#{id}")
	public int editIsSales(@Param(value = "fsales")Boolean fsales, @Param(value="id")Integer id);

	
	@Select("SELECT id , fname, fprice, fphoto, findex, fsales, ftid FROM t_food where ftid = #{ftid}")
	public List<Food> findFoodsByFoodTypeid(Long id);

	
	
	
}
