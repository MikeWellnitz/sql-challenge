DROP TABLE dept_emp;
DROP TABLE departments;
DROP TABLE dept_manager;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;


create table titles (
	title_id VARCHAR(30) NOT NULL PRIMARY KEY,
	title VARCHAR(30) NOT NULL
);

create table employees (
	emp_no VARCHAR(30) NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR(30) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex CHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	foreign key (emp_title_id) REFERENCES titles(title_id)
);
	
create table departments (
	dept_no VARCHAR(30) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL
);

create table salaries (
	emp_no VARCHAR(30) NOT NULL PRIMARY KEY,
	salary INT NOT NULL,
	foreign key (emp_no) REFERENCES employees(emp_no)
);



CREATE TABLE dept_emp (
	emp_no VARCHAR(30) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(30) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)  --composite key
);


create table dept_manager (
	dept_no VARCHAR(30) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no VARCHAR(30) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (dept_no, emp_no)  --composite key
);



--List the employee number, last name, first name, sex, and salary of each employee.
select employees.emp_no, last_name, first_name, sex, salary
from employees 
left join salaries on employees.emp_no = salaries.emp_no;


--List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date 
from employees where extract (year from hire_date) = 1986;

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
select titles.title, departments.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
from employees
join titles on employees.emp_title_id = titles.title_id
join dept_manager on employees.emp_no = dept_manager.emp_no
join departments on dept_manager.dept_no = departments.dept_no;

SELECT 
	titles.title
	, departments.dept_no
	, departments.dept_name
	, employees.emp_no
	, employees.last_name
	, employees.first_name
FROM employees
JOIN titles
	ON employees.emp_title_id = titles.title_id
JOIN dept_manager
	ON employees.emp_no = dept_manager.emp_no
JOIN departments 
	ON dept_manager.dept_no = departments.dept_no;


--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select dept_emp.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no;


--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select first_name, last_name, sex
from employees where first_name = 'Hercules' and last_name like 'B%';


--List each employee in the Sales department, including their employee number, last name, and first name.
select departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
from employees 
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
from employees 
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales' or dept_name = 'Development';


--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select last_name, count(last_name) as frequency
from employees
group by last_name
order by frequency desc;
