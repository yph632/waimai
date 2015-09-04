package com.chen.dto;

import java.io.Serializable;

import com.chen.entity.Food;

public class FoodItem implements Serializable{

	private static final long serialVersionUID = 1L;

	private Food food;
	private int num;
	
	public FoodItem(){}
	
	public FoodItem(Food food, int num){
		this.food = food;
		this.num = num;
	}
	
	public Food getFood() {
		return food;
	}
	
	public void setFood(Food food) {
		this.food = food;
	}
	
	public int getNum() {
		return num;
	}
	
	public void setNum(int num) {
		this.num = num;
	}
	
}
