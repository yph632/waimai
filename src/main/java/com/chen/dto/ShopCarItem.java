package com.chen.dto;

import java.io.Serializable;

/**
 * 
 * @author ��
 * ���ﳵ �������ĸ���Ʒ��������Ϣ
 */
public class ShopCarItem implements Serializable{

	private static final long serialVersionUID = 1L;

	private Long foodId; //��Ʒ��id
    private int num; //����Ʒ������
    
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
