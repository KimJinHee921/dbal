package com.dbal.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.dbal.common.ConnectionManager;
import com.dbal.dto.TeamDTO;


public class TeamDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	static TeamDAO instance;
	public static TeamDAO getInstance() {
		if(instance == null)
			instance = new TeamDAO();
		return instance;
	}
	
	//추가
	public int insert(TeamDTO dto) {
		int nextId = 0;
		
		try {
			conn = ConnectionManager.getConnnect();
			conn.setAutoCommit(false);   //트랜잭션 처리
			
			nextId = ConnectionManager.getSeqID(conn, "TEAM");
			dto.setTeam_id(Integer.toString(nextId));
			
			pstmt=conn.prepareStatement("insert into team(team_id, team_name) values(?,?)");
			pstmt.setInt(1, nextId);
			pstmt.setString(2, dto.getTeam_name());
			
			int result = pstmt.executeUpdate();
			
			conn.commit();   // 커밋
			
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
		return nextId;
	}
	
	//삭제
	public int delete(String team_id ) {
		int result = 0;
		
		try {
			conn = ConnectionManager.getConnnect();
			String sql = "delete team where team_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, team_id);
			
			 result = pstmt.executeUpdate();
			if(result !=1)
				throw new Exception();
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
	
	
	public TeamDTO select(String team_id) {
		TeamDTO dto = null;
		
		
		try {
			conn = ConnectionManager.getConnnect();
			String sql = "select team_id, team_name from team where team_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, team_id);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new TeamDTO();
				dto.setTeam_id(rs.getString("team_id"));
				dto.setTeam_name(rs.getString("team_name"));
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
		
		
		return dto;
	}
	
	public List<HashMap<String, Object>> selectteaminfo(String member_id) throws Exception {
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		try {
			conn = ConnectionManager.getConnnect();
			String sql ="select t.team_id, t.team_name, m.member_id, b.board_id, b.board_name" + 
						" from team t join teaminfo m" + 
						" on(t.team_id = m.team_id)" + 
						"             join board b" +
						" on(t.team_id = b.team_id)" +
						" where m.member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("team_id", rs.getString("team_id"));
				map.put("member_id", rs.getString("member_id"));
				map.put("team_name", rs.getString("team_name"));
				map.put("board_id", rs.getString("board_id"));
				map.put("board_name", rs.getString("board_name"));
				list.add(map);
			}
		} catch (Throwable e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		} finally {
			conn.close();
		}
		return list;
	} 
	
	public List<HashMap<String, Object>> selectnavinfo(String member_id) {
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		try {
			conn = ConnectionManager.getConnnect();
			String sql ="select t.team_id, t.team_name, m.member_id" + 
						" from team t join teaminfo m" + 
						" on(t.team_id = m.team_id)" + 
						" where m.member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("team_id", rs.getString("team_id"));
				map.put("member_id", rs.getString("member_id"));
				map.put("team_name", rs.getString("team_name"));
				
				list.add(map);
			}
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(conn);
		}
		return list;
	} 
	
	public ArrayList<TeamDTO> selectAll() {
		ArrayList<TeamDTO> datas = new ArrayList<TeamDTO>();
		TeamDTO dto = null;
		
		try {
			conn = ConnectionManager.getConnnect();
			String sql = "select team_id, team_name from team";
			pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				dto = new TeamDTO();
				dto.setTeam_id(rs.getString("team_id"));
				dto.setTeam_name(rs.getString("team_name"));
				datas.add(dto);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return datas;
	}
}
