package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.bean.*;
import model.bo.*;
import model.dto.*;
import java.util.*;
import java.lang.*;
import java.text.SimpleDateFormat;

public class ContractController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		UserBO userBO = new UserBO();
		ContractBO contractBO = new ContractBO();
		U_R_RecordBO recordBO = new U_R_RecordBO();
		if(action.equals("extend")) {
			String user_id = request.getParameter("userid");
			String room_id = request.getParameter("roomid");
			User user = userBO.getUserById(user_id);
			ArrayList<String> existingCodes = new ArrayList<String>();
			for(Contract contract : contractBO.getAllContract()) {
				existingCodes.add(contract.getContract_id());
			}
			String newCode = helper.GenerateNewCode.generateNewCode(existingCodes);
			request.setAttribute("user", user);
			request.setAttribute("roomid", room_id);
			request.setAttribute("code", existingCodes);
			request.setAttribute("newCode", newCode);
			request.getRequestDispatcher("Admin/contractExtension.jsp").forward(request, response);
			return;
		}
		if(action.equals("_extend")) {
			String user_id = request.getParameter("userid");
			String room_id = request.getParameter("roomid");
			User user = userBO.getUserById(user_id);
			ArrayList<String> existingCodes = new ArrayList<String>();
			for(Contract contract : contractBO.getAllContract()) {
				existingCodes.add(contract.getContract_id());
			}
			String newCode = helper.GenerateNewCode.generateNewCode(existingCodes);
			request.setAttribute("user", user);
			request.setAttribute("roomid", room_id);
			request.setAttribute("code", existingCodes);
			request.setAttribute("newCode", newCode);
			request.getRequestDispatcher("Admin/_contractExtension.jsp").forward(request, response);
			return;
		}
		if(action.equals("_extend_")) {
			String user_id = request.getParameter("userid");
			String room_id = request.getParameter("roomid");
			System.out.println(user_id);
			User user = userBO.getUserById(user_id);
			ArrayList<String> existingCodes = new ArrayList<String>();
			for(Contract contract : contractBO.getAllContract()) {
				existingCodes.add(contract.getContract_id());
			}
			String newCode = helper.GenerateNewCode.generateNewCode(existingCodes);
			request.setAttribute("user", user);
			request.setAttribute("roomid", room_id);
			request.setAttribute("code", existingCodes);
			request.setAttribute("newCode", newCode);
			request.getRequestDispatcher("User/contractExtensionOfUser.jsp").forward(request, response);
			return;
		}
		if(action.equals("addcontract")) {
			String contract_id = request.getParameter("contractid");
			String user_id = request.getParameter("userid");
			String room_id = request.getParameter("roomid");
			String duration = request.getParameter("duration");
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			try {
				
				Contract contract = new Contract(contract_id, user_id, room_id, Integer.parseInt(duration), dateFormat.parse(start), dateFormat.parse(end), 
						"Đang thuê");
				boolean isAdded = contractBO.addContract(contract);
				if(isAdded) {
					System.out.println("Success");
					Date startDate = dateFormat.parse(start);
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(startDate);
					for(int i = 0; i < Integer.parseInt(duration); i++) {
						int month = calendar.get(Calendar.MONTH) + 1;
						int year = calendar.get(Calendar.YEAR);
						U_R_Record record = new U_R_Record(room_id, user_id, month, year, false, false, false, false);
						isAdded = recordBO.addRecord(record);
						if(isAdded) {
							System.out.println("Add rc success");
						} else {
							System.out.println("Add rc failed");
						}
						calendar.add(Calendar.MONTH, 1);
					}
				} else {
					System.out.println("Failed");
				}
				ArrayList<Contract> contractList = contractBO.getByUserID(user_id);
				User user = userBO.getUserById(user_id);
				request.setAttribute("user", user);
				request.setAttribute("contractList", contractList);
				request.getRequestDispatcher("Admin/showRoomRentalHistory.jsp").forward(request, response);
				return;
			} catch (Exception e) {
				System.out.println("Error: " + e);
			}
			return;
		}
		if(action.equals("updatecontract")) {
			String contract_id = request.getParameter("contractid");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			try {
				Contract contract = contractBO.getByContractID(contract_id);
				contract.setState("Đang thuê");
				boolean isUpdated = contractBO.updateContract(contract);
				if(isUpdated) {
					System.out.println("Success");
					Date startDate = dateFormat.parse(contract.getStart().toString());
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(startDate);
					for(int i = 0; i < contract.getDuration(); i++) {
						int month = calendar.get(Calendar.MONTH) + 1;
						int year = calendar.get(Calendar.YEAR);
						U_R_Record record = new U_R_Record(contract.getRoom_id(), contract.getUser_id(), month, year, false, false, false, false);
						boolean isAdded = recordBO.addRecord(record);
						if(isAdded) {
							System.out.println("Add rc success");
						} else {
							System.out.println("Add rc failed");
						}
						calendar.add(Calendar.MONTH, 1);
					}
				} else {
					System.out.println("Failed");
				}
				ArrayList<Contract> contractList = contractBO.getAllContract();
				ArrayList<ContractDTO> contractDtoList = new ArrayList<ContractDTO>();
				for(Contract _contract : contractList) {
					User user = userBO.getUserById(_contract.getUser_id());
					ContractDTO contractDTO = new ContractDTO(_contract.getContract_id(), user.getUser_id(), user.getFirstname(), user.getLastname(), _contract.getRoom_id(), _contract.getDuration(), _contract.getStart(), _contract.getEnd(), _contract.getState());
					contractDtoList.add(contractDTO);
				}
				request.setAttribute("contractList", contractDtoList);
				request.getRequestDispatcher("Admin/showAllContract.jsp").forward(request, response);
				return;
			} catch (Exception e) {
				System.out.println("Error: " + e);
			}
			return;
		}
		if(action.equals("_addcontract_")) {
			String contract_id = request.getParameter("contractid");
			String user_id = request.getParameter("userid");
			String room_id = request.getParameter("roomid");
			String duration = request.getParameter("duration");
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			try {
				
				Contract contract = new Contract(contract_id, user_id, room_id, Integer.parseInt(duration), dateFormat.parse(start), dateFormat.parse(end), 
						"Chờ phê duyệt");
				boolean isAdded = contractBO.addContract(contract);
				if(isAdded) {
					System.out.println("Success");
				} else {
					System.out.println("Failed");
				}
				ArrayList<Contract> contractList = contractBO.getByUserID(user_id);
				User user = userBO.getUserById(user_id);
				request.setAttribute("user", user);
				request.setAttribute("contractList", contractList);
				request.getRequestDispatcher("User/showRoomRentalHistoryOfUser.jsp").forward(request, response);
				return;
			} catch (Exception e) {
				System.out.println("Error: " + e);
			}
			return;
		}
		if(action.equals("_addcontract")) {
			String contract_id = request.getParameter("contractid");
			String user_id = request.getParameter("userid");
			String room_id = request.getParameter("roomid");
			String duration = request.getParameter("duration");
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			try {
				
				Contract contract = new Contract(contract_id, user_id, room_id, Integer.parseInt(duration), dateFormat.parse(start), dateFormat.parse(end), 
						"Đang thuê");
				boolean isAdded = contractBO.addContract(contract);
				if(isAdded) {
					System.out.println("Success");
					Date startDate = dateFormat.parse(start);
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(startDate);
					for(int i = 0; i < Integer.parseInt(duration); i++) {
						int month = calendar.get(Calendar.MONTH) + 1;
						int year = calendar.get(Calendar.YEAR);
						U_R_Record record = new U_R_Record(room_id, user_id, month, year, false, false, false, false);
						isAdded = recordBO.addRecord(record);
						if(isAdded) {
							System.out.println("Add rc success");
						} else {
							System.out.println("Add rc failed");
						}
						calendar.add(Calendar.MONTH, 1);
					}
				} else {
					System.out.println("Failed");
				}
				ArrayList<Contract> contractList = contractBO.getAllContract();
				ArrayList<ContractDTO> contractDtoList = new ArrayList<ContractDTO>();
				for(Contract _contract : contractList) {
					User user = userBO.getUserById(_contract.getUser_id());
					ContractDTO contractDTO = new ContractDTO(_contract.getContract_id(), user.getUser_id(), user.getFirstname(), user.getLastname(), _contract.getRoom_id(), _contract.getDuration(), _contract.getStart(), _contract.getEnd(), _contract.getState());
					contractDtoList.add(contractDTO);
				}
				request.setAttribute("contractList", contractDtoList);
				request.getRequestDispatcher("Admin/showAllContract.jsp").forward(request, response);
				return;
			} catch (Exception e) {
				System.out.println("Error: " + e);
			}
			return;
		}
		if(action.equals("rendhandle")) {
			String contract_id = request.getParameter("contractid");
			String user_id = (String) request.getSession().getAttribute("userid");
			String room_id = request.getParameter("roomid");
			String duration = request.getParameter("duration");
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			try {
				Contract contract = new Contract(contract_id, user_id, room_id, Integer.parseInt(duration), dateFormat.parse(start), dateFormat.parse(end), 
						"Chờ phê duyệt");
				boolean isAdded = contractBO.addContract(contract);
				if(isAdded) {
					System.out.println("Success");
				} else {
					System.out.println("Failed");
				}
				ArrayList<Contract> contractList = contractBO.getByUserID(user_id);
				User user = userBO.getUserById(user_id);
				request.setAttribute("user", user);
				request.setAttribute("contractList", contractList);
				request.getRequestDispatcher("User/showRoomRentalHistoryOfUser.jsp").forward(request, response);
				return;
			} catch (Exception e) {
				System.out.println("Error: " + e);
			}
			return;
		}
		if(action.equals("viewallcontract")) {
			ArrayList<Contract> contractList = contractBO.getAllContract();
			ArrayList<ContractDTO> contractDtoList = new ArrayList<ContractDTO>();
			for(Contract contract : contractList) {
				User user = userBO.getUserById(contract.getUser_id());
				ContractDTO contractDTO = new ContractDTO(contract.getContract_id(), user.getUser_id(), user.getFirstname(), user.getLastname(), contract.getRoom_id(), contract.getDuration(), contract.getStart(), contract.getEnd(), contract.getState());
				contractDtoList.add(contractDTO);
			}
			request.setAttribute("contractList", contractDtoList);
			request.getRequestDispatcher("Admin/showAllContract.jsp").forward(request, response);
			return;
		}
		if(action.equals("contractdetail")) {
			String contract_id = request.getParameter("contractid");
			System.out.println(contract_id);
			Contract contract = contractBO.getByContractID(contract_id);
			User user = userBO.getUserById(contract.getUser_id());
			request.setAttribute("user", user);
			request.setAttribute("contract", contract);
			request.getRequestDispatcher("Admin/showOneContract.jsp").forward(request, response);
			return;
		}
		if(action.equals("rend")) {
			String room_id = request.getParameter("roomid");
			String user_id = (String) request.getSession().getAttribute("userid");
			System.out.println(user_id);
			User user = userBO.getUserById(user_id);
			ArrayList<String> existingCodes = new ArrayList<String>();
			for(Contract contract : contractBO.getAllContract()) {
				existingCodes.add(contract.getContract_id());
			}
			request.setAttribute("roomid", room_id);
			request.setAttribute("user", user);
			request.setAttribute("code", existingCodes);
			request.getRequestDispatcher("User/createContract.jsp").forward(request, response);
			return;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
