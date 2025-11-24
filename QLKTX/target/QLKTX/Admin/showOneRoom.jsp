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
<title>Chi tiết phòng</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
	color: #333;
}

h2 {
	text-align: center;
	margin: 20px 0;
	color: #3ea4c6;
}

.form-container {
	margin: 20px auto;
	max-width: 500px;
	padding: 15px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-container table {
	width: 100%;
}

.form-container td {
	padding: 10px;
	vertical-align: middle;
}

input[type="text"] {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #f2f2f2;
}

.controls-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	align-items: center;
	margin: 20px auto;
	max-width: 300px;
	gap: 15px;
}

.month-container {
	flex: 1 1 300px;
	padding: 10px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
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
	background-color: #f2f2f2;
}

tbody tr:hover {
	background-color: #f1f1f1;
}

img {
	width: 20px;
	height: 20px;
	object-fit: contain;
}

.button-container {
	margin-top: 20px;
	text-align: center;
}

.save-btn, .cancel-btn {
	background-color: #3ea4c6;
	margin: 10px;
	color: white;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	border-radius: 10px;
	font-size: 16px;
	transition: background-color 0.3s ease;
}

.save-btn:hover, .cancel-btn:hover {
	background-color: #2b91b0;
}

.back-button {
	width: 48%;
	padding: 10px;
	font-size: 1rem;
	color: white;
	background-color: #3ea4c6;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 10px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
}

.back-button:hover {
	background-color: #2a6c81;
}

.back-button {
	position: absolute;
	top: 20px;
	left: 10px;
	padding: 3px 8px;
	font-size: 0.8rem;
	width: 10vw !important;
	color: white;
	background-color: #3ea4c6;
	border-radius: 5px;
	text-decoration: none;
	box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1);
	transition: background-color 0.3s ease;
}

@media ( max-width : 768px) {
	table {
		display: block;
		width: 100%;
		overflow-x: auto;
	}
	th, td {
		font-size: 12px;
		padding: 8px;
	}
	h2 {
		font-size: 20px;
	}
	input[type="text"] {
		font-size: 14px;
		padding: 6px;
	}
	.save-btn {
		font-size: 12px;
		padding: 5px 10px;
	}
}

@media ( max-width : 480px) {
	th, td {
		font-size: 10px;
		padding: 6px;
	}
	h2 {
		font-size: 18px;
	}
}

@media ( max-width : 600px) {
	back-button {
		width: 100%;
	}
}
</style>
</head>
<body>
	<%
	Calendar calendar = Calendar.getInstance();
	int month_now = calendar.get(Calendar.MONTH) + 1;
	int year_now = calendar.get(Calendar.YEAR);
	%>
	<a
		href="<%=request.getContextPath()%>/RoomController?action=viewallroom&month=<%=month_now%>&year=<%=year_now%>"
		class="back-button">← Back</a>
	<h2>CHI TIẾT PHÒNG</h2>
	<div class="form-container">
		<%
		Room room = (Room) request.getAttribute("room");
		String state = (String) request.getAttribute("state");
		%>
		<table>
			<tr>
				<td><label for="sophong">Số Phòng</label></td>
				<td><input type="text" id="sophong"
					value="<%=room.getRoom_id()%>" disabled></td>
			</tr>
			<tr>
				<td><label for="loaiphong">Loại Phòng</label></td>
				<td><input type="text" id="loaiphong"
					value="<%=room.getType()%>" disabled></td>
			</tr>
			<tr>
				<td><label for="trangthai">Trạng Thái</label></td>
				<td><input type="text" id="trangthai" value="<%=state%>"
					disabled></td>
			</tr>
		</table>
	</div>
	<div class="controls-container">
		<div class="month-container">
			<div class="month-selector">
				<button id="prev-month">Trước</button>
				<span id="current-month">Tháng 12, 2024</span>
				<button id="next-month">Sau</button>
			</div>
		</div>
	</div>
	<div class="table-container">
		<table>
			<caption>DANH SÁCH NGƯỜI THUÊ PHÒNG</caption>
			<thead>
				<tr>
					<th>Mã người dùng</th>
					<th>Họ</th>
					<th>Tên</th>
					<th>SĐT</th>
					<th>CCCD</th>
					<th>Tiền phòng</th>
					<th>Điện</th>
					<th>Nước</th>
					<th>Wifi</th>
					<th>Lưu</th>
				</tr>
			</thead>
			<tbody>
				<%
				ArrayList<RoomRecordDTO> recordDtoList = (ArrayList<RoomRecordDTO>) request.getAttribute("recordDtoList");
				for (int i = 0; i < recordDtoList.size(); i++) {
				%>
				<tr>
					<td><%=recordDtoList.get(i).getUser_id()%></td>
					<td><%=recordDtoList.get(i).getFirstname()%></td>
					<td><%=recordDtoList.get(i).getLastname()%></td>
					<td><%=recordDtoList.get(i).getPhonenumber()%></td>
					<td><%=recordDtoList.get(i).getCccd()%></td>
					<td>
						<%
						if (recordDtoList.get(i).isRoom()) {
						%> <img src="image/tick.png" alt="yes"> <%
 } else {
 %> <img src="image/x.png" alt="no"> <%
 }
 %>
					</td>
					<td>
						<%
						if (recordDtoList.get(i).isElectric()) {
						%> <img src="image/tick.png" alt="yes"> <%
 } else {
 %> <img src="image/x.png" alt="no"> <%
 }
 %>
					</td>
					<td>
						<%
						if (recordDtoList.get(i).isWater()) {
						%> <img src="image/tick.png" alt="yes"> <%
 } else {
 %> <img src="image/x.png" alt="no"> <%
 }
 %>
					</td>
					<td>
						<%
						if (recordDtoList.get(i).isWifi()) {
						%> <img src="image/tick.png" alt="yes"> <%
 } else {
 %> <img src="image/x.png" alt="no"> <%
 }
 %>
					</td>
					<td><input type="submit" id="save-btn" class="save-btn"
						value="Save"></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<div class="button-container">
			<input type="reset" id="cancel-btn" class="cancel-btn" value="Cancel">
		</div>
	</div>
</body>
<script>
    const currentMonthElement = document.getElementById('current-month');
    const prevMonthBtn = document.getElementById('prev-month');
    const nextMonthBtn = document.getElementById('next-month');

    let currentDate = new Date();
	
    <%String month = (String) request.getAttribute("month");
String year = (String) request.getAttribute("year");
if (month != null) {%>
		currentDate.setMonth(<%=Integer.parseInt(month) - 1%>);
		currentDate.setFullYear(<%=Integer.parseInt(year)%>)
	<%}%>
    
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
        window.location.href = "<%=request.getContextPath()%>/RoomController?action=viewdetailroom&roomid=" + "<%=room.getRoom_id()%>" + "&month=" + (currentDate.getMonth() + 1) + "&year=" + currentDate.getFullYear();
    });

    nextMonthBtn.addEventListener('click', () => {
        currentDate.setMonth(currentDate.getMonth() + 1);
        window.location.href = "<%=request.getContextPath()%>/RoomController?action=viewdetailroom&roomid=" + "<%=room.getRoom_id()%>" + "&month=" + (currentDate.getMonth() + 1) + "&year=" + currentDate.getFullYear();
    });

    updateMonthDisplay();

    function initializePaymentTable() {
        const paymentCells = document.querySelectorAll('tbody td img');
        const originalStates = [];

        function saveOriginalState() {
            originalStates.length = 0;
            paymentCells.forEach(cell => {
                originalStates.push({
                    src: cell.src,
                    alt: cell.alt
                });
            });
        }

        paymentCells.forEach((cell) => {
            cell.addEventListener('click', () => {
                if (cell.alt === 'no') {
                    cell.src = 'image/tick.png';
                    cell.alt = 'yes';
                } else {
                    alert('Bạn không thể thay đổi ô này từ tick xanh sang trạng thái khác!');
                }
            });
        });

        function saveTableState(userid, roomid, room, electric, water, wifi) {
            const updatedStates = Array.from(paymentCells).map(cell => ({ src: cell.src, alt: cell.alt }));
            alert('Trạng thái đã được lưu!');
            window.location.href = "<%=request.getContextPath()%>/RoomController?action=updaterecord&userid=" + userid + "&roomid=" + roomid + "&room=" + room + "&electric=" + electric + "&water=" + water + "&wifi=" + wifi + "&month=<%=month%>&year=<%=year%>";
        }

        function restoreOriginalState() {
            paymentCells.forEach((cell, index) => {
                cell.src = originalStates[index].src;
                cell.alt = originalStates[index].alt;
            });
            alert('Bảng đã được khôi phục trạng thái ban đầu.');
        }

        const saveButtons = document.querySelectorAll('.save-btn');
        saveButtons.forEach((button) => {
            button.addEventListener('click', () => {
            	const row = button.closest('tr');
            	const userid = row.cells[0].innerText;
            	const status = {
                        room: row.cells[5].querySelector('img').alt === 'yes',
                        electric: row.cells[6].querySelector('img').alt === 'yes',
                        water: row.cells[7].querySelector('img').alt === 'yes',
                        wifi: row.cells[8].querySelector('img').alt === 'yes',
                };
            	const roomid = "<%=room.getRoom_id()%>";
            	saveTableState(userid, roomid, status.room, status.electric, status.water, status.wifi);
            });
        });

        const cancelButtons = document.querySelectorAll('.cancel-btn');
        cancelButtons.forEach((button) => {
            button.addEventListener('click', restoreOriginalState);
        });


        saveOriginalState();
    }
    initializePaymentTable();
</script>
</html>