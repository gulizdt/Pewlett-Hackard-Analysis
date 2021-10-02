-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

create table employees (
	emp_no INT not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	gender varchar not null,
	hire_date date not null,
	primary key (emp_no)
);

select* from employees
 
create table dept_manager(
dept_no varchar(4) not null,
emp_no int not null,
from_date date not null,
to_date date not null,
foreign key (emp_no) references employees (emp_no),
foreign key (dept_no)references departments(dept_no),
primary key (emp_no, dept_no)
);

create table salaries (
emp_no int not null,
salary int not null,
from_date date not null,
to_date date not null,
foreign key (emp_no) references employees(emp_no),
primary key (emp_no)
);

create table titles (
emp_no int not null,
	title varchar not null,
	from_date date not null,
	to_date date not null,
foreign key (emp_no) references employees (emp_no)
);
	
create table dept_emp(
emp_no int not null,
dept_no varchar (4) not null,
from_date date not null,
to_date date not null,
foreign key (emp_no) references employees (emp_no)
);

select first_name, last_name 
from employees
where birth_date between '1952-01-01' and '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

select count(first_name)
from employees
where birth_date between '1952-01-01' and '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

select first_name, last_name 
into retirement_info
from employees
where birth_date between '1952-01-01' and '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no

select dept.dept_name,
dm.emp_no,
dm.from_date,
dm.to_date
from departments as dept
inner join dept_manager as dm
on dept.dept_no=dm.dept_no;

select ri.emp_no,
ri.first_name,
ri.last_name,
de.to_date
into current_emp
from retirement_info as ri
left join dept_emp as de
on ri.emp_no=de.emp_no
where de.to_date=('9999-01-01')

select* from current_emp

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
order by de.dept_no;