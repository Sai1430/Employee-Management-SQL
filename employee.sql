CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Create the Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10, 2),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(200),
    City VARCHAR(50),
    Country VARCHAR(50),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create the Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

-- Create the EmployeeProjects table to represent the many-to-many relationship
CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    AssignmentDate DATE,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

INSERTING SAMPLE DATA

-- Insert data into Departments table
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES 
(1, 'HR'),
(2, 'Engineering'),
(3, 'Sales'),
(4, 'Marketing');

-- Insert data into Employees table
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, HireDate, Salary, Email, Phone, Address, City, Country)
VALUES 
(1, 'Alice', 'Johnson', 2, '2020-01-15', 75000, 'alice.johnson@example.com', '1234567890', '123 Maple St', 'New York', 'USA'),
(2, 'Bob', 'Smith', 1, '2019-03-22', 55000, 'bob.smith@example.com', '0987654321', '456 Pine St', 'Los Angeles', 'USA'),
(3, 'Charlie', 'Brown', 3, '2021-07-30', 60000, 'charlie.brown@example.com', '2345678901', '789 Oak St', 'Chicago', 'USA'),
(4, 'Diana', 'Prince', 4, '2018-11-11', 68000, 'diana.prince@example.com', '3456789012', '101 Birch St', 'Houston', 'USA');

-- Insert data into Projects table
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate)
VALUES 
(1, 'Project Apollo', '2023-01-01', '2023-12-31'),
(2, 'Project Zeus', '2023-06-01', '2024-06-01'),
(3, 'Project Hera', '2023-03-01', '2023-09-01');

-- Insert data into EmployeeProjects table
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, AssignmentDate)
VALUES 
(1, 1, '2024-01-15'),
(2, 2, '2024-06-15'),
(3, 3, '2024-03-15'),
(4, 1, '2024-02-01'),
(1, 2, '2024-07-01');

SAMPLE QUERIES

-- Query to get employee details along with their department
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName,
    e.HireDate,
    e.Salary
FROM 
    Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Query to get the projects an employee is assigned to
SELECT 
    e.FirstName,
    e.LastName,
    p.ProjectName,
    ep.AssignmentDate
FROM 
    Employees e
    JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
    JOIN Projects p ON ep.ProjectID = p.ProjectID
WHERE 
    e.EmployeeID = 1;

-- Query to get the total salary expenditure by department
SELECT 
    d.DepartmentName,
    SUM(e.Salary) AS TotalSalaryExpenditure
FROM 
    Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY 
    d.DepartmentName;

-- Query to find employees who are not assigned to any projects
SELECT 
    e.FirstName,
    e.LastName
FROM 
    Employees e
LEFT JOIN 
    EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
WHERE 
    ep.ProjectID IS NULL;

-- Query to get all projects along with the employees assigned to each project
SELECT 
    p.ProjectName,
    e.FirstName,
    e.LastName
FROM 
    Projects p
LEFT JOIN 
    EmployeeProjects ep ON p.ProjectID = ep.ProjectID
LEFT JOIN 
    Employees e ON ep.EmployeeID = e.EmployeeID
ORDER BY 
    p.ProjectName;

ADDING INDEXES

-- Add index on DepartmentID in Employees table
CREATE INDEX idx_employees_department_id ON Employees(DepartmentID);

-- Add index on ProjectID in EmployeeProjects table
CREATE INDEX idx_employeeprojects_project_id ON EmployeeProjects(ProjectID);

-- Add index on EmployeeID in EmployeeProjects table
CREATE INDEX idx_employeeprojects_employee_id ON EmployeeProjects(EmployeeID);


