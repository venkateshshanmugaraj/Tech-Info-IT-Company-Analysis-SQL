# 🗂️ Tech_Info SQL Project – Employee, Project & Timesheet Management

## 📌 Project Overview

This project focuses on building a complete SQL-based reporting and analysis system using the Tech_Info database. It covers employees, projects, departments, and timesheet records, enabling efficient data management, reporting, and performance analysis.

# 📂 Project Steps

# 1️⃣ Database Setup

  * Designed tables for **Employees, Departments, Projects, Tasks**, and **Timesheets**.

  * Ensured primary keys, foreign keys, and constraints for accurate data relationships.


# 2️⃣ Data Cleaning & Preparation

  * Removed duplicate employee entries.

  * Updated missing department or project values.

  * Standardized date formats and numeric columns.

  * Ensured referential integrity across the database.


# 3️⃣ Creating SQL Procedures & Queries

## Developed SQL scripts for efficient analysis, including:

  ### Employee-Related Reports

  * Total employees per department

  * Employee details with project assignments

  * Employee work hours summary

  * High-performing employees based on total hours

  ### Project-Related Reports

  * List of active and completed projects

  * Project progress tracking

  * Total hours worked per project

  * Employee allocation per project

  ### Timesheet Analysis

  * Daily/Monthly total hours

  * Employee utilization

  * Task-wise breakdown

  * Time spent by each employee per project

### 🔹 Stored Procedures

### Created stored procedures such as:

  * GetProjectReport – Fetch project-wise employee hours and status

  * GetEmployeeHours – Summary of hours worked by each employee

  * DepartmentSummary – Departmental headcount & workload


# 4️⃣ Performance Optimization

  * Added indexes on frequently searched fields (EmployeeID, ProjectID).

  * Used JOIN, GROUP BY, and CASE statements for complex reporting.

  * Improved stored procedure performance with optimized queries.


# 5️⃣ Output & Insights

### This SQL solution provides:

  * Clear visibility of project progress

  * Employee workload distribution

  * Department performance metrics

  * Accurate timesheet-based reporting

  * Better planning and resource allocation
