-- QLKTX MySQL schema and sample data
-- Generated from model.bean Java classes
-- Assumptions:
-- 1) Java String ids map to VARCHAR(50) primary keys.
-- 2) Java Date -> DATE, int -> INT, boolean -> TINYINT(1).
-- 3) Room.price was a String in code; here we store as DECIMAL(10,2).
-- 4) Adjust sizes/types as needed for your data.

DROP DATABASE IF EXISTS QLKTX;
CREATE DATABASE QLKTX CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE QLKTX;

-- Users table (from model.bean.User)
CREATE TABLE users (
  user_id VARCHAR(50) NOT NULL PRIMARY KEY,
  username VARCHAR(100) UNIQUE,
  password VARCHAR(255) NOT NULL,
  firstname VARCHAR(100),
  lastname VARCHAR(100),
  phonenumber VARCHAR(20),
  cccd VARCHAR(30),
  male TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Rooms table (from model.bean.Room)
CREATE TABLE rooms (
  room_id VARCHAR(50) NOT NULL PRIMARY KEY,
  type VARCHAR(50),
  capacity INT,
  price DECIMAL(10,2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Contracts table (from model.bean.Contract)
CREATE TABLE contracts (
  contract_id VARCHAR(50) NOT NULL PRIMARY KEY,
  user_id VARCHAR(50) NOT NULL,
  room_id VARCHAR(50) NOT NULL,
  duration INT,
  start_date DATE,
  end_date DATE,
  state VARCHAR(50),
  CONSTRAINT fk_contract_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_contract_room FOREIGN KEY (room_id) REFERENCES rooms(room_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- User-Room monthly record (from model.bean.U_R_Record)
CREATE TABLE u_r_records (
  room_id VARCHAR(50) NOT NULL,
  user_id VARCHAR(50) NOT NULL,
  month INT NOT NULL,
  year INT NOT NULL,
  room_fee TINYINT(1) DEFAULT 0,
  electric TINYINT(1) DEFAULT 0,
  water TINYINT(1) DEFAULT 0,
  wifi TINYINT(1) DEFAULT 0,
  PRIMARY KEY (room_id, user_id, month, year),
  CONSTRAINT fk_ur_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_ur_room FOREIGN KEY (room_id) REFERENCES rooms(room_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Sample data
START TRANSACTION;

INSERT INTO users (user_id, username, password, firstname, lastname, phonenumber, cccd, male) VALUES
('U001','admin','12341234','Huy','Nguyễn','0123456789','012345678901',1),
('U002','user01','123456','Dũng','Trần','0987654321','098765432109',0),
('U003','user02','123456','Anh','Võ','0112233445','112233445566',1);

INSERT INTO rooms (room_id, type, capacity, price) VALUES
('R001','Nam',4,500000),
('R002','Nữ',6,250000);

INSERT INTO contracts (contract_id, user_id, room_id, duration, start_date, end_date, state) VALUES
('C001','U001','R001',12,'2024-01-01','2024-12-31','Đang thuê'),
('C002','U002','R002',6,'2024-06-01','2024-11-30','Chờ phê duyệt');

INSERT INTO u_r_records (room_id, user_id, month, year, room_fee, electric, water, wifi) VALUES
('R001','U001',1,2024,1,1,1,1),
('R001','U001',2,2024,1,1,1,1),
('R002','U002',6,2024,1,1,1,0);

COMMIT;

-- End of schema
