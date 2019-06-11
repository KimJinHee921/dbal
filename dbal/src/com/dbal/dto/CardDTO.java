package com.dbal.dto;

public class CardDTO {
	private String card_id;
	private String card_name;
	private String description;
	private String due_date;
	private String done;
	private String list_id;

	public CardDTO() {}
	
	public CardDTO(String card_name, String list_id) {
		super();
		this.card_name = card_name;
		this.list_id = list_id;
	}
	
	public String getCard_id() {
		return card_id;
	}

	public String getCard_name() {
		return card_name;
	}

	public String getDescription() {
		return description;
	}

	public String getDue_date() {
		return due_date;
	}

	public String getDone() {
		return done;
	}

	public String getList_id() {
		return list_id;
	}

	public void setCard_id(String card_id) {
		this.card_id = card_id;
	}

	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setDue_date(String due_date) {
		this.due_date = due_date;
	}

	public void setDone(String done) {
		this.done = done;
	}

	public void setList_id(String list_id) {
		this.list_id = list_id;
	}

	@Override
	public String toString() {
		return "CardDTO [card_id=" + card_id + ", card_name=" + card_name + ", description=" + description
				+ ", due_date=" + due_date + ", done=" + done + ", list_id=" + list_id + "]";
	}
	
	
}
