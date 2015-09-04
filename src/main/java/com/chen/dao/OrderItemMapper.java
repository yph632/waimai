package com.chen.dao;

import java.util.List;

import com.chen.entity.Order;
import com.chen.entity.OrderItem;

public interface OrderItemMapper {

	public Long saveOrderItem(OrderItem orderItem);

	public List<OrderItem> findOrderItemByOrderId(Long orderid);

	public List<Order> findOrderItemTopByBsid(Long id);
	
}
