package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.MemberVO;

public class MemberDAO {
	public int insert(MemberVO m) {
		int result = 0;
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		String query = "INSERT INTO check_member "
				+ "(id, pw, nickName) "
				+ "VALUES(?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, m.getId());
			pstmt.setString(2, m.getPw());
			pstmt.setString(3, m.getNickName());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int login(String id, String pw) {
		int result = 0;
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT COUNT(*) FROM check_member WHERE id = ? and pw = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int loginCheck(String id) {
		int result = 0;
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT COUNT(*) FROM check_member WHERE id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
