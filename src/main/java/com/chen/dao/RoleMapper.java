package com.chen.dao;


import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Select;

import com.chen.entity.Role;

@CacheNamespace
public interface RoleMapper {

	@Select("select id, rolename from t_role where rolename = #{rolename}")
	Role findByName(String rolename);

}
