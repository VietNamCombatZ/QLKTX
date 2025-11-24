package model.dao;

import java.lang.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class CheckLoginDAO {
	public boolean CheckUserExist(String username, String password) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "SELECT * FROM user WHERE username = '" + username + "' AND password = '" + password + "'";
			ResultSet rs = sm.executeQuery(sql);
			if (rs.next()) {
				if (rs.getString("username") != null)
					return true;
			}
		} catch(Exception e) {
			System.out.println("Error: " + e);
		}
		return false;
	}
}
