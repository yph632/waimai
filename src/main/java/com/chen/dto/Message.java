package com.chen.dto;

import java.io.Serializable;

public class Message implements Serializable {

    private static final long serialVersionUID = -4595605622548243554L;

    private String state;
    private String message;
    private Object data;
    
    public Message(){}
    public Message(String state,String message){
        this.state = state;
        this.message = message;
    }

    public Message(String state){
        this.state = state;
    }

    public Message(String state,Object data) {
        this.state = state;
        this.data = data;
    }

   

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
