package com.dbal.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionManager {
	public static Connection getConnnect() {
		Connection conn = null;
		try {

			String jdbc_url = "jdbc:oracle:thin:@192.168.0.35:1521:xe";
			conn = DriverManager.getConnection(jdbc_url, "dbal", "dbal"); 
			/* conn = DriverManager.getConnection(jdbc_url, "jinhee", "1234"); */ 

		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static void close(Connection conn) {
		try {
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if (rs != null) {
			try {
				if (!rs.isClosed())
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (pstmt != null) {
			try {
				if (!pstmt.isClosed())
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (conn != null) {
			try {
				if (!conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 테이블의 다음  시퀀스 ID값을 가져온다
	 * @param conn 연결 정보 (Transaction 처리를 위해 필수)
	 * @param tableName 가져올 테이블 명
	 * @return 다음 시퀀스 ID 값
	 * @throws SQLException
	 */
	public static int getSeqID(Connection conn, String tableName) throws SQLException {
		
		PreparedStatement pstmt = null;
		int nextID = 0;
		pstmt = conn.prepareStatement("select VALUE from ID_REPOSITORY where NAME=?");
		pstmt.setString(1, tableName);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			nextID = rs.getInt("VALUE");
		}
		nextID++; // 시퀀스 용도
		
		pstmt = conn.prepareStatement("update ID_REPOSITORY set VALUE = ? where NAME=?");
		pstmt.setInt(1, nextID);
		pstmt.setString(2, tableName);
		pstmt.executeUpdate();
		
		return nextID;
	}
}
