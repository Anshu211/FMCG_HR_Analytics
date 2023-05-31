
-- Employee demographics and distribution:

-- 1.Employee distribution by city 
SELECT City, COUNT(*) AS NumEmployees 
FROM emp_details 
GROUP BY City 
ORDER BY NumEmployees DESC;

-- 2.Employee Count By Department and Demography:
SELECT Department, Sex, COUNT(*) AS NumEmployees
FROM emp_details
GROUP BY Department, Sex 
Order By Department, Sex;


-- Compensation and benefits analysis:

-- 1.Salary disparity analysis by gender
select department,sex,  avg(salary)
from emp_details
group by department,sex order by department;

-- 2.Average Salary by City and Department:
SELECT Department, City, AVG(Salary) AS AvgSalary
FROM emp_details
GROUP BY Department, City
Order by City;

-- 3.Average, Minimum and Maximum Salary Department Wise
SELECT Department, AVG(Salary) AS AverageSalary, MIN(Salary) AS MinimumSalary, MAX(Salary) AS MaximumSalary
FROM emp_details
GROUP BY Department, Emp_name;


-- 4.Average salary plus highest and lowest salaried employee by Location
SELECT  e.City, AVG(e.Salary) AS AverageSalary, 
 MIN(e.Salary) AS MinimumSalary, (SELECT Emp_name   FROM emp_details WHERE City = e.City ORDER BY Salary DESC LIMIT 1) AS HighestPaidEmployee, MAX(e.Salary) AS MaximumSalary, (SELECT Emp_name FROM emp_details WHERE City= e.City ORDER BY Salary ASC LIMIT 1) AS LowestPaidEmployee
FROM emp_details e where Department != 'Executive Leardership'
GROUP BY e.City;


-- Performance analysis: 

-- 1.Average performance rating by department and gender
select department, sex,
avg(ep.performance_rating) as avg_rating
from emp_performance ep inner join emp_details as ed
on ep.emp_id = ed.emp_id
group by department, sex;

-- 2.Departments with the highest number of employees who have completed projects with a completion rate above 90%
SELECT Department, COUNT(*) AS NumEmployees
FROM emp_details ed
INNER JOIN emp_performance ep
ON ed.Emp_id = ep.Emp_id
WHERE Project_Completion_Rate > 0.9
GROUP BY Department
ORDER BY NumEmployees DESC;

-- 3.Correlation between Service Period and salary on the basis of department and gender
SELECT department,sex, count(*) as emp_count,sum(salary) total_salary, 
       sum(((Current_date - Doj)/365)) as total_serviceyear, 
	   CORR(((Current_date - Doj)/365), Salary) AS CorrelationCoefficient
FROM emp_details 
where department != 'Upper Management'
group by department, sex;



-- 4.Creating a Efficiency Parameter from the employee performance table to get a complete idea 
select ep.emp_id, emp_name, salary, department,sex, 
	   ((performance_rating/10)+project_completion_rate) as  
	    perf_parameter
from emp_performance as ep left join emp_details as ed
on ep.emp_id = ed.emp_id ORDER BY perf_parameter desc;


-- Employee turnover analysis

-- 1.Years with the company
select emp_id, Emp_name, 
	   ceil((Current_date - Doj)/365) as Service_Period  
from emp_details; 

-- 2.Total of employees in each department and who have been with the organization for more than 5 years

SELECT Department, COUNT(*) AS TotalEmployees, 
       sum(CASE WHEN DOJ <= CURRENT_DATE - INTERVAL '5 years' THEN 1 ELSE 0 END) 
	      AS TotalEmployees5YearsAndOlder
FROM emp_details
GROUP BY Department;







