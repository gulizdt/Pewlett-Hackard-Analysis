--Create a table where employees eligible to retire are identified and titles are specified
select employees.emp_no, 
	employees.first_name,
	employees.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
	
into retirement_titles
from employees
inner join titles
on employees.emp_no=titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by employees.emp_no;


-- Remove duplicates from the retirement_table and create a new table with this clean data
SELECT DISTINCT ON (emp_no) emp_no,last_name,first_name, title

INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date desc;

--Obtain the number of emplyees eligible to retire and group by title

select count(unique_titles.title) as "number of titles", title
into Retiring_titles
from unique_titles
group by title
order by "number of titles" desc

--Identify current employees that are eligible for the mentorship program
select emp.emp_no,
emp.first_name,
emp.last_name,
emp.birth_date,
de.from_date,
de.to_date,
ts.title
into Mentorship_Eligibility
from employees as emp
inner join dept_emp as de
on(emp.emp_no=de.emp_no)
inner join titles as ts
on(emp.emp_no=ts.emp_no)
where de.to_date = ('9999-01-01') and emp.birth_date between '1965-01-01'and '1965-12-31'

--This was a fun challenge.  Thank you.  Onward!




