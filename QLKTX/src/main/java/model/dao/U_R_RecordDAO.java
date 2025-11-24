package model.dao;

import model.bean.*;
import java.sql.*;
import java.util.*;
import java.lang.*;

public class U_R_RecordDAO {
	public ArrayList<U_R_Record> getAllRecord() {
		ArrayList<U_R_Record> recordList = new ArrayList<U_R_Record>();
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "SELECT * FROM user_room_records";
			ResultSet rs = sm.executeQuery(sql);
			while(rs.next())
			{
				recordList.add(new U_R_Record(rs.getString("room_id"), rs.getString("user_id"), rs.getInt("month"), rs.getInt("year"), rs.getBoolean("room"), rs.getBoolean("electric"), rs.getBoolean("water"), rs.getBoolean("wifi")));
			}
			conn.close();
		}catch(Exception e)
		{
			System.out.print("Error: " + e);
		}
		return recordList;
	}
	public boolean addRecord(U_R_Record record) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "INSERT INTO `user_room_records`(`room_id`, `user_id`, `month`, `year`, `room`, `electric`, `water`, `wifi`) VALUES ('"+record.getRoom_id()+"','"+record.getUser_id()+"',"+record.getMonth()+","+record.getYear()+","+record.isRoom()+","+record.isElectric()+","+record.isWater()+","+record.isWifi()+")";
			int rowAffected = sm.executeUpdate(sql);
			return rowAffected > 0;
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
	
	public boolean updateRecord(U_R_Record record) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "UPDATE `user_room_records` SET `room`="+record.isRoom()+",`electric`="+record.isElectric()+",`water`="+record.isWater()+",`wifi`="+record.isWifi()+" WHERE `room_id` = '"+record.getRoom_id()+"' AND `user_id` = '"+record.getUser_id()+"' AND `month` = "+record.getMonth()+" AND `year` = "+record.getYear()+"";
			int rowAffected = sm.executeUpdate(sql);
			return rowAffected > 0;
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
}
