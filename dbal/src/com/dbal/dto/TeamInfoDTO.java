package com.dbal.dto;

public class TeamInfoDTO {
	private String team_id;
	private String member_id;
	private String join_date;
	
	public TeamInfoDTO(String team_id) {
		super();
		this.team_id = team_id;
	}
	
	public TeamInfoDTO() {}
	
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	@Override
	public String toString() {
		return "TeamInfoDTO [team_id=" + team_id + ", member_id=" + member_id + ", join_date=" + join_date + "]";
	}
	
	
	
}
