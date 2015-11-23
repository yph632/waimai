package com.chen.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 *@Author 陈润航
 */
public interface AccountRoleMapper {

	@Insert("insert t_account_role(aid, rid)values(#{aid}, #{rid})")
	public int save(@Param(value = "aid") Long aid, @Param(value = "rid") Long rid);

	@Select("select aid, rid from t_account_role where aid=#{aid} and rid = #{rid}")
	public Object findByAccountAndRoleId(@Param(value="aid")Long aid, @Param(value="rid")Long rid);
	
}
