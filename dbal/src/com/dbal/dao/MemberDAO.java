package com.dbal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.dbal.common.ConnectionManager;
import com.dbal.dto.MemberDTO;



public class MemberDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	static MemberDAO instance;
	public static MemberDAO getInstance() {
		if(instance == null)
			instance = new MemberDAO();
		return instance;
	}

	//로그인
	public boolean loginCheck(String member_id, String passwd) {
		boolean result = false;
		try {
			conn = ConnectionManager.getConnnect();
			String sql = "select name from members where member_id = ? and passwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setString(2, passwd);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(conn);
		}
		return result;
	}


	//회원가입 (등록)
	public void MemberCreate(MemberDTO dto) {		
		try {
			conn = ConnectionManager.getConnnect();
			//트랙잭션 모드 변경(autocommit 해제)
			conn.setAutoCommit(false);
			String sql = " insert into dbal.members(member_id, "
				 	+    " email, name, passwd, join_date)"
					+    " values(?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMember_id());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getPasswd());
				
			pstmt.executeUpdate();
			conn.commit();  //정상실행이면 커밋
			
		} catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();  //에러나면 롤백
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 단건조회
	public MemberDTO selectOne(MemberDTO dto) {
		MemberDTO member = new MemberDTO();
		try {
			// 1. DB연결
			conn = ConnectionManager.getConnnect();
			// 2. sql구문 준비
			String sql = "select * from members where member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMember_id());
			// 3. 실행
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member.setMember_id(rs.getString("member_id"));;
				member.setEmail(rs.getString("email"));
				member.setName(rs.getString("name"));
				member.setPasswd(rs.getString("passwd"));
				member.setJoin_date(rs.getString("join_date"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(conn);
		}
		return member;
	}
}