package com.dbal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.dbal.common.ConnectionManager;
import com.dbal.dto.*;

public class BoardListDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	static BoardListDAO instance;

	public static BoardListDAO getInstance() {
		if (instance == null)
			instance = new BoardListDAO();
		return instance;
	}

	/**
	 * 보드의 리스트 정보 를 가져온다
	 * 
	 * @param board 보드 정보
	 * @return
	 */
	private List<ListDTO> selectLists(BoardDTO board) {

		List<ListDTO> boardList = new ArrayList<ListDTO>();

		try {
			conn = ConnectionManager.getConnnect();
			String sql = "SELECT list_id, list_name FROM boardlist WHERE board_id = ? order by order_no";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getBoard_id());
			
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ListDTO dto = new ListDTO();
				dto.setList_id(rs.getString("list_id"));
				dto.setList_name(rs.getString("list_name"));
				boardList.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(rs, pstmt, conn);
		}
		return boardList;
	}

	public HashMap<String, Object> insertList(HashMap<String, String> boardList) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		int nextID = 0;

		try {
			conn = ConnectionManager.getConnnect();

			conn.setAutoCommit(false);

			// 리스트의 다음 순서 번호를 가져온다
			pstmt = conn.prepareStatement("select max(order_no) + 1 as next_no  from boardlist where board_id = ?");
			pstmt.setString(1, boardList.get("board_id"));
			rs = pstmt.executeQuery();

			int nextOrderNo = 0;
			if (rs.next()) {
				nextOrderNo = rs.getInt("next_no");
			}

			// 시퀀스 ID 가져오기
			nextID = ConnectionManager.getSeqID(conn, "BOARDLIST");

			// 보드 리스트에 추가
			pstmt = conn.prepareStatement(
					"INSERT INTO BOARDLIST (LIST_ID, LIST_NAME, ORDER_NO, BOARD_ID) VALUES (?, ?, ?, ?)");
			pstmt.setInt(1, nextID);
			pstmt.setString(2, boardList.get("list_name"));
			pstmt.setInt(3, nextOrderNo);
			pstmt.setString(4, boardList.get("board_id"));

			pstmt.executeUpdate();
				
			conn.commit(); // 커밋
			
			result.put("list_id", nextID);
			result.put("list_name", boardList.get("list_name"));

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(conn);
		}

		return result;
	}

	/**
	 * 카드 정보를 가져온다
	 * 
	 * @param list_id 리스트 ID
	 * @return 하나의 리스트에 속해 있는 카드 목록
	 */
	private List<HashMap<String, Object>> selectCards(String list_id) {

		List<HashMap<String, Object>> cardList = new ArrayList<HashMap<String, Object>>();

		try {
			conn = ConnectionManager.getConnnect();
			String sql = " SELECT a.card_id, " + 
					"       a.card_name, " + 
					"       a.description, " + 
					"        a.done, " + 
					"       to_char(a.due_date,'month dd') as due_date, " + 
					"       count(b.checked) as total, " + 
					"       sum(case b.checked when 'T' then 1 else 0 end) as checkedsum " + 
					" FROM card a left outer join checkitem b " + 
					" on(a.card_id = b.card_id) " + 
					" where a.list_id= ? " + 
					" group by a.card_id, a.card_name, a.description, a.done, to_char(a.due_date,'month dd') " + 
					" ORDER BY card_id";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, list_id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("card_id", rs.getString("card_id"));
				map.put("card_name", rs.getString("card_name"));
				map.put("description", rs.getString("description"));
				map.put("done", rs.getString("done"));
				map.put("due_date", rs.getString("due_date"));
				map.put("total", rs.getString("total"));
				map.put("checkedsum", rs.getString("checkedsum"));
				cardList.add(map);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(conn);
		}
		return cardList;
	}

	public BoardListDTO selectBoardListInfo(BoardDTO board) {
		BoardListDTO boardListInfo = new BoardListDTO(board);

		// 해당 보드의 리스트 목록 조회
		List<ListDTO> boardList = selectLists(board);
		for (ListDTO list : boardList) {
			// 보드 리스트의 카드 목록 조회
			list.setCardList(selectCards(list.getList_id()));
		}

		boardListInfo.setBoardList(boardList);

		return boardListInfo;
	}
	
	
}
