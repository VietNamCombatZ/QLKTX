-- ============================================================
-- QLKTX (Quản Lý Ký Túc Xá) - Dormitory Management System
-- MySQL Database Schema
-- Generated based on complete project analysis
-- ============================================================
-- Project structure analyzed:
-- - model.bean: User, Room, Contract, U_R_Record
-- - model.dao: CheckLoginDAO, UserDAO, RoomDAO, ContractDAO, U_R_RecordDAO
-- - model.dto: ContractDTO, RoomDTO, RoomRecordDTO
-- ============================================================

DROP DATABASE IF EXISTS qlktx;
CREATE DATABASE qlktx CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE qlktx;

-- ============================================================
-- Table: user
-- Description: Stores user/tenant information with login credentials
-- Used by: CheckLoginDAO, UserDAO
-- ============================================================
CREATE TABLE `user` (
  `id` VARCHAR(50) NOT NULL PRIMARY KEY COMMENT 'User ID (maps to user_id in Java beans)',
  `username` VARCHAR(100) UNIQUE COMMENT 'Login username',
  `password` VARCHAR(255) NOT NULL COMMENT 'User password (plain text in current implementation)',
  `firstname` VARCHAR(100) COMMENT 'First name',
  `lastname` VARCHAR(100) COMMENT 'Last name',
  `phonenumber` VARCHAR(20) COMMENT 'Phone number',
  `cccd` VARCHAR(30) COMMENT 'Citizen ID number (Căn cước công dân)',
  `gender` TINYINT(1) DEFAULT 0 COMMENT '0=Female, 1=Male (maps to boolean male in Java)',
  INDEX idx_username (`username`),
  INDEX idx_cccd (`cccd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User/Tenant information table';

-- ============================================================
-- Table: room
-- Description: Stores dormitory room information
-- Used by: RoomDAO
-- ============================================================
CREATE TABLE `room` (
  `room_id` VARCHAR(50) NOT NULL PRIMARY KEY COMMENT 'Room identifier',
  `type` VARCHAR(50) COMMENT 'Room type (Single, Double, etc.)',
  `capacity` INT COMMENT 'Maximum number of occupants',
  `price` VARCHAR(50) COMMENT 'Room rental price (stored as string in current implementation)',
  INDEX idx_type (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Dormitory room information';

-- ============================================================
-- Table: contract
-- Description: Stores rental contracts between users and rooms
-- Used by: ContractDAO
-- ============================================================
CREATE TABLE `contract` (
  `contract_id` VARCHAR(50) NOT NULL PRIMARY KEY COMMENT 'Contract identifier',
  `user_id` VARCHAR(50) NOT NULL COMMENT 'References user.id',
  `room_id` VARCHAR(50) NOT NULL COMMENT 'References room.room_id',
  `duration` INT COMMENT 'Contract duration in months',
  `start` DATE COMMENT 'Contract start date',
  `end` DATE COMMENT 'Contract end date',
  `state` VARCHAR(50) COMMENT 'Contract state (active, pending, expired, etc.)',
  CONSTRAINT `fk_contract_user` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_contract_room` FOREIGN KEY (`room_id`) REFERENCES `room`(`room_id`) 
    ON DELETE RESTRICT ON UPDATE CASCADE,
  INDEX idx_user_id (`user_id`),
  INDEX idx_room_id (`room_id`),
  INDEX idx_state (`state`),
  INDEX idx_dates (`start`, `end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rental contract information';

-- ============================================================
-- Table: user_room_record
-- Description: Monthly payment records for utilities and services
-- Used by: U_R_RecordDAO
-- ============================================================
CREATE TABLE `user_room_record` (
  `room_id` VARCHAR(50) NOT NULL COMMENT 'References room.room_id',
  `user_id` VARCHAR(50) NOT NULL COMMENT 'References user.id',
  `month` INT NOT NULL COMMENT 'Payment month (1-12)',
  `year` INT NOT NULL COMMENT 'Payment year',
  `room` TINYINT(1) DEFAULT 0 COMMENT 'Room fee paid (0=unpaid, 1=paid)',
  `electric` TINYINT(1) DEFAULT 0 COMMENT 'Electric bill paid (0=unpaid, 1=paid)',
  `water` TINYINT(1) DEFAULT 0 COMMENT 'Water bill paid (0=unpaid, 1=paid)',
  `wifi` TINYINT(1) DEFAULT 0 COMMENT 'WiFi fee paid (0=unpaid, 1=paid)',
  PRIMARY KEY (`room_id`, `user_id`, `month`, `year`),
  CONSTRAINT `fk_record_user` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_record_room` FOREIGN KEY (`room_id`) REFERENCES `room`(`room_id`) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX idx_period (`year`, `month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Monthly utility payment records';

-- ============================================================
-- Sample Data
-- ============================================================
START TRANSACTION;

-- Admin user (id='0000000000' is filtered in getAllUser queries)
INSERT INTO `user` (`id`, `username`, `password`, `firstname`, `lastname`, `phonenumber`, `cccd`, `gender`) VALUES
('0000000000', 'admin', 'admin123', 'Admin', 'System', '0000000000', '000000000000', 1);

-- Sample regular users
INSERT INTO `user` (`id`, `username`, `password`, `firstname`, `lastname`, `phonenumber`, `cccd`, `gender`) VALUES
('U001', 'nguyenvana', 'password123', 'Văn A', 'Nguyễn', '0123456789', '012345678901', 1),
('U002', 'tranthib', 'pass456', 'Thị B', 'Trần', '0987654321', '098765432109', 0),
('U003', 'levanc', 'mypass789', 'Văn C', 'Lê', '0912345678', '091234567890', 1);

-- Sample rooms
INSERT INTO `room` (`room_id`, `type`, `capacity`, `price`) VALUES
('R101', 'Single', 1, '1500000'),
('R102', 'Single', 1, '1500000'),
('R201', 'Double', 2, '2500000'),
('R202', 'Double', 2, '2500000'),
('R301', 'Quad', 4, '4000000');

-- Sample contracts
INSERT INTO `contract` (`contract_id`, `user_id`, `room_id`, `duration`, `start`, `end`, `state`) VALUES
('C001', 'U001', 'R101', 12, '2024-01-01', '2024-12-31', 'Đang thuê'),
('C002', 'U002', 'R201', 6, '2024-06-01', '2024-11-30', 'Đang thuê'),
('C003', 'U003', 'R102', 3, '2024-09-01', '2024-11-30', 'Chờ phê duyệt');

-- Sample payment records
INSERT INTO `user_room_record` (`room_id`, `user_id`, `month`, `year`, `room`, `electric`, `water`, `wifi`) VALUES
('R101', 'U001', 1, 2024, 1, 1, 1, 1),
('R101', 'U001', 2, 2024, 1, 1, 1, 1),
('R101', 'U001', 3, 2024, 1, 0, 1, 1),
('R201', 'U002', 6, 2024, 1, 1, 1, 0),
('R201', 'U002', 7, 2024, 1, 1, 0, 1),
('R102', 'U003', 9, 2024, 0, 0, 0, 0);

COMMIT;

-- ============================================================
-- End of Schema
-- ============================================================
-- Notes:
-- 1. Table names match exactly what's used in DAO SQL queries:
--    - `user` (not `users`)
--    - `room` (not `rooms`)
--    - `contract` (not `contracts`)
--    - `user_room_record` (not `user_room_records`)
-- 2. Column names match exactly what's used in ResultSet.getString() calls:
--    - user.id (not user_id)
--    - contract.start and contract.end (not start_date/end_date)
--    - user_room_record.room (not room_fee)
-- 3. The 'price' field is VARCHAR to match Java implementation (Room.price is String)
-- 4. Admin user with id='0000000000' is filtered out in UserDAO.getAllUser()
-- 5. Foreign keys ensure referential integrity between tables
-- 6. All boolean fields use TINYINT(1) as per MySQL convention
-- 7. Database name is lowercase 'qlktx' (not 'QLKTX')
-- ============================================================
