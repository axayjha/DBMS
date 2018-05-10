create table emp103(
	empno number(10) primary key,
	empname varchar2(20),
	job varchar2(20),
	mgr number(10),
	hiredate date,
	sal number(10),
	comm number(10),
	deptno number(5)
	);

insert into emp103 values (123, 'Akshay', 'Manager', null, '04-Jan-2010', 50000, 100000, 3);
insert into emp103 values (124, 'Ananya', 'President', 123,  '24-Jan-2010', 350000, 4100000, 3);
insert into emp103 values (125, 'Nikita', 'Officer', 123, '04-Jun-2012', 500040, 100000, 3);
insert into emp103 values (126, 'Shreya', 'Sales', 123,  '04-Jul-2011', 30000, 400000, 3);

insert into emp103 values (132, 'Shreyas', 'Sales', 123,  '04-Jul-2011', 30000, 400000, 3);
insert into emp103 values (127, 'Abhilash', 'Sales', 128,  '04-Jul-2011', 30000, 400000, 4);
insert into emp103 values (128, 'Avinash', 'Manager', null,  '04-Jul-2011', 30000, 400000, 6);
insert into emp103 values (129, 'Abhilash', 'Sales', 128,  '04-Jul-2012', 30000, 400000, 4);
insert into emp103 values (130, 'Abhilasha', 'Sales', 128,  '04-Jul-2013', 30000, 400000, 4);
insert into emp103 values (131, 'Abhilashi', 'Sales', 128,  '04-Jul-2014', 30000, 400000, 4);




select distinct job from emp103;
select * from emp103 order by sal asc;

/*set 3*/
#4
select * from emp103 where deptno=(select deptno from (select deptno, count(empno) as temp from emp103 group by deptno order by temp desc) where rownum=1);

/*set 4*/

create table customer3 (
	custid number(10) primary key,
	custname varchar2(20),
	annualrev number(10),
	custtype varchar2(20),
	check (custid >= 100 and custid <=10000)
);


create table city3(
	cityname varchar2(20) primary key,
	population number(10)
);



create table truck3(
	truckno varchar2(20) primary key,
	driver_name varchar2(20)
);

create table shipment3(
	shipmentno varchar2(20),
	custid number(10) references customer3(custid) ,
	weight number(10),
	truckno varchar2(20) references truck3(truckno),
	destination varchar2(20) references city3(cityname),
	shipdate date,
	constraint a3 primary key(shipmentno, custid),
	check (weight < 1000)
);

insert into customer3 values (200,'Arnab', 20000, 'Manufacturer');
insert into customer3 values (300,'Kasturi', 40000, 'Manufacturer');
insert into customer3 values (400,'Nikita', 10000, 'Wholesaler');
insert into customer3 values (500,'Rishabh', 80000, 'Wholesaler');
insert into customer3 values (600,'Avinash', 60000, 'Retailer');
insert into customer3 values (700,'Akshay', 30000, 'Retailer');

insert into city3 values('Kolkata', 100000);
insert into city3 values('Mumbai',20000);
insert into city3 values('Delhi', 500000);
insert into city3 values('Chennai',30000);
insert into city3 values('Pune', 70000);
insert into city3 values('Dehradun',5000);

insert into truck3 values('1001','Ramu');
insert into truck3 values('1002','Shyam');
insert into truck3 values('1003','Vinod');
insert into truck3 values('1004','Anil');
insert into truck3 values('1005','Arun');
insert into truck3 values('1006','Barun');

insert into shipment3 values('S001',200,700, '1001','Kolkata','12-JAN-18');
insert into shipment3 values('S002',600,800, '1006','Mumbai','22-JAN-18');
insert into shipment3 values('S003',300,900, '1006','Delhi','02-FEB-18');
insert into shipment3 values('S004',500,100, '1004','Dehradun','29-DEC-17');
insert into shipment3 values('S005',600,200, '1005','Pune','12-NOV-18');
insert into shipment3 values('S006',400,400, '1002','Chennai','18-NOV-18');
insert into shipment3 values('S007',700,700, '1003','Delhi','20-JAN-18');




#1
select cityname, max(weight) from (select cityname, weight from city3, shipment3 where city3.cityname = shipment3.destination) group by cityname;
#2
select custname, annualrev from customer3, shipment3, truck3 where customer3.custid=shipment3.custid and shipment3.truckno=truck3.truckno and truck3.driver_name like 'Barun';
#3
select driver_name from truck3, shipment3, city3 where truck3.truckno = shipment3.truckno and shipment3.destination=city3.cityname ;


select driver_name, count(distinct cityname) as temp from truck3, shipment3, city3 where truck3.truckno = shipment3.truckno and shipment3.destination=city3.cityname group by driver_name ;
select count(*) from (select distinct cityname from city3)
/*ans= */
select driver_name from (select driver_name, count(distinct cityname) as temp from truck3, shipment3, city3 where truck3.truckno = shipment3.truckno and shipment3.destination=city3.cityname group by driver_name ) where temp = (select count(*) from (select distinct cityname from city3));
#4

#
/* set 6 */

#5
select empname, to_char(hiredate, 'Month dd, yyyy') from emp103;

#6
 select mgr from (select mgr, count(empno) as temp from emp103 group by mgr order by temp desc) where rownum=1; 

 select mgr from (select mgr, count(empno) as temp from emp103 group by mgr order by temp desc) where rownum=1; 


 select mgr, count(em) from emp103 where (select count(empno) from (select mgr, count(empno) as temp from emp103 group by mgr order by temp desc) where rownum=1); 