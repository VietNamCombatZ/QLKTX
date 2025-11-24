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
<title>Thuê phòng</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	overflow-y: auto;
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

.month-container {
	padding: 5px 10px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
	font-size: 14px;
	margin-left: auto;
}

.month-selector {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 10px;
	font-size: 16px;
}

.month-selector button {
	padding: 5px 10px;
	border: none;
	border-radius: 4px;
	background-color: #3ea4c6;
	color: #fff;
	cursor: pointer;
}

.month-selector button:hover {
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

.sort-dropdown, .search-dropdown {
	display: flex;
	align-items: center;
}

.sort-dropdown select {
	padding: 5px;
	margin-left: 5px;
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

.profile-pic {
	width: 30px;
	height: 30px;
	border-radius: 50%;
}

.rent-btn {
	border: none;
	padding: 8px 12px;
	color: #fff;
	font-size: 14px;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.rent-btn {
	background-color: #007bff;
}

.rent-btn:hover {
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

@media screen and (max-width: 1024px) {
	.admin-container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
		height: auto;
		padding: 10px;
		text-align: center;
	}
	.main-content {
		padding: 10px;
	}
	.controls-container {
		flex-direction: column;
		gap: 10px;
	}
	.search {
		width: 100%;
		margin-right: 0;
	}
	.search input {
		width: 100%;
		max-width: 100%;
	}
	table {
		font-size: 14px;
	}
	th, td {
		padding: 6px;
	}
	.month-container {
		display: none;
	}
}
</style>
</head>
<body>
	<div class="admin-container">
		<div class="main-content">
			<header>
				<h2>DANH SÁCH CÁC PHÒNG</h2>
				<div class="month-container">
					<div class="month-selector">
						<button id="prev-month">Trước</button>
						<span id="current-month">Tháng 12, 2024</span>
						<button id="next-month">Sau</button>
					</div>
				</div>
			</header>
			<div class="controls-container">
				<div class="search">
					<input type="text" id="search-input"
						placeholder="Tìm kiếm trong bảng...">
				</div>
				<div class="search-dropdown">
					<label for="search-options">Tìm kiếm theo:</label> <select
						id="search-options">
						<option value="Số phòng">Số phòng</option>
						<option value="Loại phòng">Loại phòng</option>
						<option value="Sức chứa">Sức chứa</option>
						<option value="Giá">Giá</option>
					</select>
				</div>
				<div class="sort-dropdown">
					<label for="sort-options">Sắp xếp theo:</label> <select
						id="sort-options">
						<option value="Số phòng">Số phòng</option>
						<option value="Loại phòng">Loại phòng</option>
						<option value="Sức chứa">Sức chứa</option>
						<option value="Giá">Giá</option>
					</select>
				</div>
			</div>
			<div class="user-list">
				<table>
					<thead>
						<tr>
							<th>Số phòng</th>
							<th>Loại phòng</th>
							<th>Sức chứa</th>
							<th>Trạng thái</th>
							<th>Giá</th>
							<th>Thao tác</th>
						</tr>
					</thead>
					<tbody>
						<%
						ArrayList<RoomDTO> roomList = (ArrayList<RoomDTO>) request.getAttribute("roomDtoList");
						for(int i = 0; i < roomList.size(); i++)
						{
						%>
							<tr>
								<td><%=roomList.get(i).getRoom_id()%></td>
								<td><%=roomList.get(i).getType()%></td>
								<td><%=roomList.get(i).getCapacity()%></td>
								<td><%=roomList.get(i).getState()%></td>
								<td><%=roomList.get(i).getPrice()%></td>
								<td><button class="rent-btn" onclick="rend('<%=roomList.get(i).getRoom_id()%>')">Thuê</button></td>
							</tr>
						<%
							}
						%>
					</tbody>
				</table>
							<
			</div>
		</div>
	</div>
</body>
<script>
        const currentMonthElement = document.getElementById('current-month');
        const prevMonthBtn = document.getElementById('prev-month');
        const nextMonthBtn = document.getElementById('next-month');

		let currentDate = new Date();
        
        <%
        	String month = (String) request.getAttribute("month");
        	String year = (String) request.getAttribute("year");
        	if(month != null) {
        %>
        	currentDate.setMonth(<%=Integer.parseInt(month) - 1%>);
        	currentDate.setFullYear(<%=Integer.parseInt(year)%>)
       	<%
        	}
       	%>
        
        const updateMonthDisplay = () => {
            const monthNames = [
                "Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5",
                "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9",
                "Tháng 10", "Tháng 11", "Tháng 12"
            ];
            currentMonthElement.textContent = monthNames[currentDate.getMonth()] + ", " + currentDate.getFullYear();
        };
        
        

        prevMonthBtn.addEventListener('click', () => {
            currentDate.setMonth(currentDate.getMonth() - 1);
        	window.location.href = "<%= request.getContextPath() %>/RoomController?action=_viewallroom&month=" + (currentDate.getMonth() + 1) + "&year=" + currentDate.getFullYear();

            
        });

        nextMonthBtn.addEventListener('click', () => {
            currentDate.setMonth(currentDate.getMonth() + 1);
        	window.location.href = "<%= request.getContextPath() %>/RoomController?action=_viewallroom&month=" + (currentDate.getMonth() + 1) + "&year=" + currentDate.getFullYear();
        });
        
        function rend(roomid) {
        	window.location.href = "<%=request.getContextPath()%>/ContractController?action=rend&roomid=" + roomid;
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
                    "Số phòng": 0,
                    "Loại phòng": 1,
                    "Sức chứa": 2,
                    "Giá": 4
                }[searchOptions.value];
                const sortColumnIndex = {
                    "Số phòng": 0,
                    "Loại phòng": 1,
                    "Sức chứa": 2,
                    "Giá": 4
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
            setupTableSortingAndSearch();
            updateMonthDisplay();
        });


    </script>
</html>