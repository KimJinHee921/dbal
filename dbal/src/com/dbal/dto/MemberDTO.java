package com.dbal.dto;

public class MemberDTO {
	private String member_id;
	private String name;
	private String passwd;
	private String email;
	private String join_date;
	
	public MemberDTO(String member_id) {
		super();
		this.member_id = member_id;
	}
	
	public MemberDTO() {}
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	@Override
	public String toString() {
		return "memberDTO [member_id=" + member_id + ", name=" + name + ", passwd=" + passwd + ", email=" + email
				+ ", join_date=" + join_date + "]";
	}
	
	
	
}
