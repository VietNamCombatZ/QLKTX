package model.dao;

import model.bean.User;
import java.util.*;
import java.lang.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.io.*;

public class UserDAO {
	public ArrayList<User> getAllUser() {
		ArrayList<User> userList = new ArrayList<User>();
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "SELECT * FROM user";
			ResultSet rs = sm.executeQuery(sql);
			while(rs.next())
			{
				if(rs.getString("id").equals("0000000000")) continue;
				userList.add(new User(rs.getString("id"), rs.getString("firstname"), rs.getString("lastname"), rs.getString("phonenumber"), rs.getString("cccd"), rs.getBoolean("gender")));
			}
			conn.close();
		}catch(Exception e)
		{
			System.out.println("Error: " + e.getMessage());
			e.printStackTrace();
		}
		return userList;
	}
	
	public ArrayList<User> getAllUserLG() {
		ArrayList<User> userList = new ArrayList<User>();
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "SELECT * FROM user";
			ResultSet rs = sm.executeQuery(sql);
			while(rs.next())
			{
				if(rs.getString("id").equals("0000000000")) continue;
				userList.add(new User(rs.getString("id"), rs.getString("username"), rs.getString("password"), rs.getString("firstname"), rs.getString("lastname"), rs.getString("phonenumber"), rs.getString("cccd"), rs.getBoolean("gender")));
			}
			conn.close();
		}catch(Exception e)
		{
			System.out.print("Error: " + e);
		}
		return userList;
	}
	
	
	public boolean updateUser(User user) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "UPDATE `user` SET `firstname`='" + user.getFirstname() + "',`lastname`='" + user.getLastname() + "',`phonenumber`='" + user.getPhonenumber() + "',`cccd`='" + user.getCccd() + "',`gender`=" + user.isMale() + " WHERE `id` = '" + user.getUser_id() + "'";
			int rowAffected = sm.executeUpdate(sql);
			return rowAffected > 0;
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
	
	public boolean deleteUser(String user_id) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "DELETE FROM `user` WHERE `id` = '" + user_id + "'";
			int rowAffected = sm.executeUpdate(sql);
			return rowAffected > 0;
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
	
	public boolean addUser(User user) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "INSERT INTO `user`(`id`, `username`, `password`, `firstname`, `lastname`, `phonenumber`, `cccd`, `gender`) VALUES ('"+user.getUser_id()+"','"+user.getUsername()+"','"+user.getPassword()+"','"+user.getFirstname()+"','"+user.getLastname()+"','"+user.getPhonenumber()+"','"+user.getCccd()+"',"+user.isMale()+")";
			int rowAffected = sm.executeUpdate(sql);
			return rowAffected > 0;
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
}
