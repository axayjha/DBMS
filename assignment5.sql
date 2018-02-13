/*
Assignment 5
Akshay Anand
13/02/2018
*/


create table employees101(
	eno number(10) primary key,
	ename varchar(20),
	zip number(10) references zipcode101(zip),
	hdate date,
);


create table parts101(
	pno number(10) primary key,
	pname varchar(20),
	qoh number(20),
	price number(10),
	level number(10)
);

create table customers101(
	cno number(10) primary key,
	cname varchar(20),
	street varchar(20),
	zip number(10) references zipcode101(zip),
	phone number(15)
);

create table orders101(
	ono number(10) primary key,
	cno number(10) references customers101(cno),
	eno number(10) references employees101(eno),
	street varchar(20),
	received date,
	shipped date
);

create table odetails101(
	ono number(10),
	pno number(10),
	qty number(10),
	constraint Ab primary key(ono, pno)
);

create table zipcode101(
	zip number(10) primary key,
	city varchar(10)
);


