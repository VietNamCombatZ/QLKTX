<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.bean.*"%>
<%@page import="model.dto.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xóa phòng</title>
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
	border-spacing: 25px 5px;
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

input[type="submit"], .back-button {
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

input[type="submit"]:hover {
	background-color: #2a6c81;
}

td:last-child {
	text-align: left;
}

td[colspan="2"] {
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
	input[type="submit"], .back-button {
		width: 100%;
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
	<a href="<%= request.getContextPath() %>/RoomController?action=viewallroom&month=<%=month%>&year=<%=year%>" class="back-button">← Back</a>
    <div class="form-container">
        <h2>Xóa phòng</h2>
        <form action="RoomController?action=deleteroomhandle" method="post" onsubmit="return validateForm()">
            <%
        		Room room = (Room) request.getAttribute("room");
        	%>
            <table>
                <tr>
                    <td><label for="sophong">Số phòng</label></td>
                    <td><input type="text" name="roomid" id="sophong" value="<%=room.getRoom_id()%>" required readonly /></td>
                </tr>
                <tr>
                    <td><label for="loaiphong">Loại phòng</label></td>
                    <td>
                        <select name="" id="loaiphong" required disabled>
                        	<%
                        		if(room.getType().equals("Nam"))
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
                        <input type="hidden" name="type" value="<%=room.getType()%>" />
                    </td>
                </tr>
                <tr>
                    <td><label for="succhua">Sức chứa</label></td>
                    <td>
                        <select name="" id="succhua" required disabled>
                        	<%
                        		if(room.getCapacity() == 4)
                        		{
                        	%>
	                            <option value="4" selected>4</option>
	                            <option value="6">6</option>
	                            <option value="8">8</option>
                            <%
                        		} else if(room.getCapacity() == 6) {
                        			
                            %>
                          		<option value="4">4</option>
	                            <option value="6" selected>6</option>
	                            <option value="8">8</option>
                            <%
                        		} else {
                            %>
	                            <option value="4">4</option>
	                            <option value="6">6</option>
	                            <option value="8" selected>8</option>
                            <%
                        		}
                            %>
                        </select>
                        <input type="hidden" name="capacity" value="<%=room.getCapacity()%>" />
                    </td>
                </tr>
                <tr>
                    <td><label for="gia">Giá</label></td>
                    <td><input type="text" name="price" id="gia" value="<%=room.getPrice()%>" required /></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Xóa" /></td>
                </tr>
            </table>
        </form>
        
    </div>
</body>
</html>