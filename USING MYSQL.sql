Create database hr_analytics ;
Use hr_analytics ;
alter table hr_table2 
rename column `Employee ID`  to EmployeeID;

-- Q.1 Average Attrition rate for all Departments
select Department,
concat(round
         (avg(case when Attrition = "Yes" then 1 else 0 end)*100,1),'%'
	  )as avg_attrition_percentage,
case
    WHEN sum(case when attrition="Yes"then 1 else 0 end)*100/count(*)<=50 THEN '✅ Good'
    WHEN sum(case when attrition="Yes" then 1 else 0 end)*100/count(*) between 50.5 and 51 THEN '⚠ Watch'
    else '❌ High'
end as KPI_status
from hr_table1
group by Department
order by Department asc;



-- Q.2 Average hourly rate of male research scientist
SELECT Gender , JobRole ,format(avg(HourlyRate),2) as "Average of Hourly Rate" 
FROM hr_table1
where Gender = "Male" and JobRole = "Research Scientist"
group by Gender , JobRole;



-- Q.3 Attrition rate Vs Monthly income stats of all departments
SELECT a.Department,
    concat(ROUND(AVG(CASE WHEN a.Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2)," %") AS AttritionRate,
    ROUND(AVG(b.MonthlyIncome), 2) AS AvgMonthlyIncome
FROM hr_table1 as a inner join hr_table2 as b 
on b.EmployeeID=a.EmployeeNumber  
GROUP BY a.Department
order by a.Department;


-- Q.4 Average working years for each Department
select a.department, format(avg(b.TotalWorkingYears),2) as Average_Working_Year
from hr_table1 as a
inner join hr_table2 as b on b.EmployeeID=a.EmployeeNumber
group by a.department
order by a.department;



-- Q.5 Job Role Vs Work life balance
select a.jobrole, format(avg(b.worklifebalance),3) as Work_Life_balance
from hr_table1 as a
inner join hr_table2 as b on b.EmployeeID=a.EmployeeNumber
group by a.jobrole
order by Work_Life_balance  desc;



-- 6) Attrition rate Vs Year since last promotion relation
select yearssincelastpromotion,
concat(round
        (avg(case when Attrition = "Yes" then 1 else 0 end)*100,1),'%'
	   )as avg_attrition_percentage,
case
    WHEN sum(case when attrition="Yes"then 1 else 0 end)*100/count(*)<40 THEN '✅ LOW'
    WHEN sum(case when attrition="Yes" then 1 else 0 end)*100/count(*) between 40 and 50 THEN '⚠MEDIUM '
    else '❌ High'
end as KPI_status
from hr_table1 as a
inner join hr_table2 as b on b.EmployeeID=a.EmployeeNumber
group by yearssincelastpromotion
order by yearssincelastpromotion asc;
