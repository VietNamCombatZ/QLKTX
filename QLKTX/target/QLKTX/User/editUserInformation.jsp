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
<title>Chỉnh sửa thông tin cá nhân</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f6f9;
	margin: 0;
	padding: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
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

.back-button:hover {
	background-color: #2a6c81;
}

h2 {
	font-size: 1.8rem;
	margin-bottom: 20px;
	color: #3ea4c6;
	text-align: center;
}

table {
	width: 100%;
	margin-bottom: 20px;
	border-spacing: 25px 10px;
}

td {
	padding: 10px;
	font-size: 1rem;
	color: #555;
	vertical-align: auto;
}

input[type="text"], select {
	width: 100%;
	padding: 10px;
	font-size: 1rem;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-top: 5px;
}

input[type="submit"], input[type="reset"] {
	width: 48%;
	padding: 10px;
	font-size: 1rem;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-top: 10px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
}

input[type="submit"], input[type="reset"] {
	background-color: #3ea4c6;
	margin: 0.3vw;
}

input[type="submit"]:hover, input[type="reset"]:hover {
	background-color: #2a6c81;
}

td:last-child {
	text-align: left;
}

td[colspan="4"] {
	text-align: center;
}

label {
	font-size: 1rem;
	color: #333;
}

input[type="text"]:focus, select:focus {
	border-color: #007bff;
	outline: none;
}

@media ( max-width : 600px) {
	h2 {
		font-size: 1.5rem;
	}
	input[type="submit"], input[type="reset"], .back-button {
		width: 100%;
	}
}
</style>
</head>
<body>
	<div class="form-container">
		<h2>Chỉnh sửa thông tin cá nhân</h2>
		<%
			User user = (User) request.getAttribute("user");
		%>
		<form action="<%=request.getContextPath()%>/UserController?action=edithandle" method="post">
			<table>
				<tr>
					<td><label for="userid">Mã sinh viên</label></td>
					<td><input type="text" name="userid" id="userid"
						value="<%=user.getUser_id()%>" required readonly /></td>

				</tr>
				<tr>
					<td><label for="ho">Họ</label></td>
					<td><input type="text" name="firstname" id="ho" value="<%=user.getFirstname()%>"
						required /></td>
				</tr>
				<tr>
					<td><label for="ten">Tên</label></td>
					<td><input type="text" name="lastname" id="ten" value="<%=user.getLastname()%>" required /></td>
				</tr>
				<tr>
					<td><label for="sdt">Số điện thoại</label></td>
					<td><input type="text" name="phonenumber" value="<%=user.getPhonenumber()%>" required /></td>
				</tr>
				<tr>
					<td><label for="gioitinh">Giới tính</label></td>
					<td>
                        <select name="gender" id="loaiphong" required>
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
                    </td>
				</tr>
				<tr>
					<td><label for="cccd">CCCD</label></td>
					<td><input type="text" name="cccd" value="<%=user.getCccd()%>"
						required /></td>
				<tr>
					<td colspan="4"><input type="submit" value="Lưu" /><input
						type="reset" value="Hủy" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script>
	function validateInputs() {
		const useridInput = document.getElementsByName('userid')[0];
		const hoInput = document.getElementsByName('ho')[0];
		const tenInput = document.getElementsByName('ten')[0];
		const sdtInput = document.getElementsByName('sdt')[0];
		const cccdInput = document.getElementsByName('cccd')[0];

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
		return true;
	}

	document.querySelector('form').addEventListener('submit', function(e) {
		if (!validateInputs()) {
			e.preventDefault();
		}
	});
</script>
</html>