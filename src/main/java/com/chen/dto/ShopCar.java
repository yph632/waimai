package com.chen.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 * @author ����
 * ���ﳵ����
 */
public class ShopCar implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private Long bid; //���ﳵ�б��������̵�id
	private List<ShopCarItem> shopCarItems ; //���ﳵ���б���Ʒ�������͵�����
	
	public void savaShopCarItem(ShopCarItem carItem){
		if(shopCarItems == null){
			shopCarItems = new ArrayList<ShopCarItem>();
			shopCarItems.add(carItem);
			return;
		}
		ShopCarItem temp = null;
		for(ShopCarItem item : shopCarItems){
			if(item.getFoodId().equals(carItem.getFoodId())){
				temp = item;
				break;
			}
		}
		if(temp == null){
			shopCarItems.add(carItem);
		}else{
			temp.setNum(temp.getNum() + 1);
		}
	}
	public void removeItem(Long id) {
        int index = -1;
        for(int i = 0;i < shopCarItems.size();i++) {
            ShopCarItem item =  shopCarItems.get(i);
            if(item.getFoodId().equals(id)) {
                index = i;
                break;
            }
        }
        if(index != -1) {
        	shopCarItems.remove(index);
        }
    }
	
	public Long getBid() {
		return bid;
	}
	
	public void setBid(Long bid) {
		this.bid = bid;
	}
	
	public List<ShopCarItem> getShopCarItems() {
		return shopCarItems;
	}
	
	public void setCarItems(List<ShopCarItem> shopCarItems) {
		this.shopCarItems = shopCarItems;
	}
	
	
	
	
	
}
