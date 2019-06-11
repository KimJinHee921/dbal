package com.dbal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.HashMap;

import com.dbal.common.ConnectionManager;
import com.dbal.dto.MemberDTO;
import com.dbal.dto.TeamInfoDTO;

public class MemberInviteDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	static MemberInviteDAO instance;

	public static MemberInviteDAO getInstance() {
		if (instance == null)
			instance = new MemberInviteDAO();
		return instance;
	}

	//멤버 초대 
	public HashMap<String, Object> memberInvite(TeamInfoDTO dto) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("result", false);
				
		try {
			conn = ConnectionManager.getConnnect();
			String sql = "insert into dbal.teaminfo(team_id, "
					+  "member_id, join_date) " 
					+  "values(?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTeam_id());
			pstmt.setString(2, dto.getMember_id());

			int count = pstmt.executeUpdate();
			if (count > 0) {
			//성공
				result.put("result", true);
			
				MemberDTO dto1 = MemberDAO.getInstance().selectOne(new MemberDTO(dto.getMember_id()));
			
				result.put("member_id", dto1.getMember_id());
				result.put("name", dto1.getName());
				result.put("passwd", dto1.getPasswd());
				result.put("email", dto1.getEmail());
				result.put("join_date", dto1.getJoin_date());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(conn);
		}
		
		return result;
	}
}
