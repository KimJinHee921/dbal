package com.dbal.dto;

public class CheckItemDTO {
	private String item_id;
	private String item_name;
	private String checked;
	private String check_id;
	private String card_id;
	
	
	
	public String getItem_id() {
		return item_id;
	}
	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getChecked() {
		return checked;
	}
	public void setChecked(String checked) {
		this.checked = checked;
	}
	public String getCheck_id() {
		return check_id;
	}
	public void setCheck_id(String check_id) {
		this.check_id = check_id;
	}
	public String getCard_id() {
		return card_id;
	}
	public void setCard_id(String card_id) {
		this.card_id = card_id;
	}
	
	@Override
	public String toString() {
		return "CheckItem [item_id=" + item_id + ", item_name=" + item_name + ", checked=" + checked + ", check_id="
				+ check_id + ", card_id=" + card_id + "]";
	}
	
	
	
}
