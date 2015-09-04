package com.chen.util;
/**
 * 系统常量
 * @author runhang
 *
 */
public interface Const {

	//权限名称常量
    public static final String ROLE_BUSINESS = "商家";
    public static String ROLE_USER = "普通用户";
    public static String ROLE_ADMIN = "系统管理员";
    
    //各种对象在Session中的名称常量
    public String ACCOUNT_IN_SESSION = "curr_account";
    String BUSINESS_IN_SESSION = "curr_business";

    //餐品是否上架
    Boolean FOOD_SALE = true;
    Boolean FOOD_NOT_SALE = false;
    
    //商家分类
    public static String[] BUSINESS_TYPES = {"中式","港式","台式","西式","甜点","奶茶","汉堡","烧烤","日式","韩式","水果"};

    //订单状态
    String ORDER_STATE_NEW = "等待确认";
    String ORDER_STATE_DOING = "商家已确认";
    String ORDER_STATE_POST = "派送中";
    String ORDER_STATE_FINISH = "已完成";
    String ORDER_STATE_CANCEL = "已取消";
    
    
    

}
