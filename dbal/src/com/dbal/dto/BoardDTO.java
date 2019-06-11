package com.dbal.dto;

public class BoardDTO {

	private String board_id;
	private String board_name;
	private String team_id;

	public BoardDTO(){
	}
	
	public BoardDTO(String board_id, String board_name){
		super();
		this.board_id = board_id;
		this.board_name = board_name;
	}
	
	@Override
	public String toString() {
		return "BoardDTO [board_id=" + board_id + ", board_name=" + board_name + ", team_id=" + team_id + "]";
	}

	public String getBoard_id() {
		return board_id;
	}

	public void setBoard_id(String board_id) {
		this.board_id = board_id;
	}

	public String getBoard_name() {
		return board_name;
	}

	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}

	public String getTeam_id() {
		return team_id;
	}

	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}

	public BoardDTO(String board_id, String board_name, String team_id) {
		super();
		this.board_id = board_id;
		this.board_name = board_name;
		this.team_id = team_id;
	}

}
