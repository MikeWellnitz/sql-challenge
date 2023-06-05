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

select employees.emp_no, last_name, first_name, sex, salary
from employees 
left join salaries on employees.emp_no = salaries.emp_no;




--select *
--from employees where extract (year from hire_date) = 1986 and sex = 'M' and first_name like 'A%';

select first_name, last_name, hire_date 
from employees where extract (year from hire_date) = 1986;

select first_name, last_name, hire_date 
from employees where extract (year from hire_date) = 1986;


