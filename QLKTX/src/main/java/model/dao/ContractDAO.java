package model.dao;

import model.bean.*;
import java.util.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.lang.*;

public class ContractDAO {
	public ArrayList<Contract> getAllContract() {
		ArrayList<Contract> contractList = new ArrayList<Contract>();
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "SELECT * FROM contracts";
			ResultSet rs = sm.executeQuery(sql);
			while(rs.next())
			{
				contractList.add(new Contract(rs.getString("contract_id"), rs.getString("user_id"), rs.getString("room_id"), rs.getInt("duration"), rs.getDate("start"), rs.getDate("end"), rs.getString("state")));
			}
			conn.close();
		}catch(Exception e)
		{
			System.out.print("Error: " + e);
		}
		return contractList;
	}
	
	public boolean addContract(Contract contract) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
            String startFormatted = outputFormat.format(contract.getStart());
            String endFormatted = outputFormat.format(contract.getEnd());
            java.sql.Date sqlStartDate = java.sql.Date.valueOf(startFormatted);
            java.sql.Date sqlEndDate = java.sql.Date.valueOf(endFormatted);
			String sql = "INSERT INTO `contracts`(`contract_id`, `user_id`, `room_id`, `duration`, `start`, `end`, `state`) VALUES ('"+contract.getContract_id()+"','"+contract.getUser_id()+"','"+contract.getRoom_id()+"',"+contract.getDuration()+",'"+sqlStartDate+"','"+sqlEndDate+"','"+contract.getState()+"')";
			int rowAffected = sm.executeUpdate(sql);
			return rowAffected > 0;
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
	
	public boolean updateContract(Contract contract) {
		try {
			Connection conn = DBConnection.getConnection();
			Statement sm = conn.createStatement();
			String sql = "UPDATE `contracts` SET `state`='"+contract.getState()+"' WHERE `contract_id`='"+contract.getContract_id()+"'";
			int rowAffected = sm.executeUpdate(sql);
			return rowAffected > 0;
		} catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
}
