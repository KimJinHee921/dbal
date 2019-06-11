package com.dbal.dto;

public class TeamDTO {
	private String team_id;
	private String team_name;
	
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	
	public TeamDTO(String team_id) {
		super();
		this.team_id = team_id;
	}
	
	public TeamDTO() {}
	
	@Override
	public String toString() {
		return "TeamDTO [team_id=" + team_id + ", team_name=" + team_name + "]";
	}
	
	
	
	
	
}
