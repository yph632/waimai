package com.chen.dto;

import java.io.Serializable;

/**
 * 
 * @author 润航
 * 购物车 所包含的该商品的数据信息
 */
public class ShopCarItem implements Serializable{

	private static final long serialVersionUID = 1L;

	private Long foodId; //商品的id
    private int num; //该商品的数量
    
    public ShopCarItem(){}
    
    public ShopCarItem(Long foodId, int num){
    	this.foodId = foodId;
    	this.num = num;
    }
    
	public Long getFoodId() {
		return foodId;
	}
	
	public void setFoodId(Long foodId) {
		this.foodId = foodId;
	}
	
	public int getNum() {
		return num;
	}
	
	public void setNum(int num) {
		this.num = num;
	}
    
    
	
}
