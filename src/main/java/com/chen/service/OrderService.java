package com.chen.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.print.attribute.standard.PageRanges;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chen.dao.AccountMapper;
import com.chen.dao.AccountRoleMapper;
import com.chen.dao.FoodMapper;
import com.chen.dao.OrderItemMapper;
import com.chen.dao.OrderMapper;
import com.chen.dao.RoleMapper;
import com.chen.dto.ShopCar;
import com.chen.dto.ShopCarItem;
import com.chen.entity.Account;
import com.chen.entity.Business;
import com.chen.entity.Food;
import com.chen.entity.Order;
import com.chen.entity.OrderItem;
import com.chen.entity.Role;
import com.chen.util.Const;
import com.chen.util.OrderCodeUtil;
import com.chen.util.Pager;
import com.chen.util.ServletUtil;

@Service
@Transactional
public class OrderService {

	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private AccountRoleMapper accountRoleMapper;
	@Autowired
	private OrderItemMapper orderItemMapper;
	@Autowired
	private BusinessService businessService;
	@Autowired
	private FoodMapper foodMapper;
	
	
	private Logger logger = LoggerFactory.getLogger(OrderService.class);
	
	public Account saveOrder(Order order, Account account, ShopCar shopCar) {
		Business business = businessService.findBusinessById(shopCar.getBid());
		if(account != null){
			//即account用户已经登录,判断账号是否为普通用户
			//，如果不是普通用户，加上普通用户权限
			Role role = roleMapper.findByName(Const.ROLE_USER);
			if(accountRoleMapper.findByAccountAndRoleId(account.getId(), role.getId()) == null){
				accountRoleMapper.save(account.getId(), role.getId());
			}
		}else{
			account = accountMapper.findAccountByPhone(order.getOrdertel());
			if(account == null){
				//如果账号不存在，新建一个账号
				 account = new Account();

	                //产生随机密码，发短信告知
	                String password = RandomStringUtils.randomAlphanumeric(6);
	                //此处省略发短信
	                logger.debug("用户{}随机产生密码为{}",order.getOrdertel(),password);
	                System.out.println("手机号为"+order.getOrdertel()+"密码为：" + password);
	                account.setAcname(order.getOrdertel());
	                account.setAcnickname(order.getOrdertel());
	                account.setAccreatetime(ServletUtil.getNowtime());
	                account.setAcpassword(DigestUtils.md5Hex(password));
	                accountMapper.save(account);
	                //给账号添加普通用户权限
	                Role role = roleMapper.findByName(Const.ROLE_USER);
	                accountRoleMapper.save(account.getId(),role.getId());
			}else{
				//如果账号已经存在，查看是否有用户权限，如果没有添加用户权限
                Role role = roleMapper.findByName(Const.ROLE_USER);
                if(accountRoleMapper.findByAccountAndRoleId(account.getId(),role.getId()) == null) {
                    accountRoleMapper.save(account.getId(),role.getId());
                }
			}
		}
		
		order.setOrdercreatetime(ServletUtil.getNowtime());
		order.setOrderstate("审核中");
		order.setAcid(account.getId());
		order.setOrdercode(OrderCodeUtil.getGeratedOrderCode(account, business));
		orderMapper.saveOrder(order);
		Long orderid = order.getId();
		for(ShopCarItem shopCarItem :shopCar.getShopCarItems()){
			Food food = foodMapper.findFoodById(shopCarItem.getFoodId());
			OrderItem orderItem = new OrderItem();
			orderItem.setFoodid(shopCarItem.getFoodId());
			orderItem.setItemname(food.getFname());
			orderItem.setItemnum(shopCarItem.getNum());
			orderItem.setOrderid(orderid);
			orderItem.setItemprice(food.getFprice());
			orderItemMapper.saveOrderItem(orderItem);
		}
		return account;
	}

	public List<Order> findOrderByAccountId(Long accountId) {
		return orderMapper.findOrderByAccountId(accountId);
	}

	public List<OrderItem> findOrderItemByOrderId(Long orderid) {
		return orderItemMapper.findOrderItemByOrderId(orderid);
	}

	public Order findOrderByOrderCode(String orderCode) {
		return orderMapper.findOrderByOrderCode(orderCode);
	}

	public Pager<Order> findOrderByBusinessId(int pageNo,
			Map<String, Object> param) {
		Pager<Order> pager = new Pager<Order>(pageNo, orderMapper.count(param).intValue(), 15);
		param.put("pageStart", pager.getStart());
		param.put("pageSize", pager.getPageSize());
		List<Order> orders = orderMapper.findOrderByMap(param);
		pager.setItems(orders);
		return pager;
	}

	public Order findOrderByOrderId(Long orderid) {
		return orderMapper.findOrderByOrderId(orderid);
	}

	public void changeOrderState(Order order, String orderstate, Boolean isBusiness){
		if(isBusiness){
			//如果是商家可以进行一下操作
			if(orderstate.equals("ing")){
				orderMapper.changeOrderState(order.getId(), "已确认");
			}else if(orderstate.equals("post")){
				orderMapper.changeOrderState(order.getId(), "派送中");
			}else if(orderstate.equals("end")){
				orderMapper.changeOrderState(order.getId(), "完成订单");
			}
			if(orderstate.equals("cancel")){
				orderMapper.changeOrderState(order.getId(), "取消订单");
			}
		}else{
			if(order.getOrderstate().equals("等待确认") && orderstate.equals("cancel")){
				orderMapper.changeOrderState(order.getId(), "取消订单");
			}
		}
	}
	
	 /**
     * 根据商家ID获取统计信息
     * @return
     */
    public Map<String, Object> getBusinessStatistics(Long businessId) {
        Map<String,Object> allResult = orderMapper.findAllStatictics(businessId);
        Map<String,Object> todayResult = orderMapper.findTadayStatictics(businessId,ServletUtil.getNowDate());
        logger.debug("All count:{}  sum:{}",allResult.get("count(*)"),allResult.get("sum(orderprice)"));
        logger.debug("Today count:{}  sum:{}",todayResult.get("count(*)"),todayResult.get("sum(orderprice)"));

        Map<String,Object> result = new HashMap<String, Object>();
        result.put("allcount",allResult.get("count(*)"));
        result.put("allprice",allResult.get("sum(orderprice)"));
        result.put("todaycount",todayResult.get("count(*)"));
        result.put("todayprice",todayResult.get("sum(orderprice)"));
        return result;
    }

	
	
	
	
}
