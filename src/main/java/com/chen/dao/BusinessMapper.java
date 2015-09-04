package com.chen.dao;

import java.util.List;

import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Select;

import com.chen.entity.Business;

@CacheNamespace
public interface BusinessMapper {

	public Long save(Business business);

	@Select("select id, bsname, bsaddress, bsman, bstel, bscontent, bslat, bslng, bscardphoto, bscardnum,bscardaddress, bstype, bspoststartprice, bspostprice, bsphoto, bsamhourstart, acid, bsamhourend, bspmhourstart, bspmhourend"
			+" from t_business where acid = #{acid}")
	public Business findBusinessByAcid(Long acid);

	public int updateBusinessInfo(Business business);

	@Select("select id, bsname, bsaddress, bsman, bstel, bscontent, bslat, bslng, bscardphoto, bscardnum,bscardaddress, bstype, bspoststartprice, bspostprice, bsphoto, bsamhourstart, acid, bsamhourend, bspmhourstart, bspmhourend"
			+" from t_business ")
	public List<Business> findAllBusinessForShow();

	@Select("select id, bsname, bsaddress, bsman, bstel, bscontent, bslat, bslng, bscardphoto, bscardnum,bscardaddress, bstype, bspoststartprice, bspostprice, bsphoto, bsamhourstart, acid, bsamhourend, bspmhourstart, bspmhourend"
			+" from t_business where id=#{id}")
	public Business findBusinessById(Long id);

	
	
}
