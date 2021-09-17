--DDL PARCIAL

CREATE TABLE country(
	countryid SERIAL PRIMARY KEY,
	name varchar (20)

);

CREATE TABLE city(
	cityid SERIAL PRIMARY KEY,
	name varchar (20),
	countryid int REFERENCES country(countryid)

);

CREATE TABLE  address(
	addressid serial PRIMARY KEY,
	line1 varchar (30),
	line2 varchar (30),
	cityid int REFERENCES city(cityid)

);


CREATE TABLE branchoffice(
	branchid serial PRIMARY KEY,
	name varchar (30),
	addressid int REFERENCES address(addressid)

);

CREATE TABLE position(
	positionid SERIAL PRIMARY KEY,
	name varchar (20)

);

CREATE TABLE department(
	deparmentid SERIAL PRIMARY KEY,
	name varchar (20)

);

CREATE TABLE employee(
	employeeid SERIAL PRIMARY KEY,
	fullName varchar (20),
	branchid int REFERENCES branchoffice(branchid),
	departmentid int REFERENCES department(deparmentid),
	positionid int REFERENCES position(positionid),
	addressid int REFERENCES address(addressid),
	supervisorid int REFERENCES employee(employeeid)

); 


CREATE TABLE employeeAudit(
	employeeid int,
	fullName varchar (20),
	branch varchar (30),
	department varchar (20),
	position varchar (20),
	address varchar (60),
	supervisor varchar (20),
	city varchar (20),
	country varchar (20),
	event varchar (10),
	registeredAt date

);