package com.dbal.dto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ListDTO {
	private String list_id;
	private String list_name;
	private int order_no;
	List<HashMap<String, Object>> cardList;
	
	public ListDTO() {
		cardList = new ArrayList<HashMap<String, Object>>();
	}

	public String getList_id() {
		return list_id;
	}

	public String getList_name() {
		return list_name;
	}

	public int getOrder_no() {
		return order_no;
	}

	public List<HashMap<String, Object>> getCardList() {
		return cardList;
	}

	public void setList_id(String list_id) {
		this.list_id = list_id;
	}

	public void setList_name(String list_name) {
		this.list_name = list_name;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}

	public void setCardList(List<HashMap<String, Object>> cardList) {
		this.cardList = cardList;
	}

}
