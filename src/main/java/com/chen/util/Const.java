package com.chen.util;
/**
 * ϵͳ����
 * @author runhang
 *
 */
public interface Const {

	//Ȩ�����Ƴ���
    public static final String ROLE_BUSINESS = "�̼�";
    public static String ROLE_USER = "��ͨ�û�";
    public static String ROLE_ADMIN = "ϵͳ����Ա";
    
    //���ֶ�����Session�е����Ƴ���
    public String ACCOUNT_IN_SESSION = "curr_account";
    String BUSINESS_IN_SESSION = "curr_business";

    //��Ʒ�Ƿ��ϼ�
    Boolean FOOD_SALE = true;
    Boolean FOOD_NOT_SALE = false;
    
    //�̼ҷ���
    public static String[] BUSINESS_TYPES = {"��ʽ","��ʽ","̨ʽ","��ʽ","���","�̲�","����","�տ�","��ʽ","��ʽ","ˮ��"};

    //����״̬
    String ORDER_STATE_NEW = "�ȴ�ȷ��";
    String ORDER_STATE_DOING = "�̼���ȷ��";
    String ORDER_STATE_POST = "������";
    String ORDER_STATE_FINISH = "�����";
    String ORDER_STATE_CANCEL = "��ȡ��";
    
    
    

}
