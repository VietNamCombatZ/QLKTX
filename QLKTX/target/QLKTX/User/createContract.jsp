<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.bean.*"%>
<%@page import="model.dto.*"%>
<%@page import="java.util.*"%>
<%@page import="helper.GenerateNewCode"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tạo hợp đồng mớie</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f6f9;
	margin: 0;
	padding: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%;
}

.form-container {
	width: 90%;
	max-width: 700px;
	padding: 20px;
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
}

.back-button {
	position: absolute;
	top: 10px;
	left: 10px;
	padding: 10px 20px;
	font-size: 1rem;
	color: white;
	background-color: #3ea4c6;
	border-radius: 5px;
	text-decoration: none;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
}

h2 {
	font-size: 1.5rem;
	margin-bottom: 20px;
	color: #3ea4c6;
	text-align: center;
}

table {
	width: 100%;
	border-spacing: 15px 10px;
}

td {
	padding: 10px;
	font-size: 1rem;
	color: #555;
}

input[type="text"], select {
	width: 100%;
	padding: 8px;
	font-size: 1rem;
	border: 1px solid #ccc;
	border-radius: 5px;
}

input[type="submit"], input[type="reset"] {
	width: 45%;
	padding: 10px;
	font-size: 1rem;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 10px;
	background-color: #3ea4c6;
	text-align: center;
	text-decoration: none;
}

input[type="submit"] {
	margin-left: 30px;
}

input[type="reset"] {
	margin-left: 20px;
}

input[type="submit"]:hover, input[type="reset"]:hover {
	background-color: #2a6c81;
}

/* Responsive */
@media ( max-width : 768px) {
	table {
		display: block;
	}
	tr, td {
		display: block;
		width: 100%;
	}
	td {
		padding: 10px 0;
	}
	input[type="submit"], input[type="reset"] {
		width: 100%;
		margin: 5px 0;
	}
	.form-container {
		padding: 15px;
	}
	h2 {
		font-size: 1.3rem;
	}
}
</style>
</head>
<body>
	<%
		Calendar calendar = Calendar.getInstance();
		int month = calendar.get(Calendar.MONTH) + 1;
		int year = calendar.get(Calendar.YEAR);
	%>
	<a href="<%= request.getContextPath() %>/RoomController?action=_viewallroom&month=<%=month%>&year=<%=year%>" class="back-button">← Back</a>
	<div class="form-container">
		<h2>Tạo hợp đồng mới</h2>
		<%
			User user = (User) request.getAttribute("user");
			String room_id = (String) request.getAttribute("roomid");
		%>
		<form action="<%=request.getContextPath()%>/ContractController?action=rendhandle" method="post">
			<table>
				<tr>
					<td><label for="userid">Mã người dùng</label></td>
					<td colspan="3"><input type="text" name="userid" id="userid"
						value="<%=user.getUser_id()%>" required></td>
				</tr>
				<tr>
					<td><label for="ho">Họ</label></td>
					<td><input type="text" name="firstname" value="<%=user.getFirstname()%>" required /></td>
					<td><label for="ten">Tên</label></td>
					<td><input type="text" name="lastname" value="<%=user.getLastname()%>" required></td>
				</tr>
				<tr>
					<td><label for="sdt">Số điện thoại</label></td>
					<td><input type="text" name="phonenumber" value="<%=user.getPhonenumber()%>" required /></td>
					<td><label for="gioitinh">Giới tính</label></td>
					<td>
                        <select name="" id="loaiphong" required disabled>
                        	<%
                        		if(user.isMale())
                        		{
                        	%>
	                            <option value="Nam" selected>Nam</option>
	                            <option value="Nữ">Nữ</option>
                            <%
                        		} else {
                        			
                            %>
	                            <option value="Nam">Nam</option>
	                            <option value="Nữ" selected>Nữ</option>
                            <%
                        		}
                            %>
                        </select>
                        <input type="hidden" name="gender" value="<%=user.isMale() ? "Nam" : "Nữ"%>" />
                    </td>
				</tr>
				<tr>
					<td><label for="cccd">CCCD</label></td>
					<td><input type="text" name="cccd" value="<%=user.getCccd()%>"
						required /></td>
				</tr>
				<tr>
					<%
						ArrayList<String> ex_code = (ArrayList<String>) request.getAttribute("code");
						String code = new GenerateNewCode().generateNewCode(ex_code);
					%>
					<td><label for="contractid">Mã hợp đồng</label></td>
                    <td><input type="text" name="contractid" value="<%=code%>" required readonly /></td>
					<td><label for="room">Phòng muốn thuê</label></td>
					<td><input type="text" name="roomid" value="<%=room_id%>"
						required readonly /></td>
				</tr>
				<tr>
					<td><label for="month-start">Tháng bắt đầu</label></td>
					<td><input type="text" name="month-start" value="" required
						placeholder="mm/yyyy" /></td>
					<td><label for="duration">Số tháng thuê</label></td>
					<td><input type="text" name="duration" value="" required
						placeholder="Ví dụ: 3" /></td>
				</tr>
				<tr>
					<td><label for="start">Từ</label></td>
					<td><input type="text" name="start" value="" required /></td>
					<td><label for="to">Đến</label></td>
					<td><input type="text" name="end" value="" required /></td>
				</tr>
				<tr>
					<td colspan="4"><input type="submit" value="Tạo mới" /><input
						type="reset" value="Hủy" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script>
    function updateContractDates() {
        const monthStartInput = document.getElementsByName('month-start')[0];
        const durationInput = document.getElementsByName('duration')[0];
        const startInput = document.getElementsByName('start')[0];
        const endInput = document.getElementsByName('end')[0];

        const monthStart = monthStartInput.value;
        const duration = parseInt(durationInput.value);

        if (monthStart && !isNaN(duration) && duration > 0) {
            const [month, year] = monthStart.split('/').map(Number);

            const startDate = new Date(year, month - 1, 1);
            const endDate = new Date(year, month - 1 + duration, 0);

            const formatDate = (date) => 
            String(date.getDate()).padStart(2, '0') + '/' +
            String(date.getMonth() + 1).padStart(2, '0') + '/' +
            date.getFullYear();

            startInput.value = formatDate(startDate);
            endInput.value = formatDate(endDate);
        }
    }

    function validateInputs() {
        const useridInput = document.getElementsByName('userid')[0];
        const hoInput = document.getElementsByName('ho')[0];
        const tenInput = document.getElementsByName('ten')[0];
        const sdtInput = document.getElementsByName('sdt')[0];
        const cccdInput = document.getElementsByName('cccd')[0];
        const monthStartInput = document.getElementsByName('month-start')[0];
        const durationInput = document.getElementsByName('duration')[0];

        const userIdRegex = /^\d{10}$/;
        if (!userIdRegex.test(useridInput.value)) {
            alert("Mã người dùng phải là 10 chữ số.");
            useridInput.focus();
            return false;
        }
        const nameRegex = /^[A-ZÀ-Ỹ][a-zà-ỹ]*( [A-ZÀ-Ỹ][a-zà-ỹ]*)*$/;
        if (!nameRegex.test(hoInput.value)) {
            alert("Họ chỉ được chứa chữ cái và phải viết hoa chữ cái đầu mỗi từ.");
            hoInput.focus();
            return false;
        }
        if (!nameRegex.test(tenInput.value)) {
            alert("Tên chỉ được chứa chữ cái và phải viết hoa chữ cái đầu mỗi từ.");
            tenInput.focus();
            return false;
        }
        const phoneRegex = /^\d{10}$/;
        if (!phoneRegex.test(sdtInput.value)) {
            alert("Số điện thoại phải là 10 chữ số.");
            sdtInput.focus();
            return false;
        }
        const cccdRegex = /^\d{12}$/;
        if (!cccdRegex.test(cccdInput.value)) {
            alert("CCCD phải là 12 chữ số.");
            cccdInput.focus();
            return false;
        }

        const monthStart = monthStartInput.value.trim();
        const duration = durationInput.value.trim();
        const monthStartRegex = /^(0[1-9]|1[0-2])\/\d{4}$/;
        if (!monthStartRegex.test(monthStart)) {
            alert("Tháng bắt đầu phải có định dạng mm/yyyy (ví dụ: 09/2024).");
            monthStartInput.focus();
            return false;
        }

        const [inputMonth, inputYear] = monthStart.split('/').map(Number);
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth() + 1;
        const currentYear = currentDate.getFullYear();

        if (inputYear < currentYear || (inputYear === currentYear && inputMonth < currentMonth)) {
            alert("Tháng bắt đầu phải từ tháng hiện tại trở về sau.");
            monthStartInput.focus();
            return false;
        }

        const durationNumber = parseInt(duration, 10);
        if (isNaN(durationNumber) || durationNumber <= 0) {
            alert("Số tháng thuê phải là số nguyên dương (ví dụ: 3).");
            durationInput.focus();
            return false;
        }

        return true;
    }

    document.querySelector('form').addEventListener('submit', function (e) {
        if (!validateInputs()) {
            e.preventDefault();
        }
    });
    document.getElementsByName('month-start')[0].addEventListener('input', updateContractDates);
    document.getElementsByName('duration')[0].addEventListener('input', updateContractDates);
</script>
</html>