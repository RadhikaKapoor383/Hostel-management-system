# 🏨 Hostel Management System

A desktop-based Hostel Management System built with **Java Swing** and **MySQL**. Designed for hostel wardens to manage students, rooms, guardians, and visitor records through a GUI interface built in NetBeans.

---

## 📁 Recommended Folder Structure

The current repo has all files dumped in the root directory. Here's how it should be reorganized for clarity:

```
Hostel-management-system/
├── src/
│   └── hostelmanagementsystem/        ← All .java source files go here
│       ├── HostelManagementSystem.java  (main entry point)
│       ├── firstPage.java
│       ├── Hostel.java
│       ├── MainMenu.java
│       ├── registration.java
│       ├── guardian.java
│       ├── manageStudents.java
│       ├── manageGuardian.java
│       ├── EditStudent.java
│       ├── EditGuardian.java
│       ├── RoomAllot.java
│       ├── RoomDeAllot.java
│       ├── roomAvailable.java
│       ├── roomManage.java
│       ├── ViewProfile.java
│       ├── newVisitor.java
│       ├── visitorRecord.java
│       └── EditVisitor.java
├── forms/                             ← All .form (NetBeans GUI designer) files
│   ├── firstPage.form
│   ├── Hostel.form
│   ├── MainMenu.form
│   └── ... (all other .form files)
├── resources/
│   └── hostelmanagementsystem/
│       └── image.png                  ← App background image
├── database/
│   └── HostelDB.sql                   ← SQL setup script (see below)
├── lib/
│   └── mysql-connector-j-x.x.x.jar   ← MySQL JDBC driver (download separately)
└── README.md
```

> **Note:** In NetBeans, `.form` files must stay alongside their `.java` counterparts in the same source package folder for the GUI builder to work. The folder structure above is the logical/recommended layout — in your actual NetBeans project, keep `.java` and `.form` pairs together inside `src/hostelmanagementsystem/`.

---

## ✨ Features

| Module | Description |
|---|---|
| **Login** | Warden authentication against MySQL `warden` table |
| **Student Registration** | Add new students with full personal details |
| **Manage Students** | View, search, and edit student records |
| **Guardian Management** | Add and edit guardian/emergency contact info |
| **Room Management** | View room availability, capacity, and occupancy |
| **Room Allotment** | Assign rooms to students |
| **Room De-allotment** | Release a student from their assigned room |
| **Visitor Records** | Log and manage visitor entries linked to students |
| **View Profile** | View full student profile including room and guardian |

---

## 🛠️ Prerequisites

Before setting up, make sure you have installed:

- **Java JDK 8 or higher** — [Download](https://www.oracle.com/java/technologies/downloads/)
- **Apache NetBeans IDE** — [Download](https://netbeans.apache.org/front/main/download/) *(recommended for .form GUI files)*
- **MySQL Server 8.x** — [Download](https://dev.mysql.com/downloads/mysql/)
- **MySQL Connector/J (JDBC Driver)** — [Download](https://dev.mysql.com/downloads/connector/j/)

---

## 🗄️ Database Setup

### Step 1 — Start MySQL and open a client (MySQL Workbench or command line)

```sql
mysql -u root -p
```

### Step 2 — Create the database and tables

Run the following SQL script (also saved as `database/HostelDB.sql`):

```sql
CREATE DATABASE IF NOT EXISTS HostelDB;
USE HostelDB;

-- Warden (login credentials)
CREATE TABLE IF NOT EXISTS warden (
    warden_id   INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(100) NOT NULL UNIQUE,
    password    VARCHAR(100) NOT NULL
);

-- Students
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

-- Guardian (linked to student)
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

-- Hostel Rooms
CREATE TABLE IF NOT EXISTS HostelRooms (
    room_id         INT AUTO_INCREMENT PRIMARY KEY,
    room_no         VARCHAR(20),
    room_type       VARCHAR(50),
    capacity        INT,
    occupied        INT DEFAULT 0,
    allotion_date   DATE,
    leave_date      DATE
);

-- Room Allotment (links students to rooms)
CREATE TABLE IF NOT EXISTS RoomAllotment (
    allotment_id    INT AUTO_INCREMENT PRIMARY KEY,
    student_id      INT,
    room_id         INT,
    allotment_date  DATE,
    leave_date      DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (room_id) REFERENCES HostelRooms(room_id)
);

-- Visitors
CREATE TABLE IF NOT EXISTS visitors (
    visitor_id  INT AUTO_INCREMENT PRIMARY KEY,
    student_id  INT,
    visitor_name VARCHAR(100),
    relation    VARCHAR(50),
    visit_date  DATE,
    contact_no  VARCHAR(20),
    CNIC        VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- Default warden login (change this password!)
INSERT INTO warden (username, password) VALUES ('admin', 'admin123');
```

---

## ⚙️ Project Setup in NetBeans

### Step 1 — Clone the repository

```bash
git clone https://github.com/RadhikaKapoor383/Hostel-management-system.git
```

### Step 2 — Open in NetBeans

1. Open **NetBeans IDE**
2. Go to **File → New Project → Java with Ant → Java Application**
3. Name the project `HostelManagementSystem` and set the package to `hostelmanagementsystem`
4. Copy all `.java` and `.form` files from the repo into `src/hostelmanagementsystem/`
5. Copy `image.png` into `src/hostelmanagementsystem/` (the code loads it from the package resources)

### Step 3 — Add the MySQL JDBC Driver

1. Download `mysql-connector-j-x.x.x.jar` from [MySQL](https://dev.mysql.com/downloads/connector/j/)
2. In NetBeans, right-click your project → **Properties → Libraries → Add JAR/Folder**
3. Select the downloaded `.jar` file

### Step 4 — Update database credentials

The database credentials are **hardcoded** in each Java file. Search for the following and update if your MySQL credentials differ:

```java
// Found in: Hostel.java, MainMenu.java, RoomAllot.java, EditStudent.java, etc.
String URL      = "jdbc:mysql://localhost:3306/HostelDB";
String username = "root";
String Password = "Radhika1@";   // ← Change this to your MySQL password
```

> 💡 **Tip for future improvement:** Move these credentials to a single `DBConnection.java` utility class so you only have to change them in one place.

### Step 5 — Run the project

In NetBeans, right-click the project → **Run**, or press `F6`.

The app will open the **SIBA Hostel Portal** welcome screen. Click **LOGIN** and enter your warden credentials.

---

## 🔑 Default Login

| Field | Value |
|---|---|
| Username | `admin` |
| Password | `admin123` |

*(Set when you run the SQL INSERT above — change it after first login)*

---

## 🐛 Common Issues

**`Communications link failure` / Cannot connect to MySQL**
- Make sure MySQL Server is running
- Verify the URL, username, and password in the Java files match your MySQL setup
- Check that the `HostelDB` database exists (`SHOW DATABASES;` in MySQL)

**`java.lang.ClassNotFoundException: com.mysql.cj.jdbc.Driver`**
- The MySQL JDBC connector `.jar` is missing from your project libraries (see Step 3 above)

**Images not loading / blank panel**
- Make sure `image.png` is placed inside `src/hostelmanagementsystem/` so it is found on the classpath

**`.form` files not opening in GUI designer**
- `.form` and `.java` files must be in the same folder. Do not separate them.

---

## 🚀 Suggested Improvements

- [ ] Centralize DB connection into a single `DBConnection.java` utility class
- [ ] Move credentials to a `config.properties` file (don't hardcode passwords)
- [ ] Add a `.gitignore` to exclude NetBeans project files (`nbproject/`, `build/`, `dist/`)
- [ ] Hash passwords in the `warden` table (currently stored in plaintext)
- [ ] Add input validation before SQL queries

---

## 👩‍💻 Author

Developed by **Radhika Kapoor** as a Java desktop project using NetBeans, Java Swing, and MySQL.
