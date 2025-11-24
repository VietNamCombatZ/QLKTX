<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết hợp đồng</title>
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

        input[type="text"] {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 5px;
        }

        input[type="submit"],
        input[type="reset"],
        .back-button {
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

        input[type="submit"] {
            background-color: rgb(243, 158, 1);
        }

        input[type="submit"]:hover{
            background-color: rgb(198, 130, 3)
        }
        .back-button:hover {
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

        input[type="text"]:focus,
        select:focus {
            border-color: #007bff;
            outline: none;
        }

        @media (max-width: 600px) {
            h2 {
                font-size: 1.5rem;
            }

            input[type="submit"],
            .back-button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<a href="showAllContract.jsp" class="back-button">← Back</a>
    <div class="form-container">
        <h2>Chi tiết hợp đồng</h2>
        <form action="" method="">
            <table>
                <tr>
                    <td><label for="hoten">Họ tên</label></td>
                    <td><input type="text" name="hoten" id="hoten" value="Trần Văn An" required readonly/></td>
                    <td><label for="gioitinh">Giới tính</label></td>
                    <td><input type="text" name="gioitinh" value="Nam" required readonly/></td>
                </tr>
                <tr>
                    <td><label for="ngaysinh">Ngày sinh</label></td>
                    <td><input type="text" name="ngaysinh" value="04/09/2004" required readonly/></td>
                </tr>
                <tr>
                    <td><label for="sdt">Số điện thoại</label></td>
                    <td><input type="text" name="sdt" value="0123456789" required readonly/></td>
                    <td><label for="cccd">CCCD</label></td>
                    <td><input type="text" name="cccd" value="04825374823940" required readonly/></td>
                </tr>
                <tr>
                    <td><label for="thoigian">Thời gian thuê</label></td>
                    <td><input type="text" name="thoigian" value="3 tháng" required readonly/></td>
                </tr>
                <tr>
                    <td><label for="from">Từ</label></td>
                    <td><input type="text" name="from" value="01/11/2024" required readonly/></td>
                    <td><label for="to">Đến</label></td>
                    <td><input type="text" name="to" value="31/01/2025" required readonly/></td>
                </tr>
                <tr>
                    <td><label for="trangthai">Trạng thái</label></td>
                    <td><input type="text" name="trangthai" value="Đang thuê" required readonly/></td>
                </tr>
                <tr>
                    <td colspan="4"><input type="submit" value="Phê duyệt" /></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>