-- HostelDB Setup Script
-- Run this in MySQL before starting the application
-- Usage: mysql -u root -p < HostelDB.sql

CREATE DATABASE IF NOT EXISTS HostelDB;
USE HostelDB;

-- ============================================================
-- WARDEN (login credentials for the app)
-- ============================================================
CREATE TABLE IF NOT EXISTS warden (
    warden_id   INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(100) NOT NULL UNIQUE,
    password    VARCHAR(100) NOT NULL
);

-- ============================================================
-- STUDENTS
-- ============================================================
CREATE TABLE IF NOT EXISTS Students (
    student_id  INT AUTO_INCREMENT PRIMARY KEY,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    gender      VARCHAR(10),
    DOB         DATE,
    department  VARCHAR(100),
    contact_no  VARCHAR(20),
    email       VARCHAR(100),
    CNIC        VARCHAR(20),
    City        VARCHAR(50),
    Address     VARCHAR(200)
);

-- ============================================================
-- GUARDIAN (linked to a student)
-- ============================================================
CREATE TABLE IF NOT EXISTS Guardian (
    g_id        INT AUTO_INCREMENT PRIMARY KEY,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    relation    VARCHAR(50),
    contact     VARCHAR(20),
    email       VARCHAR(100),
    CNIC        VARCHAR(20),
    student_id  INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- ============================================================
-- HOSTEL ROOMS
-- ============================================================
CREATE TABLE IF NOT EXISTS HostelRooms (
    room_id         INT AUTO_INCREMENT PRIMARY KEY,
    room_no         VARCHAR(20),
    room_type       VARCHAR(50),
    capacity        INT,
    occupied        INT DEFAULT 0,
    allotion_date   DATE,
    leave_date      DATE
);

-- ============================================================
-- ROOM ALLOTMENT (maps students to rooms)
-- ============================================================
CREATE TABLE IF NOT EXISTS RoomAllotment (
    allotment_id    INT AUTO_INCREMENT PRIMARY KEY,
    student_id      INT,
    room_id         INT,
    allotment_date  DATE,
    leave_date      DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (room_id) REFERENCES HostelRooms(room_id)
);

-- ============================================================
-- VISITORS (linked to students)
-- ============================================================
CREATE TABLE IF NOT EXISTS visitors (
    visitor_id   INT AUTO_INCREMENT PRIMARY KEY,
    student_id   INT,
    visitor_name VARCHAR(100),
    relation     VARCHAR(50),
    visit_date   DATE,
    contact_no   VARCHAR(20),
    CNIC         VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- ============================================================
-- DEFAULT WARDEN LOGIN
-- Change this password after first login!
-- ============================================================
INSERT IGNORE INTO warden (username, password) VALUES ('admin', 'admin123');

-- ============================================================
-- SAMPLE ROOMS (optional - remove if adding rooms via the app)
-- ============================================================
INSERT IGNORE INTO HostelRooms (room_no, room_type, capacity, occupied) VALUES
('101', 'Single', 1, 0),
('102', 'Double', 2, 0),
('103', 'Double', 2, 0),
('104', 'Triple', 3, 0),
('105', 'Triple', 3, 0);