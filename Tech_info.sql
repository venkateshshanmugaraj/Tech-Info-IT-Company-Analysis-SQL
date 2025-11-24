create database Tech_Info;
use Tech_Info;
drop database Tech_Info;

select * from tech_info_employees;

select * from tech_info_projects;

select * from tech_info_timesheet;

-- List all employees in the Development department
select EmployeeID, name, Department
from tech_info_employees
where Department = 'Development';

-- Show task types that are still In Progress
select EmployeeID, TaskType, Status
from tech_info_timesheet
where Status = 'In Progress';

-- Find employees who joined before 2021
select EmployeeID, name, JoiningDate
from tech_info_employees
where JoiningDate < '2021-01-01';

-- Show each employee with the projects they are working on
select e.EmployeeID, e.name, p.ProjectName, t.HoursWorked
from tech_info_employees e
join tech_info_timesheet t on e.EmployeeID = t.EmployeeID
join tech_info_projects p on t.ProjectID = p.ProjectID;

-- Find employees who worked more than 40 hours last week
select e.EmployeeID, e.name, sum(t.HoursWorked) as TotalHours
from tech_info_employees e
join tech_info_timesheet t on e.EmployeeID = t.EmployeeID
where t.date between '2025-09-15' and '2025-09-21'
group by e.EmployeeID, e.name
having sum(t.HoursWorked) > 40;


-- Total hours worked by each employee
select e.EmployeeID, e.name, sum(t.HoursWorked) as TotalHours
from tech_info_employees e
join tech_info_timesheet t on e.EmployeeID = t.EmployeeID
group by e.EmployeeID, e.name;

-- Total project cost (assuming salary per hour = Salary/160 per month)
select p.ProjectName,
       sum((e.Salary / 160) * t.HoursWorked) as ActualCost
from tech_info_projects p
join tech_info_timesheet t on p.ProjectID = t.ProjectID
join tech_info_employees e on t.EmployeeID = e.EmployeeID
group by p.ProjectName;

-- Average salary per department
select Department, avg(Salary) as AvgSalary
from tech_info_employees
group by Department;

-- Find the employee(s) with the highest number of hours logged
select e.EmployeeID, e.name, TotalHours
from (
    select EmployeeID, sum(HoursWorked) as TotalHours
    from tech_info_timeSheet
    group by EmployeeID
) as HoursSummary
join tech_info_employees e on HoursSummary.EmployeeID = e.EmployeeID
where TotalHours = (
    select max(TotalHours)
    from (
        select sum(HoursWorked) as TotalHours
        from tech_info_timeSheet
        group by EmployeeID
    ) as InnerSummary);

-- Find projects where the total logged hours exceed 500
select p.ProjectID, p.ProjectName
from tech_info_projects p
where p.ProjectID in (
    select ProjectID
    from tech_info_timeSheet
    group by ProjectID
    having sum(HoursWorked) > 500);

-- Rank employees by total hours worked
select e.EmployeeID, e.name,
       sum(t.HoursWorked) as TotalHours,
       rank() over (order by sum(t.HoursWorked) desc) as WorkRank
from tech_info_employees e
join tech_info_timeSheet t on e.EmployeeID = t.EmployeeID
group by e.EmployeeID, e.name;

-- Top 3 employees per department by salary
select *
from (
    select EmployeeID, name, Department, Salary,
           rank() over (partition by Department order by Salary desc) as DeptRank
    from tech_info_employees
) t
where DeptRank <= 3;

-- Create a view: Employee Utilization Report
create view EmployeeUtilization as
select e.EmployeeID, e.Name, e.Department,
       sum(t.HoursWorked) as TotalHours,
       count(distinct t.ProjectID) as ProjectCount
from tech_info_employees e
join tech_info_timeSheet t on e.EmployeeID = t.EmployeeID
group by e.EmployeeID, e.Name, e.Department;

drop view if exists EmployeeUtilization;


-- Example Stored Procedure: Project Report
DELIMITER //

create procedure GetProjectReport (in ProjectName varchar(100))
BEGIN
    select p.ProjectName, e.Name, sum(t.HoursWorked) as TotalHours, p.Status
    from tech_info_projects p
    join tech_info_timeSheet t on p.ProjectID = t.ProjectID
    join tech_info_employees e on t.EmployeeID = e.EmployeeID
    where p.ProjectName = ProjectName
    group by p.ProjectName, e.Name, p.Status;
END //

DELIMITER ;


-- Find underutilized employees (less than 20 hours last week)
select e.EmployeeID, e.name, sum(t.HoursWorked) as WeeklyHours
from tech_info_employees e
join tech_info_timeSheet t on e.EmployeeID = t.EmployeeID
where t.Date between '2025-09-15' and '2025-09-21'
group by e.EmployeeID, e.name
having sum(t.HoursWorked) < 20;

-- Compare budget vs actual cost
select p.ProjectName, p.Budget,
       sum((e.Salary/160) * t.HoursWorked) as ActualCost,
       (p.Budget - sum((e.Salary/160) * t.HoursWorked)) as Difference
from tech_info_projects p
join tech_info_timeSheet t on p.ProjectID = t.ProjectID
join tech_info_employees e on t.EmployeeID = e.EmployeeID
group by p.ProjectName, p.Budget;

-- Monthly timesheet trend (hours worked per department)
select e.Department, year(t.Date) as year, month(t.Date) as month,
       sum(t.HoursWorked) AS TotalHours
from tech_info_employees e
join tech_info_timeSheet t on e.EmployeeID = t.EmployeeID
group by e.Department, year(t.Date), month(t.Date)
order by Year, Month;
