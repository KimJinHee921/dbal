package com.dbal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.dbal.common.ConnectionManager;
import com.dbal.dto.MemberDTO;

public class MemberListDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	static MemberListDAO instance;

	public static MemberListDAO getInstance() {
		if (instance == null)
			instance = new MemberListDAO();
		return instance;
	}

	public List<HashMap<String, Object>> selectTeamMember(String team_id) throws Exception {
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		MemberDTO dto = null;

		try {
			conn = ConnectionManager.getConnnect();
			String sql = "select m.member_id, m.name, m.email, t.team_id, t.join_date" + 
					" from members m join teaminfo t" + 
					" on(m.member_id = t.member_id)" + 
					" where team_id = ?" +
					" order by t.join_date";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, team_id);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("member_id", rs.getString("member_id"));
				map.put("name", rs.getString("name"));
				map.put("email", rs.getString("email"));
				map.put("team_id", rs.getString("team_id"));
				map.put("join_date", rs.getString("join_date"));
				list.add(map);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public ArrayList<MemberDTO> selectAll(int team_id) {
		ArrayList<MemberDTO> memberList = new ArrayList<MemberDTO>();
		MemberDTO dto = null;

		try {
			conn = ConnectionManager.getConnnect();
			String sql = "SELECT MEMBER_ID, NAME, EMAIL FROM MEMBERS WHERE TEAM_ID = ? ORDER BY JOIN_DATE";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, team_id);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = new MemberDTO();
				dto.setMember_id(rs.getString("member_id"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				memberList.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return memberList;
	}

	public HashMap<String, Object> deleteMember(String member_id, String team_id) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		try {
			conn = ConnectionManager.getConnnect();
			String sql = "DELETE FROM TEAMINFO WHERE member_id = ? and team_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setString(2, team_id);

			if(pstmt.executeUpdate() > 0) {
				result.put("result", true);
				result.put("member_id", member_id);
			} else {
				result.put("result", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(conn);
		}
		return result;
	}

}
