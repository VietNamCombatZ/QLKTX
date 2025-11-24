<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.bean.*"%>
<%@page import="model.dto.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<title>Quản lý hợp đồng</title>
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
	padding: 20px;
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

.sort-dropdown, .search-dropdow {
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

th, td {
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

.accept-btn, .extend-btn, .delete-btn {
	border: none;
	padding: 8px 12px;
	color: #fff;
	font-size: 14px;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.accept-btn {
	background-color: rgb(243, 158, 1);
}

.extend-btn {
	background-color: rgb(2, 193, 2);
}

.delete-btn {
	background-color: #dc3545;
}

.accept-btn:hover {
	background-color: rgb(198, 130, 3);
}

.extend-btn:hover {
	background-color: rgb(4, 82, 4);
}

.delete-btn:hover {
	background-color: #a71d2a;
}
</style>
</head>
<body>
	<div class="admin-container">
		<div class="main-content">
			<header>
				<h2>DANH SÁCH CÁC HỢP ĐỒNG</h2>
			</header>
			<div class="controls-container">
				<div class="search">
					<input type="text" id="search-input"
						placeholder="Tìm kiếm trong bảng...">
				</div>
				<div class="search-dropdown">
					<label for="search-options">Tìm kiếm theo:</label> <select
						id="search-options">
						<option value="STT">STT</option>
						<option value="Họ">Họ</option>
						<option value="Tên">Tên</option>
						<option value="Phòng">Phòng</option>
						<option value="Thời gian">Thời gian</option>
						<option value="Từ">Từ</option>
						<option value="Đến">Đến</option>
						<option value="Trạng thái">Trạng thái</option>
					</select>
				</div>
				<div class="sort-dropdown">
					<label for="sort-options">Sắp xếp theo:</label> <select
						id="sort-options">
						<option value="STT">STT</option>
						<option value="Họ">Họ</option>
						<option value="Tên">Tên</option>
						<option value="Phòng">Phòng</option>
						<option value="Thời gian">Thời gian</option>
						<option value="Từ">Từ</option>
						<option value="Đến">Đến</option>
						<option value="Trạng thái">Trạng thái</option>
					</select>
				</div>
			</div>
			<div class="user-list">
				<table>
					<thead>
						<tr>
							<th>Mã hợp đồng</th>
							<th>Họ</th>
							<th>Tên</th>
							<th>Phòng</th>
							<th>Thời gian</th>
							<th>Từ</th>
							<th>Đến</th>
							<th>Trạng thái</th>
							<th>Tùy chọn</th>
						</tr>
					</thead>
					<tbody>
					<%
						ArrayList<ContractDTO> contractList = (ArrayList<ContractDTO>) request.getAttribute("contractList");
						for(ContractDTO contract : contractList) {
					%>
						<tr>
							<td><%=contract.getContract_id()%></td>
							<td><%=contract.getFirstname()%></td>
							<td><%=contract.getLastname()%></td>
							<td><%=contract.getRoom_id()%></td>
							<td><%=contract.getDuration()%></td>
							<td><%=contract.getStart()%></td>
							<td><%=contract.getEnd()%></td>
							<td><%=contract.getState()%></td>
							<td>
								<%
									if(contract.getState().equals("Chờ phê duyệt")) {
								%>
									<button class="accept-btn" style="margin-right: 5px" onclick="Accept('<%=contract.getContract_id()%>')">Phê duyệt</button>
								<%
									} else {
								%>
									<button class="extend-btn" style="margin-right: 5px" onclick="Extend('<%=contract.getContract_id()%>', '<%=contract.getUser_id()%>', '<%=contract.getRoom_id()%>')">Gia hạn</button>
								<%
									}									
								%>
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
function addRowClickListener() {
    const tableRows = document.querySelectorAll('tbody tr');

    tableRows.forEach(row => {
        row.addEventListener('click', (event) => {
            const isButton = event.target.closest('button');
            if (!isButton) {
            	const contract_id = row.cells[0].innerText;
                window.location.href = "<%=request.getContextPath()%>/ContractController?action=contractdetail&contractid=" + contract_id;
            }
        });
    });
}

function Accept(contractid, userid) {
	window.location.href = "<%=request.getContextPath()%>/ContractController?action=updatecontract&contractid=" + contractid;	
}

function Extend(contractid, userid, roomid) {
	window.location.href = "<%=request.getContextPath()%>/ContractController?action=_extend&userid=" + userid + "&roomid=" + roomid;
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
        	"STT": 0,
            "Họ": 1,
            "Tên": 2,
            "Phòng": 3,
            "Thời gian": 4,
            "Từ": 5,
            "Đến": 6,
            "Trạng thái": 7
        }[searchOptions.value];
        const sortColumnIndex = {
            "STT": 0,
            "Họ": 1,
            "Tên": 2,
            "Phòng": 3,
            "Thời gian": 4,
            "Từ": 5,
            "Đến": 6,
            "Trạng thái": 7
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
    addRowClickListener(),
    setupTableSortingAndSearch()
});
    </script>
</html>