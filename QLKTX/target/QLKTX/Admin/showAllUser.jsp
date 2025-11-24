<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.bean.*"%>
<%@page import="model.dto.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý tài khoản</title>
<style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            overflow-y: hidden;
        }

        .admin-container {
            display: flex;
        }

        .sidebar {
            width: 200px;
            height: 100vh;
            background-color: #f4f4f4;
            padding: 20px
        }

        .sidebar h3 {
            margin-top: 0;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            padding: 10px;
            cursor: pointer;
        }

        .sidebar ul li.active {
            background-color: #ddd;
        }

        .main-content {
            flex-grow: 1;
            padding: 20px;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
        }

        #add-user {
            background-color: #3ea4c6;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 10px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        #add-user:hover {
            background-color: #2b91b0;
        }

        .controls-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }

        .search {
            display: flex;
            flex: 1;
            justify-content: center;
            margin-right: 10px;
        }

        .search input {
            width: 50%;
            max-width: 600px;
            padding: 10px;
            border: 2px solid #3ea4c6;
            border-radius: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: box-shadow 0.3s ease, border-color 0.3s ease;
        }

        .search input:focus {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            border-color: #2b91b0;
            outline: none;
        }

        .sort-dropdown,
        .search-dropdown {
            display: flex;
            align-items: center;
        }
        .sort-dropdown select {
            padding: 5px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        .search-dropdown select {
            margin-right: 2vw;
            margin-left: 5px;
            padding: 5px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .user-list {
            margin-top: 20px;
            max-height: 75vh;
            overflow-y: auto;
            border: 1px solid #ddd;
        }

        .user-list::-webkit-scrollbar {
            width: 5px;
            height: 5px;
        }

        .user-list::-webkit-scrollbar-thumb {
            background-color: #888;
            border-radius: 10px;
            border: 2px solid transparent;
        }

        .user-list::-webkit-scrollbar-thumb:hover {
            background-color: #555;
        }

        .user-list::-webkit-scrollbar-track {
            background-color: #f1f1f1;
            border-radius: 10px;
        }

        .user-list::-webkit-scrollbar-button {
            display: none;
        }

        .table-container {
            margin: 20px auto;
            overflow-x: auto;
            max-width: 90%;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table caption {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0;
            color: #3ea4c6;
        }

        table thead {
            background-color: #3ea4c6;
            color: #fff;
        }

        th,
        td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 10px;
        }

        tbody tr:nth-child(even) {
            background-color: #f7f7f7;
        }

        tbody tr:hover {
            background-color: #dfdfdf;
        }

        .profile-pic {
            width: 30px;
            height: 30px;
            border-radius: 50%;
        }

        .history-btn {
            border: none;
            padding: 8px 12px;
            color: #fff;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .history-btn {
            background-color: #007bff;
        }

        .history-btn:hover {
            background-color: #024996;
        }

        .user-list-container {
            width: 100%;
            overflow-x: hidden;
            display: flex;
            flex-direction: column;
        }

        .user-item {
            width: 100%;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
	<div class="admin-container">
        <div class="main-content">
            <header>
                <h2>DANH SÁCH CÁC TÀI KHOẢN</h2>
                <button id="add-user">Thêm tài khoản</button>
            </header>
            <div class="controls-container">
                <div class="search">
                    <input type="text" id="search-input" placeholder="Tìm kiếm trong bảng...">
                </div>
                <div class="search-dropdown">
                    <label for="search-options">Tìm kiếm theo:</label> <select id="search-options">
                        <option value="Mã người dùng">Mã người dùng</option>
                        <option value="Họ">Họ</option>
                        <option value="Tên">Tên</option>
                        <option value="Giới tính">Giới tính</option>
                        <option value="SĐT">SĐT</option>
                        <option value="CCCD">CCCD</option>
                    </select>
                </div>
                <div class="sort-dropdown">
                    <label for="sort-options">Sắp xếp theo:</label>
                    <select id="sort-options">
                        <option value="Mã người dùng">Mã người dùng</option>
                        <option value="Họ">Họ</option>
                        <option value="Tên">Tên</option>
                        <option value="Giới tính">Giới tính</option>
                    </select>
                </div>
            </div>
            <div class="user-list">
                <table>
                    <thead>
                        <tr>
                            <th>Mã người dùng</th>
                            <th>Họ</th>
                            <th>Tên</th>
                            <th>Giới tính</th>
                            <th>Số điện thoại</th>
                            <th>CCCD</th>
                            <th>Tùy chọn</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    	ArrayList<User> userList = (ArrayList<User>) request.getAttribute("userList");
                    	for(int i = 0; i < userList.size(); i++) {
                    %>
                        <tr>
                            <td><%=userList.get(i).getUser_id()%></td>
                            <td><%=userList.get(i).getFirstname()%></td>
                            <td><%=userList.get(i).getLastname()%></td>
                            <td><%=userList.get(i).isMale() ? "Nam" : "Nữ"%></td>
                            <td><%=userList.get(i).getPhonenumber()%></td>
                            <td><%=userList.get(i).getCccd()%></td>
                            <td>
                                <button class="history-btn" data-user-id="1" onclick="contractHistory('<%=userList.get(i).getUser_id()%>')">Xem lịch sử thuê</button>
                            </td>
                        </tr>
                    <%
                    	}
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
<script>
		function contractHistory(user_id) {
			window.location.href = "<%=request.getContextPath()%>/UserController?action=contracthistory&userid=" + user_id;
		}

        function setupAddUserButton() {
            const addRoomButton = document.getElementById('add-user');
            addRoomButton.addEventListener('click', () => {
                window.location.href = "<%=request.getContextPath()%>/UserController?action=adduser";
            });
        }

        function setupTableSortingAndSearch() {
            const tableBody = document.querySelector('tbody');
            const searchInput = document.getElementById('search-input');
            const searchOptions = document.getElementById('search-options');
            const sortOptions = document.getElementById('sort-options');
            const tableRows = document.querySelectorAll('tbody tr');

            const filterAndSortTable = () => {
                const rows = Array.from(tableBody.rows);	
                const searchValue = searchInput.value.toLowerCase();
                const searchColumnIndex = {
                	"Mã người dùng": 0,
                    "Họ": 1,
                    "Tên": 2,
                    "Giới tính": 3,
                    "SĐT": 4,
                    "CCCD": 5
                }[searchOptions.value];
                const sortColumnIndex = {
                	"Mã người dùng": 0,
                    "Họ": 1,
                    "Tên": 2,
                    "Giới tính": 3,
                }[sortOptions.value];

                rows.forEach(row => {
                    const cellValue = row.cells[searchColumnIndex].textContent.toLowerCase();
                    if (cellValue.includes(searchValue)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
                
                rows.sort((rowA, rowB) => {
                    const cellA = rowA.cells[sortColumnIndex].textContent.trim();
                    const cellB = rowB.cells[sortColumnIndex].textContent.trim();

                    const valueA = isNaN(cellA) ? cellA.toLowerCase() : parseFloat(cellA);
                    const valueB = isNaN(cellB) ? cellB.toLowerCase() : parseFloat(cellB);

                    return typeof valueA === 'number' && typeof valueB === 'number'
                        ? valueA - valueB
                        : valueA.localeCompare(valueB, undefined, { numeric: true });
                });

                tableBody.innerHTML = '';
                rows.forEach(row => tableBody.appendChild(row));
            };

            searchInput.addEventListener('input', filterAndSortTable);
            searchOptions.addEventListener('change', filterAndSortTable);
            sortOptions.addEventListener('change', filterAndSortTable);
        }

        document.addEventListener('DOMContentLoaded', () => {
            setupAddUserButton();
            setupTableSortingAndSearch();
        });
    </script>
</html>