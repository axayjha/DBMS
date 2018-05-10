create table customer102(
	custid number(10) primary key,
	custname varchar2(20),
	annualrev number(10),
	custtype varchar2(20),
	check (custid >=100 and custid <=1000)
);

insert into customer102 values(101, 'Akshay', 10000, 'Manufacturer');
insert into customer102 values(102, 'Shreya', 20000, 'Manufacturer');
insert into customer102 values(103, 'Arnab', 13000, 'Wholesaler');
insert into customer102 values(104, 'Ananya', 40000, 'Retailer');
insert into customer102 values(105, 'Avranil', 20000, 'Retailer');
insert into customer102 values(106, 'Nikita', 50000, 'Manufacturer');
insert into customer102 values(107, 'Srijita', 60000, 'Wholesaler');

create table city102(
	cityname varchar2(20) primary key,
	population number(10)
);

insert into city102 values('Kolkata', 1200000);
insert into city102 values('Delhi', 1600000);
insert into city102 values('Mumbai', 20000);
insert into city102 values('Chennai', 30000);
insert into city102 values('Patna', 40000);
insert into city102 values('Ranchi', 50000);


create table truck102(
	truckno varchar2(10) primary key,
	driver_name varchar2(20)
);

insert into truck102 values('t101', 'Bunty');
insert into truck102 values('t102', 'Gopal');
insert into truck102 values('t103', 'Pritam');
insert into truck102 values('t104', 'Shyam');
insert into truck102 values('t105', 'Ramu');
insert into truck102 values('t106', 'Amit');	


create table shipment102(
	shipmentno varchar2(10),
	custid number(10) references customer102(custid),
	weight number(10),
	truckno varchar2(10) references truck102(truckno),
	destination varchar2(20) references city102(cityname),
	shipdate date,
	constraint a001 primary key(shipmentno, custid),
	check (weight <1000)
);


insert into shipment102 values ('s101', 101, 20, 't103', 'Mumbai', '10-Jun-10');
insert into shipment102 values ('s102', 103, 120, 't102', 'Chennai', '12-May-10');
insert into shipment102 values ('s103', 102, 30, 't103', 'Kolkata', '24-Aug-10');
insert into shipment102 values ('s104', 105, 50, 't104', 'Delhi', '10-Jul-10');
insert into shipment102 values ('s105', 106, 60, 't101', 'Patna', '25-Sep-10');
insert into shipment102 values ('s106', 104, 90, 't105', 'Ranchi', '30-Mar-10');	
insert into shipment102 values ('s107', 106, 200, 't106', 'Mumbai', '20-Feb-10');	
insert into shipment102 values ('s108', 106, 250, 't101', 'Patna', '22-Jan-10');	

/* Queries */
#1

select custname from customer102, shipment102 
where customer102.custid = shipment102.custid 
and shipment102.destination in ('Mumbai', 'Kolkata', 'Chennai');

#2 
select driver_name from truck102, shipment102 
where truck102.truckno = shipment102.truckno 
and shipment102.weight >= 200;

#3
select min(weight) "Min_weight", max(weight) "Max_weight" from shipment102;

#4
select custname, avg(weight) from shipment102, customer102 
where shipment102.custid = customer102.custid 
group by custname;

#5
select cityname, population from city102, shipment102 
where shipment102.destination = city102.cityname
and shipment102.weight > 100;

#6
create view all_ship_by_date as 
	select * from shipment102 
	order by shipdate;

select * from all_ship_by_date;	

