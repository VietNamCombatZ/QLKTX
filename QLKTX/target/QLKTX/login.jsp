<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f0f8ff;
	color: #333;
	margin: 0;
	padding: 20px;
}

form {
	max-width: 400px;
	margin: auto;
	margin-top: 20vh;
	padding: 20px;
	border: 1px solid #add8e6;
	border-radius: 8px;
	background-color: #e6f7ff;
}

h3 {
	text-align: center;
	color: black;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th {
	text-align: left;
	padding: 10px;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	margin: 5px 0px 10px 0;
	border: 1px solid #add8e6;
	border-radius: 4px;
}

.button-container {
	display: flex;
	justify-content: center;
	margin-top: 10px;
}

input[type="submit"],input[type="button"] {
	background-color: #add8e6;
	color: white;
	padding: 10px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin: 0 5px;
	width: 48%;
}

input[type="submit"],input[type="button"]:hover {
	background-color: #87cefa;
}

@media ( max-width : 600px) {
	form {
		padding: 10px;
	}
	input[type="submit"],input[type="button"]{
		width: 100%;
		margin: 5px 0;
	}
	.button-container {
		flex-direction: column;
	}
}
</style>
</head>
<body>
	<%
		request.getSession().invalidate();
	%>
	<form name="login" action="CheckLoginServlet">
		<h3>ĐĂNG NHẬP</h3>
		<table>
			<tr>
				<th>Tên đăng nhập</th>
				<th><input type="text" id="username" name="username"></th>
			</tr>
			<tr>
				<th>Mật khẩu</th>
				<th><input type="password" id="password" name="password">
				</th>
			</tr>
		</table>
		<div class="button-container">
			<input type="submit" value="OK"> 
			<input type="button" onclick="reset()" value="Reset">
		</div>
	</form>
</body>
<script type="text/javascript">
	function reset() {
		document.getElementById("username").value = "";
		document.getElementById("password").value = "";
	}
</script>
</html>