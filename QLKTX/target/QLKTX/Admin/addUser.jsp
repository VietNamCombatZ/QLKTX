<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm tài khoản</title>
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

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	font-size: 1rem;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-top: 5px;
}

input[type="submit"], input[type="reset"], .back-button {
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

input[type="submit"]:hover, input[type="reset"]:hover, .back-button:hover
	{
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

select {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 5px;
        }

@media ( max-width : 600px) {
	h2 {
		font-size: 1.5rem;
	}
	input[type="submit"], .back-button {
		width: 100%;
	}
}
</style>
</head>
<body>
	<a href="<%= request.getContextPath() %>/UserController?action=viewalluser" class="back-button">← Back</a>
	<div class="form-container">
		<h2>Tạo một tài khoản mới</h2>
		<form action="<%=request.getContextPath()%>/UserController?action=adduserhandle" method="post" onsubmit="validateForm(event)">
			<table>
				<tr>
					<td><label for="userid">Mã người dùng</label></td>
					<td colspan="3"><input type="text" name="userid" id="userid" value="" required></td>
				</tr>
				<tr>
					<td><label for="username">Tên đăng nhập</label></td>
					<td><input type="text" name="username" id="username" value=""
						required /></td>
					<td><label for="password">Mật khẩu</label></td>
					<td><input type="password" name="password" id="password" value=""
						required /></td>
				</tr>
				<tr>
					<td><label for="ho">Họ</label></td>
					<td><input type="text" name="firstname" id="ho" value="" /></td>
					
					<td><label for="gioitinh">Giới tính</label></td>
					<td><select name="gender">
						<option value="Nam">Nam</option>
						<option value="Nữ">Nữ</option>
					</select></td>
				</tr>
				<tr>
					<td><label for="ten">Tên</label></td>
					<td colspan="3"><input type="text" name="lastname" id="ten" value="" /></td>
				</tr>
				<tr>
					<td><label for="sdt">Số điện thoại</label></td>
					<td><input type="text" name="phonenumber" value="" /></td>
					<td><label for="cccd">CCCD</label></td>
					<td><input type="text" name="cccd" value="" /></td>
				</tr>
				<tr>
					<td colspan="4"><input type="submit" value="Thêm" /><input
						type="reset" value="Hủy" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script>
	function validateForm(event) {
		const username = document.getElementById("username").value;
		const password = document.getElementById("password").value;

		const usernameRegex = /^[a-zA-Z0-9_]{6,20}$/;
		if (!usernameRegex.test(username)) {
			alert("Tên đăng nhập phải từ 6-20 ký tự và chỉ chứa chữ cái, số hoặc dấu gạch dưới (_).");
			event.preventDefault();
			return false;
		}

		const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=]).{8,}$/;
		if (!passwordRegex.test(password)) {
			alert("Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.");
			event.preventDefault();
			return false;
		}

		return true;
	}
</script>
</html>