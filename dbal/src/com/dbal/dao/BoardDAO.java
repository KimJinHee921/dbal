package com.dbal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.dbal.common.ConnectionManager;
import com.dbal.dto.BoardDTO;



public class BoardDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	static BoardDAO instance;
	public static BoardDAO getInstance() {
		if(instance == null)
			instance = new BoardDAO();
		return instance;
	} 
	
	//생성 
	public HashMap<String, Object> insert(BoardDTO dto) throws Exception {
	
		int nextId = 0;
		try {
			//1.DB연결
			conn = ConnectionManager.getConnnect();
			
			//트랜잭션 처리
			conn.setAutoCommit(false);
			//2.sql구문 준비
			
			pstmt = conn.prepareStatement("select VALUE from ID_REPOSITORY where NAME=?");
			pstmt.setString(1, "BOARD");
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				nextId = rs.getInt("VALUE");
			}
			nextId++;  //시퀀스 용도
			
			pstmt = conn.prepareStatement("update ID_REPOSITORY set VALUE = ? where NAME=?");
			pstmt.setInt(1, nextId);
			pstmt.setString(2, "BOARD");
			pstmt.executeUpdate();
			
			pstmt=conn.prepareStatement("insert into board(board_id,board_name, team_id) values(?,?,?)");
			pstmt.setInt(1, nextId);
			pstmt.setString(2, dto.getBoard_name());
			pstmt.setString(3, dto.getTeam_id());
			
		int result = pstmt.executeUpdate();
			
			conn.commit();   // 커밋
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("board_id", nextId);
			map.put("board_name", dto.getBoard_name());
			map.put(("team_id"), dto.getTeam_id());
			
			return map;
			
			} catch (Throwable e) {
				try {
					conn.rollback();  //롤백
				} catch (SQLException ex) {
				}
				throw new Exception(e.getMessage());
			}
		}
	
	//단건 조회
	public ArrayList<BoardDTO> select(String team_id) {
		BoardDTO dto = null;
		 ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
		conn = ConnectionManager.getConnnect();
		String sql = "select board_id, board_name, team_id from board where team_id =?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, team_id);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			dto = new BoardDTO();
			dto.setBoard_id(rs.getString("board_id"));
			dto.setBoard_name(rs.getString("board_name"));
			dto.setTeam_id(rs.getString("team_id"));
			list.add(dto);
			}
		}catch (Exception e) {
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
		return list;
	}
			
			
	//전체 조회 
	public ArrayList<BoardDTO>selectAll(){
		ArrayList<BoardDTO>datas = new ArrayList<BoardDTO>();
		BoardDTO dto=null;
		try {
			conn = ConnectionManager.getConnnect();
			String sql = "select board_id, board_name from board ";
			pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setBoard_id(rs.getString("board_id"));
				dto.setBoard_name(rs.getString("board_name"));
				dto.setTeam_id(rs.getString("team_id"));
				datas.add(dto);
			}
		} catch (Exception e) {
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
	//삭제
		public int delete(String board_id ) {
			int result = 0;
			
			try {
				conn = ConnectionManager.getConnnect();
				String sql = "delete BOARD where board_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, board_id);
				
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
		
			
	
	
	
	
	
	
}
