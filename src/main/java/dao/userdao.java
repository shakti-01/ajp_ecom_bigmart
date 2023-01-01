package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class userdao {
	static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
	static final String USER = "c##shakti";
	static final String PASS = "shakti";
	
	public boolean usersignup(String uname, String pass, String seller) throws ClassNotFoundException, SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "INSERT INTO ajp_ecom_user(uname,pass,is_seller) VALUES ('"+uname+"','"+pass+"', "+seller+" )";
			stmt.executeUpdate(sql);
			System.out.println("userdao-signup: Inserted user record into the table...");
			
			return true;
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public String[] userlogin(String uname, String pass) throws ClassNotFoundException, SQLException {
		String[] user = new String[3];
		user[0] =user[1]= user[2] = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
			Statement stmt = conn.createStatement();
			
			String sql = "select uname,is_seller,userid from ajp_ecom_user where uname='"+uname+"' and pass='"+pass+"'";
			ResultSet rs= stmt.executeQuery(sql);  
			
			while(rs.next()) {
				user[0] = rs.getString(1);
				user[1] = rs.getString(2);
				user[2] = rs.getString(3);
			}
			System.out.println("userdao-login: Retrieved user from table");
			
			return user;
		 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
			return user;
		}
	}
}
