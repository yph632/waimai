package com.chen.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.chen.entity.FoodType;

/**
 *@Author 陈润航 
 */

public interface FoodTypeMapper {

	@Select(" select id, ftname, ftindex, bsid from t_foodtype where bsid = #{bsid} ")
	public List<FoodType> findAllFoodTypeByBusinessId(@Param(value = "bsid") Long businessid);

	@Insert(" insert into t_foodtype(ftname, ftindex, bsid)values(#{ftname}, #{ftindex}, #{bsid}) ")
	public int saveFoodType(FoodType foodType);

	@Select(" select id, ftname, ftindex, bsid from t_foodtype where id = #{id} ")
	public FoodType findFoodTypeById(@Param(value = "id")Long typeid);

	@Update(" update t_foodtype set ftname = #{ftname}, ftindex=#{ftindex} where id = #{id}")
	public int editFoodType(FoodType foodType);

	@Update(" delete from t_foodType where id = #{typeid} ")
	public int delFoodTypeById(Long typeid);

	
	
}
