package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import common.ListVO;

public class ListDAO {
	public int insert(ListVO l) {
		int result = 0;
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		String query = "INSERT INTO todoList "
				+ "(todolist, reg_date, id, state, todo_time) "
				+ "VALUES(?, now(), ?, 0, ?)";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, l.getList());
			pstmt.setString(2, l.getId());
			pstmt.setString(3, l.getTodo_time());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return result;
	}
	
	public ArrayList<ListVO> todaySelectAll(String id){
		ArrayList<ListVO> list = new ArrayList<>();
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT * FROM todoList WHERE id=?"
				+ " and date(reg_date) = CURDATE();";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ListVO l = new ListVO();
				l.setListNo(rs.getInt("listNo"));
				l.setList(rs.getString("todolist"));
				l.setReg_date(rs.getDate("reg_date"));
				l.setId(rs.getString("id"));
				l.setState(rs.getInt("state"));
				l.setTodo_time(rs.getString("todo_time"));
				list.add(l);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public int update(ListVO l) {
		int result = 0;
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		String query = "UPDATE todoList SET"
				+" todolist=?, reg_date=now(), todo_time=?"
				+" WHERE listNo=? and id=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, l.getList());
			pstmt.setString(2, l.getTodo_time());
			pstmt.setInt(3, l.getListNo());
			pstmt.setString(4, l.getId());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public int delete(int listNo) {
		int result = 0;
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		String query = "DELETE FROM todoList"
				+ " WHERE listNo=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, listNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int complte(int listNo) {
		int result = 0;
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		String query = "UPDATE todoList"
				+" SET state=1"
				+" WHERE listNo=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, listNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int cancle(int listNo) {
		int result = 0;
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		String query = "UPDATE todoList"
				+" SET state=0"
				+" WHERE listNo=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, listNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return result;
	}
	
	public ArrayList<ListVO> selectAll(String id){
		ArrayList<ListVO> list = new ArrayList<ListVO>();
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT DISTINCT DATE_FORMAT(reg_date, '%Y-%m-%d') as regDate from todolist where id= ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ListVO l = new ListVO();
				l.setReg_date(rs.getDate("regDate"));
				
				list.add(l);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	public ArrayList<ListVO> selectOne(String id, String list_date){
		ArrayList<ListVO> list = new ArrayList<>();
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT todolist, state, todo_time FROM todolist WHERE id=? and DATE(reg_date)=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, list_date);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ListVO l = new ListVO();
				l.setList(rs.getString("todolist"));
				l.setState(rs.getInt("state"));
				l.setTodo_time(rs.getString("todo_time"));
				list.add(l);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	public ArrayList<ListVO> paintCom(String id, String yearMonth){
		ArrayList<ListVO> list = new ArrayList<>();
		Connection conn = DBCon.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT DATE_FORMAT(reg_date, '%Y-%m-%e') as new_date FROM todolist "
				+ "where id=? group by DATE_FORMAT(reg_date, '%Y-%m-%e')";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
		
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ListVO l = new ListVO();
				l.setReg_date(rs.getDate("new_date"));
				list.add(l);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
//	public ArrayList<ListVO> selectAll(String id){
//		ArrayList<ListVO> list = new ArrayList<ListVO>();
//		Connection conn = DBCon.getConnection();
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String query = "SELECT DISTINCT DATE_FORMAT(reg_date, '%Y-%m-%d') as regDate from todolist where id= ?";
//		try {
//			pstmt = conn.prepareStatement(query);
//			pstmt.setString(1, id);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				ListVO l = new ListVO();
//				l.setReg_date(rs.getDate("regDate"));
//				
//				list.add(l);
//			}
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		return list;
//	}
	
}
