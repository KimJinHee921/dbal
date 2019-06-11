package com.dbal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dbal.common.ConnectionManager;

public class CheckListDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	static CheckListDAO instance;

	public static CheckListDAO getInstance() {
		if (instance == null)
			instance = new CheckListDAO();
		return instance;
	}

	public List<HashMap<String, Object>> selectCheckLists(String card_id) {

		List<HashMap<String, Object>> checkList = new ArrayList<HashMap<String, Object>>();

		try {

			String sql = "select c.check_id, " + "       c.check_name, " + "       ci.item_id, "
					+ "       ci.item_name, " + "       ci.checked " + "from checklist c, checkitem ci "
					+ "where c.card_id = ? and ci.card_id = ?";

			conn = ConnectionManager.getConnnect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, card_id);
			pstmt.setString(2, card_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				HashMap<String, Object> checkItem = new HashMap<String, Object>();
				checkItem.put("check_id", rs.getString("check_id"));
				checkItem.put("check_name", rs.getString("check_name"));
				checkItem.put("item_id", rs.getString("item_id"));
				checkItem.put("item_name", rs.getString("item_name"));
				checkItem.put("checked", rs.getString("checked").equals("T") ? "checked" : "");
				checkList.add(checkItem);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(rs, pstmt, conn);
		}

		return checkList;
	}

	public HashMap<String, Object> insertCheckItem(HashMap<String, Object> checkList) {
		HashMap<String, Object> result = new HashMap<String, Object>();

		try {

			String sql = "INSERT INTO CHECKITEM (ITEM_ID, ITEM_NAME, CHECK_ID, CARD_ID) VALUES (?, ?, ?, ?)";
			
			conn = ConnectionManager.getConnnect();
			
			conn.setAutoCommit(false);
			
			int nextId = ConnectionManager.getSeqID(conn, "CHECKITEM");

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nextId);
			pstmt.setString(2, (String) checkList.get("item_name"));
			pstmt.setString(3, (String) checkList.get("check_id"));
			pstmt.setString(4, (String) checkList.get("card_id"));

			if (pstmt.executeUpdate() > 0) {
				result.put("result", true);
				result.put("item_id", nextId);
				result.put("item_name", checkList.get("item_name"));
			} else {
				result.put("result", false);
			}
			conn.commit();
		
		} catch ( Exception e) {
			try {
				conn.rollback(); 
			} catch (Exception e2) {
				e.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			ConnectionManager.close(rs, pstmt, conn);
		}
		return result;
	}
	
	
	public HashMap<String, Object> updateCheckItem(HashMap<String, Object> checkItem) {
		HashMap<String, Object> result = new HashMap<String, Object>();

		try {

			String sql = "update checkitem set checked = ? where item_id = ?";
			
			conn = ConnectionManager.getConnnect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, (String)checkItem.get("checked"));
			pstmt.setString(2, (String)checkItem.get("item_id"));

			if (pstmt.executeUpdate() > 0) {
				result.put("result", true);
				result.put("item_id", checkItem.get("item_id"));
			} else {
				result.put("result", false);
			}
		
		} catch ( Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(rs, pstmt, conn);
		}
		return result;
	}
	
	public HashMap<String, Object> deleteCheckItem(String item_id) {
		HashMap<String, Object> result = new HashMap<String, Object>();

		try {

			String sql = "delete from checkitem where item_id = ?";
			
			conn = ConnectionManager.getConnnect();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, item_id);

			if (pstmt.executeUpdate() > 0) {
				result.put("result", true);
				result.put("item_id", item_id);
			} else {
				result.put("result", false);
			}
		
		} catch ( Exception e) {
			try {
				conn.rollback(); 
			} catch (Exception e2) {
				e.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			ConnectionManager.close(rs, pstmt, conn);
		}
		return result;
	}
}
