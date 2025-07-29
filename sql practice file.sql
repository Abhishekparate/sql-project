create table employees(
employee_id serial primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
department varchar(50),
salary decimal(10,2) check (salary>0),
joining_date date not null,
age int check(age>18)
);
select * from employees;

insert into employees(first_name,last_name,department,salary,joining_date,age)
values ('amit', 'sharma', 'it', 60000.00, '2022-05-01', 29),
('neha', 'patel', 'hr', 55000.00, '2021-08-15', 32),
('ravi', 'kumar', 'finance', 70000.00, '2020-03-10', 35),
('anjali', 'verma', 'it', 65000.00, '2019-11-22', 28),
('suresh', 'reddey', 'operations', 50000.00, '2023-01-10', 26);

---retrieve all employees first_names and their departments.
select first_name, department from employees;

---update the salary of all employees in the 'it' department by increasing it by 10%
update employees
set salary = salary+salary*0.10
where department = 'it';

---delete all employees who are older than 34 years.
delete from employees 
where age > 34;

---add a new column email to the employees table
alter table employees
add column email varchar(100);

---rename the department column to dep_name
alter table employees
rename column department to deo_name;

---retrieve the names of employees who joined after January 1, 2021.
select first_name, last_name, joining_date
from employees
where joining_date > '2021-01-01';

---change the data type of the salary column to integer.
alter table employees 
alter column salary type integer using salary::integer;

---list all employees with their age and salary in descending order of salary.
select * from employees
order by salary desc;

---insert a new employee with the following detials.
---(raj, singh, marketing, 60000, 2023-09-15, 30)
insert into employees(first_name,last_name,deo_name,salary,joining_date,age)
values('raj', 'singh', 'marketing', 60000.00, '2023-09-15', 30)

---update age of employees +1 to every employee
update employees
set age = age+1;
