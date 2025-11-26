package model.bo;

import model.dao.*;
import model.bean.*;
import java.util.*;
import java.lang.*;
import java.io.*;

public class ContractBO {
	ContractDAO contractDAO = new ContractDAO();
	
	/**
	 * Check and update expired contracts
	 * A contract is expired if current date > end date
	 */
	private void checkAndUpdateExpiredContracts(ArrayList<Contract> contracts) {
		Date currentDate = new Date();
		for (Contract contract : contracts) {
			// Only update contracts that are currently active or pending
			if ((contract.getState().equals("Đang thuê") || contract.getState().equals("Chờ phê duyệt")) 
				&& contract.getEnd() != null 
				&& currentDate.after(contract.getEnd())) {
				contract.setState("Hết hạn");
				contractDAO.updateContract(contract);
			}
		}
	}
	
	public ArrayList<Contract> getAllContract() {
		ArrayList<Contract> contracts = contractDAO.getAllContract();
		checkAndUpdateExpiredContracts(contracts);
		return contracts;
	}
	
	public ArrayList<Contract> getByUserID(String user_id) {
		ArrayList<Contract> allContracts = contractDAO.getAllContract();
		checkAndUpdateExpiredContracts(allContracts);
		ArrayList<Contract> contractList = new ArrayList<Contract>();
		for (Contract contract : allContracts) {
			if(contract.getUser_id().equals(user_id)) {
				contractList.add(contract);
			}
		}
		return contractList;
	}
	
	public Contract getByContractID(String contract_id) {
		ArrayList<Contract> contractList = contractDAO.getAllContract();
		Contract rescontract = contractList.get(0);
		for(Contract contract : contractList) {
			if(contract.getContract_id().equals(contract_id)) {
				return contract;
			}
		}
		return rescontract;
	}
	
	public boolean addContract(Contract contract) {
		return contractDAO.addContract(contract);
	}
	
	public boolean updateContract(Contract contract) {
		return contractDAO.updateContract(contract);
	}
}
