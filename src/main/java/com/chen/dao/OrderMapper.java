package com.chen.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.chen.entity.Order;

public interface OrderMapper {

	public long saveOrder(Order order);

	public List<Order> findOrderByAccountId(Long accountId);

	public Order findOrderByOrderCode(String orderCode);

	public Long count(Map<String, Object> param);

	public List<Order> findOrderByMap(Map<String, Object> param);

	public Order findOrderByOrderId(Long orderid);

	public int changeOrderState(@Param("id")Long id, @Param("orderstate")String orderstate);

    public Map<String,Object> findAllStatictics(Long businessId);

    public Map<String,Object> findTadayStatictics(@Param("businessId")Long businessId, @Param("today")String date);

	public List<Order> findOrderTopByBsid(Long bsid);


	
}
