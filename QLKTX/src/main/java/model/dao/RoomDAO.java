package model.dao;

import java.sql.*;
import java.util.*;
import java.lang.*;
import model.bean.*;

public class RoomDAO {
	public ArrayList<Room> getAllRoom() {
		ArrayList<Room> roomList = new ArrayList<Room>();
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "SELECT * FROM rooms";
			ResultSet rs = sm.executeQuery(sql);
			while(rs.next())
			{
				roomList.add(new Room(rs.getString("room_id"), rs.getString("type"), rs.getInt("capacity"), rs.getString("price")));
			}
			conn.close();
		}catch(Exception e)
		{
			System.out.print("Error: " + e);
		}
		return roomList;
	}
	
	public boolean addRoom(Room room) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "INSERT INTO `rooms`(`room_id`, `type`, `capacity`, `price`) VALUES ('"+room.getRoom_id()+"','"+room.getType()+"','"+room.getCapacity()+"','"+room.getPrice()+"')";
			int rowAffected = sm.executeUpdate(sql);
			return rowAffected > 0;
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
	
	public boolean updateRoom(Room room) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "UPDATE `rooms` SET `price`='" + room.getPrice() + "' WHERE `room_id` = '" + room.getRoom_id() + "'";
			int rowAffected = sm.executeUpdate(sql);
			return rowAffected > 0;
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
	
	public boolean deleteRoom(String room_id) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "DELETE FROM `rooms` WHERE `room_id` = '" + room_id + "'";
			int rowAffected = sm.executeUpdate(sql);
			return rowAffected > 0;
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
}
