package com.dbal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.dbal.common.ConnectionManager;
import com.dbal.dto.CardDTO;

public class CardDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	static CardDAO instance;

	public static CardDAO getInstance() {
		if (instance == null)
			instance = new CardDAO();
		return instance;
	}

	public HashMap<String, Object> selectCardInfo(String card_id) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		try {
			conn = ConnectionManager.getConnnect();
			
			// 1. 카드 정보 조회

			String sql = "select c.card_id, " + 
					"       c.card_name, " + 
					"       c.description, " + 
					"       to_char(due_date,'yyyy-mm-dd') as due_date, " +
					"       c.done, " + 
					"       ch.check_id " + 
					"from card c left outer join checklist ch on (c.card_id = ch.card_id) " + 
					"where c.card_id = ?";

			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, card_id);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				result.put("card_id", rs.getString("card_id"));
				result.put("card_name", rs.getString("card_name"));
				result.put("description", rs.getString("description"));
				result.put("due_date", rs.getString("due_date"));
				result.put("done", rs.getString("done"));
				result.put("check_id", rs.getString("check_id"));
			}
			
			// 2. 카드 체크 리스트 조회
			List<HashMap<String, Object>> checkList = CheckListDAO.getInstance().selectCheckLists(card_id);
			result.put("check_list", checkList);
			
			// 3. 코멘트 리스트 조회
			List<HashMap<String, Object>> commentList = CommentDAO.getInstance().selectComments(card_id);
			result.put("comment_list", commentList);
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(rs, pstmt, conn);
		}
		return result;
	}
	
	/**
	 * 카드 추가
	 * @param card
	 * @return
	 */
	public HashMap<String, Object> insertCard(CardDTO card) {
		HashMap<String, Object> result = new HashMap<String, Object>();

		try {
			conn = ConnectionManager.getConnnect();

			conn.setAutoCommit(false);

			// 시퀀스 ID 가져오기
			int cardNextID = ConnectionManager.getSeqID(conn, "CARD");

			// 카드 추가
			pstmt = conn.prepareStatement(
					"INSERT INTO CARD (CARD_ID, CARD_NAME, LIST_ID) VALUES (?, ?, ?)");
			pstmt.setInt(1, cardNextID);
			pstmt.setString(2, card.getCard_name());
			pstmt.setString(3, card.getList_id());
			
			pstmt.executeUpdate();
			
			// 카드 추가하면서 CheckList도 하나 추가
			int checkListNextID = ConnectionManager.getSeqID(conn, "CHECKLIST");

			pstmt = conn.prepareStatement("INSERT INTO CHECKLIST (CHECK_ID, CHECK_NAME, CARD_ID) VALUES (?, ?, ?)");
			pstmt.setInt(1, checkListNextID);
			// 체크 리스트 이름 의미가 없어서 TEMP값 입력
			pstmt.setString(2, "TEMP");
			pstmt.setInt(3, cardNextID);

			pstmt.executeUpdate();

			conn.commit(); // 커밋

			result.put("list_id", card.getList_id());
			result.put("card_id", cardNextID);
			result.put("card_name", card.getCard_name());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(conn);
		}

		return result;
	}
	
	/**
	 * 카드 삭제
	 * @param card
	 * @return
	 */
	public HashMap<String, Object> deteCard(String card_id) {
		HashMap<String, Object> result = new HashMap<String, Object>();

		try {
			conn = ConnectionManager.getConnnect();

			pstmt = conn.prepareStatement(
					"DELETE FROM CARD WHERE card_id = ?");
			pstmt.setString(1, card_id);
			
			int count = pstmt.executeUpdate();

			if(count > 0 ) {
				result.put("result", true);
				result.put("card_id", card_id);
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
	
	
	public HashMap<String, Object> updateCardName(String card_id, String card_name) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			
			
			conn = ConnectionManager.getConnnect();
			
			String sql = "update card " + 
						 " set card_name = ?" + 
						 " where card_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, card_name);
			pstmt.setString(2, card_id);
			int n=0;
			n = pstmt.executeUpdate();	
			if(n > 0) {
				map.put("card_id", card_id);
				map.put("card_name", card_name);
			} else
				System.out.println("수정오류");
		
			
		}catch (Exception e) {
			// TODO: handle exception
			  
			e.printStackTrace();
		}finally {
			ConnectionManager.close(rs,pstmt,conn);
		}
		return map;
		
	}
	
	public HashMap<String, Object> updateCardDate(String card_id, String due_date) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			
			
			conn = ConnectionManager.getConnnect();
			
			String sql = "update card " + 
						 " set due_date = ? "
						 + " where card_id=? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, due_date);
			pstmt.setString(2, card_id);
			
			int n=0;
			n = pstmt.executeUpdate();	
			if(n > 0) {
				map.put("card_id", card_id);
//				SimpleDateFormat format = new SimpleDateFormat("MM dd");
//				System.out.println(format.par (due_date + " 10:10:10"));
				
				String form = due_date;
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date to = transFormat.parse(form);
				SimpleDateFormat format = new SimpleDateFormat("MMM dd");
				
				String sub_date = format.format(to);
				map.put("due_date", sub_date);
			} else
				System.out.println("날짜 변경 수정 오류");
		
			
		}catch (Exception e) {
			// TODO: handle exception
			  
			e.printStackTrace();
		}finally {
			ConnectionManager.close(rs,pstmt,conn);
		}
		return map;
		
	}
	
	public HashMap<String, Object> updateDone(String card_id, String done) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			
			
			conn = ConnectionManager.getConnnect();
			
			String sql = "update card " + 
						 " set done = ? "
						 + " where card_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, done);
			
			pstmt.setString(2, card_id);
			int n=0;
			n = pstmt.executeUpdate();	
			if(n > 0) {
				map.put("card_id", card_id);
				
				map.put("done", done);
			} else
				System.out.println("날짜 체크 수정오류");
		
			
		}catch (Exception e) {
			// TODO: handle exception
			  
			e.printStackTrace();
		}finally {
			ConnectionManager.close(rs,pstmt,conn);
		}
		return map;
		
	}
	
	public HashMap<String, Object> updateDescription(String card_id, String description) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			
			
			conn = ConnectionManager.getConnnect();
			
			String sql = "update card " + 
						 " set description = ? "
						 + " where card_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, description);
			
			pstmt.setString(2, card_id);
			int n=0;
			n = pstmt.executeUpdate();	
			if(n > 0) {
				map.put("card_id", card_id);
				
				map.put("description", description);
			} else
				System.out.println("디스크립션 수정오류");
		
			
		}catch (Exception e) {
			// TODO: handle exception
			  
			e.printStackTrace();
		}finally {
			ConnectionManager.close(rs,pstmt,conn);
		}
		return map;
	}
	
	public HashMap<String, Object> moveCard(String card_id, String list_id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			
			conn = ConnectionManager.getConnnect();
			String sql = "UPDATE CARD SET LIST_ID = ? WHERE CARD_ID = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, list_id);
			pstmt.setString(2, card_id);
			
			int n=0;
			n = pstmt.executeUpdate();	
			if(n > 0) {
				map.put("result", true);
				map.put("list_id", list_id);
				map.put("card_id", card_id);
			} else {
				map.put("result", false);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionManager.close(rs,pstmt,conn);
		}
		return map;
	}

}
