--select * from dept;

select * from employee;
-- emp_id , name, salary, department

select * from INCENTIVES;

--Display unique Department names from Employee table
SELECT DISTINCT DEPTNAME FROM Employee ;

--List the details of the employees in ascending order of their salaries.
SELECT * 
FROM Employee
ORDER BY SAL ASC;

-- print the number of employees per department in the organization
SELECT DEPTNAME, COUNT(DEPTNAME) AS Employees_count FROM   Employee GROUP  BY DEPTNAME;

--find the department with highest number of employees
select * from (select deptname, count(ename) from employee group by deptname order by count(ename) desc) where ROWNUM<=1;

--select the employees getting salary greater than the average salary of the department that are working in
select deptname, avg (sal) from employee e2 group by e2.deptname;
select * from employee e1 where  sal > ( select avg (sal) from employee e2 where e2.deptname = e1.deptname);





--List the employees who joined before 1981.
SELECT * 
FROM Employee
WHERE HIREDATE < '01-JAN-1981';



--find the name of the top level manager of each department
select ename, deptname from employee where mgr is null; 


--find the employee details who got second maximum incentive in Febrauary 2019
select * from employee where empno = (select empid from incentives where incentives.incentive_amount in 
(select max(incentive_amount) from incentives where TO_CHAR(incentive_date, 'MM-YYY')='02-2019'));
select * from (select * from employee e, incentives i where e.empno=i.empid and TO_CHAR(incentive_date, 'MM-YYYY')='02-2019' and i.incentive_amount < 
(select max (incentive_amount)from incentives where TO_CHAR(incentive_date, 'MM-YYYY')='02-2019')  order by i.incentive_amount desc) where ROWNUM <=1 ;

--find the employee who got minimum incentive in 2019
select * from employee e, incentives i where i.empid= e.empno 
and i.incentive_amount =( select min(incentive_amount) from incentives where TO_CHAR(incentive_date, 'YYYY')='2019'); 

-- find the employee who did not get any incentive in january 2019
select * from employee where empno not in (select empid from incentives where to_char(incentive_date, 'MM-YYYY') ='01-2019');

--find the month where Employees got Maximum incentive
SELECT EXTRACT(MONTH FROM INCENTIVE_DATE) MONTH FROM  INCENTIVES
WHERE INCENTIVE_AMOUNT=(SELECT MAX(INCENTIVE_AMOUNT) FROM INCENTIVES);




--list the employees and name of managers of each person
select e1.ename , (select e2.ename from employee e2 where e1.mgr = e2.empno) as manager from employee e1 ;

--list the employees and name of employees reporting to each person
select (select e2.ename from employee e2 where e2.empno = e.mgr) as manager, e.ename as employee from employee e ;


-- find the employees hired in last 12 months
select * from employee where to_char (hiredate,'MM-YY') > to_char (SYSDATE, 'MM-YY');

select rownum, e.* from employee e;

--display alternate records
--odd
select * from  (select rownum rn, e.* from employee e order by rn) where mod (rn, 2)!=0 ;
--even
select * from  (select rownum rn, e.* from employee e order by rn) where mod (rn, 2)=0 ;

--display duplicate values and its frequency in a column (eg: deptname)
select deptname, count(deptname) from employee group by deptname ;

--display the value which occurs exactly twice in the column
select deptname, count(deptname) from employee group by deptname having count(deptname) =2;





