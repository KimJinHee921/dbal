package com.dbal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.dbal.common.ConnectionManager;

public class CommentDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	static CommentDAO instance;

	public static CommentDAO getInstance() {
		if (instance == null)
			instance = new CommentDAO();
		return instance;
	}
	
	public List<HashMap<String, Object>> selectComments (String card_id) {
		
		List<HashMap<String, Object>> commentList = new ArrayList<HashMap<String, Object>>();
		
		try {
			
			String sql = "SELECT " + 
					"  comment_id, " + 
					"  reply_comment, " + 
					"  create_date, " + 
					"  member_id " + 
					"FROM comments " + 
					"WHERE card_id = ?";
		
			conn = ConnectionManager.getConnnect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, card_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				HashMap<String, Object> comment = new HashMap<String, Object>();
				comment.put("comment_id", rs.getString("comment_id"));
				comment.put("reply_comment", rs.getString("reply_comment"));
				comment.put("create_date", rs.getString("create_date"));
				comment.put("member_id", rs.getString("member_id"));
				commentList.add(comment);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(rs, pstmt, conn);
		}
		
		return commentList;
		
	}
}
