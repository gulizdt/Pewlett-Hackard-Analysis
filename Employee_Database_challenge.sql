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

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,last_name,first_name, title

INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date desc;

select count(unique_titles.title) as "number of titles", title
into Retiring_titles
from unique_titles
group by title
order by "number of titles" desc


select* from unique_titles

drop table retiring_tables
