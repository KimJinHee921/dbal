package com.dbal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.dbal.common.ConnectionManager;
import com.dbal.dto.TeamDTO;
import com.dbal.dto.TeamInfoDTO;

public class TeamInfoDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	static TeamInfoDAO instance;
	public static TeamInfoDAO getInstance() {
		if(instance == null)
			instance = new TeamInfoDAO();
		return instance;
	}
	
	public ArrayList<TeamInfoDTO> select(String member_id) {
		TeamInfoDTO dto = null;
		ArrayList<TeamInfoDTO> list = new ArrayList<TeamInfoDTO>();
		
		try {
			conn = ConnectionManager.getConnnect();
			String sql = "select team_id from teaminfo where member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto = new TeamInfoDTO();
				dto.setTeam_id(rs.getString("team_id"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	public ArrayList<TeamInfoDTO> selectAll() {
		ArrayList<TeamInfoDTO> datas = new ArrayList<TeamInfoDTO>();
		TeamInfoDTO dto = null;
		try {
			conn = ConnectionManager.getConnnect();
			String sql = "select team_id, member_id from teaminfo";
			pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = new TeamInfoDTO();
				dto.setTeam_id(rs.getString("team_id"));
				dto.setMember_id(rs.getString("member_id"));
				dto.setJoin_date(rs.getString("join_date"));
				datas.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return datas;
	}
	
	public int insert(String team_id, String member_id) {
		int result = 0;
		
		try {
			conn = ConnectionManager.getConnnect();
			String sql = "insert into teaminfo(team_id, member_id) values(?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, team_id);
			pstmt.setString(2, member_id);
		
			result = pstmt.executeUpdate();

			
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	
	
}
