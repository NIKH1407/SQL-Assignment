CREATE DATABASE Q1;

USE Q1;

CREATE TABLE CITY
(
	ID int,
    NAME VARCHAR(20),
    COUNTRYCODE VARCHAR(5),
    DISTRICT VARCHAR(20),
    POPULATION INT
    
);

SELECT * FROM CITY;

/*Q1*/

SELECT * FROM CITY
WHERE COUNTRYCODE = "USA"
AND POPULATION >100000;

/*Q2*/

SELECT NAME FROM CITY
WHERE COUNTRYCODE = "USA"
AND POPULATION >120000;

/*Q3*/

SELECT * FROM CITY;

/*Q4*/

SELECT * FROM CITY
WHERE ID = 1661;

/*Q5*/

SELECT * FROM CITY
WHERE COUNTRYCODE = "JPN"

/*Q6*/

SELECT NAME FROM CITY
WHERE COUNTRYCODE = "JPN"

/*Q7*/

CREATE TABLE STATION
(
	ID INT,
    CITY VARCHAR(21),
    STATE VARCHAR(2),
	LAT_N INT,
    LONG_W INT
    
);
SELECT * FROM STATION;

SELECT CITY,STATE FROM STATION;


/*Q8*/

SELECT DISTINCT CITY FROM STATION
WHERE ID % 2 = 0;

/*Q9*/

SELECT COUNT(*) AS "TOTAL_CITY_ENTRIES",
COUNT(DISTINCT CITY) AS "NUM_DIST_CITY",
COUNT(*) - COUNT(DISTINCT CITY) AS "DIFFERENCE"
FROM STATION;


/*Q10*/

(SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) ASC, CITY ASC
LIMIT 1)
UNION
(SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY ASC
LIMIT 1)


/*Q11*/

SELECT CITY FROM STATION 
WHERE CITY LIKE 'a%' 
OR CITY LIKE 'e%' 
OR CITY LIKE 'i%' 
OR CITY LIKE 'o%' 
OR CITY LIKE 'u%';


/*Q12*/


select distinct city 
from station 
where right(city,1) in ('a','e','i','o','u');


/*Q13*/

select distinct city
from station 
where left(city,1) not in ('a','e','i','o','u');

/*Q14*/

select distinct city
from station 
where right(city,1) not in ('a','e','i','o','u');

/*Q15*/


select distinct city
from station 
where left(city,1) not in ('a','e','i','o','u')
or right(city,1) not in ('a','e','i','o','u');

/*Q16*/

select distinct city
from station 
where left(city,1) not in ('a','e','i','o','u')
and right(city,1) not in ('a','e','i','o','u');


/*Q17*/

create table product
(
	product_id int,
    product_name varchar(20),
    unit_price int,
    primary key(product_id)
);
insert into product values
(1,"s8",1000),
(2,"G4",800),
(3,"iphone",1400);

create table seller
(
	seller_id int,
    product_id int,
    buyer_id int,
    sales_date date,
    quantity int,
    price int,
    foreign key(product_id) references product(product_id)
);
insert into seller values
(1,1,1,"2019-01-21",2,2000),
(1,2,2,"2019-02-17",2,800),
(2,2,3,"2019-06-02",2,800),
(3,3,4,"2019-05-13",2,2000);

(select p.product_id,p.product_name 
from product p
join seller s
on p.product_id = s.product_id
where s.sales_date >= "2019-01-01" and s.sales_date<= "2019-03-31")
except
(select p.product_id,p.product_name 
from product p
join seller s
on p.product_id = s.product_id
where s.sales_date < "2019-01-01" or s.sales_date > "2019-03-31")

/*Q18*/

create table views
(
	article_id int,
    author_id int,
    viewer_id int,
    view_date date
);
insert into views values
(1,3,5,'2019-08-01'),
(1,3,6,'2019-08-02'),
(2,7,7,'2019-08-01'),
(2,7,6,'2019-08-02'),
(4,7,1,'2019-07-22'),
(3,4,4,'2019-08-21'),
(3,4,4,'2019-07-21')


select * from views;

select distinct author_id as id 
from views
where author_id = viewer_id
order by id asc;


/*Q19*/

create table Delivery
(
	delivery_id int,
    customer_id int,
    order_date date,
    customer_pref_delivery_date date,
    primary key(delivery_id)
);
insert into Delivery values
(1,1,'2019-08-01','2019-08-02'),
(2,5,'2019-08-02','2019-08-02'),
(3,1,'2019-08-11','2019-08-11'),
(4,3,'2019-08-24','2019-08-26'),
(5,4,'2019-08-21','2019-08-22'),
(6,2,'2019-08-11','2019-08-13')


select * from Delivery;


select round((select count(*) from delivery
where order_date = customer_pref_delivery_date)/count(*)*100,2 ) as immediate_percentage
from Delivery;


/*Q20*/

create table ads
(
	ad_id int,
    user_id int,
    action varchar(20),
    primary key(ad_id , user_id)
);
INSERT INTO ads VALUES
(1,1, 'clicked'),
(2,2, 'clicked'),
(3,3, 'viewed'),
(5,5, 'ignored'),
(1,7, 'ignored'),
(2,7, 'viewed'),
(3,5, 'clicked'),
(1,4, 'viewed'),
(2,11, 'viewed'),
(1,2, 'clicked');

select distinct ad_id, 
ifnull(round(sum(action = 'clicked')/
(sum(action='clicked')+sum(action = 'viewed'))*100,2),0) as ctr
from ads
group by ad_id
order by ctr desc,ad_id asc;

/*Q21*/


create table employee
(
	employee_id int,
    team_id int,
    primary key(employee_id)
);

INSERT INTO employee values
(1,8),
(2,8),
(3,8),
(4,7),
(5,9),
(6,9);


select * from employee;


select employee_id,count(team_id) over(partition by team_id ) as team_size from employee 
order by employee_id;


/*Q22*/


create table countries
(
	country_id int primary key,
    country_name varchar(20)
);

create table weathers
(
	country_id int,
    weather_state int,
    day date
);

insert into countries values
(2,'USA'),
(3,'Australia'),
(7,'Peru'),
(5,'China'),
(8,'Morocco'),
(9,'Spain');


insert into weathers values
(2,15,'2019-11-01'),
(2,12,'2019-10-28'),
(2,12,'2019-10-27'),
(3,-2,'2019-11-10'),
(3,0,'2019-11-11'),
(3,3,'2019-11-12'),
(5,16,'2019-11-07'),
(5,18,'2019-11-09'),
(5,21,'2019-11-23'),
(7,25,'2019-11-28'),
(7,22,'2019-12-01'),
(7,20,'2019-12-02'),
(8,25,'2019-11-05'),
(8,27,'2019-11-15'),
(8,31,'2019-11-25'),
(9,7,'2019-10-23'),
(9,3,'2019-12-23');


select * from weathers;

select c.country_name,
case 
when avg(weather_state) <=15 then "Cold"
when avg(weather_state) >= 25 then "Hot"
else "warm"
end as weather_state
from countries c
join weathers w
on c.country_id = w.country_id
where month(day) = 11
group by c.country_name;


/*Q23*/


create table prices
(
	product_id int,
    start_date date,
    end_date date,
    price int

);
create table unitssold
(
	product_id int,
    purchase_date date,
    units int
);

insert into prices values
(1,"2019-02-17","2019-02-28",5),
(1,"2019-03-01","2019-03-22",20),
(2,"2019-02-01","2019-02-20",15),
(2,"2019-02-21","2019-03-31",30);

insert into unitssold values
(1,"2019-02-17",100),
(1,"2019-03-01",15),
(2,"2019-02-01",200),
(2,"2019-03-22",30);

select * from prices;
select * from unitssold;

select p.product_id,
round(sum(u.units*p.price)/sum(u.units),2) as average_price
from prices p
join unitssold u
on p.product_id = u.product_id
where u.purchase_date >=start_date and u.purchase_date <=end_date
group by product_id
order by product_id;


/*Q24*/


create table activity
(
	player_id int,
    device_id int,
    event_date date,
    games_played int

);

insert into activity values
(1,2, "2016-03-01",5),
(1,2, "2016-05-02",6),
(2,3, "2017-06-25",1),
(3,1, "2016-03-02",0),
(3,4, "2018-07-03",5);


select * from  activity;

select t.player_id,event_date as first_login from (select player_id,event_date,
row_number() over(partition by player_id order by event_date) as num 
from activity)t 
where t.num=1; 


/*Q25*/


select t.player_id,t.device_id 
from (select player_id,device_id,
row_number() over(partition by player_id order by event_date)as num
from activity)t
where t.num=1; 

/*Q26*/


create table products
(
	product_id int primary key,
    product_name varchar(40),
    product_category varchar(40)
);
create table orders
(
	product_id int,
    order_date date,
    unit int
);

Insert into products values
(1,"leetcode solution","book"),
(2,"jewels of stringology","book"),
(3,"HP","Laptop"),
(4,"lenovo","Laptop"),
(5,"leetcode T-shirt ","book");

Insert into orders values
(1,"2020-02-05",60),
(1,"2020-02-10",70),
(2,"2020-02-18",30),
(2,"2020-02-11",80),
(3,"2020-02-17",2),
(3,"2020-02-24",3),
(4,"2020-03-01",20),
(4,"2020-03-04",30),
(4,"2020-03-04",60),
(5,"2020-02-25",50),
(5,"2020-02-27",50),
(5,"2020-03-01",50);


select p.product_name , sum(o.unit) as unit
from products p
join orders o
on p.product_id  = o.product_id
where month(o.order_date) = 2 and year(o.order_date) = 2020
group by p.product_name
having unit >=100; 


/*Q27*/

create table users
(
	users_id int,
    name varchar(15),
    mail varchar(30)
);
insert into users values
(1,"winston","winston@leetcode"),
(2,"jonathan","jonathanisgreate"),
(3,"Annabelle","bella-@leetcode"),
(4,"sally","sally.come@leetcode"),
(5,"marwan","quarz#2020@leetcode"),
(6,"David","david69@leetcode"),
(7,"shapiro",".shapiro@leetcode");


select users_id,name,mail from users
where mail regexp '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode.com$';



/*Q28*/

create table customers
(
	customer_id int primary key,
    name varchar(20),
    country varchar(20)

);

create table products1
(
	product_id int primary key,
    description varchar(20),
    price int

);

create table orders1
(
	order_id int,
    customer_id int,
    product_id int,
    order_date date,
    quantity int

);

insert into customers values
(1, "winston","USA"),
(2, "jonathan","peru"),
(3, "moustafa","egypt");


insert into products1 values
(10, "LG Phone",300),
(20, "LG T-shirt",10),
(30, "LG Book",45),
(40, "LG Keychain",2);

insert into orders1 values
(1,1,10,"2020-06-10",1),
(2,1,20,"2020-07-01",1),
(3,1,30,"2020-07-08",2),
(4,2,10,"2020-06-15",2),
(5,2,40,"2020-07-01",10),
(6,3,20,"2020-06-24",2),
(8,3,30,"2020-06-25",2),
(9,3,30,"2020-05-08",3);


SELECT t.customer_id, t.name
FROM (
    SELECT c.customer_id, c.name,
    SUM(
        CASE 
            WHEN MONTH(o.order_date) = 6 AND YEAR(o.order_date) = 2020 THEN p.price * o.quantity
            ELSE 0
        END
    ) AS june_spent, 
    SUM(
        CASE 
            WHEN MONTH(o.order_date) = 7 AND YEAR(o.order_date) = 2020 THEN p.price * o.quantity
            ELSE 0
        END
    ) AS july_spent
    FROM orders1 AS o
    JOIN products1 AS p ON o.product_id = p.product_id
    JOIN customers AS c ON o.customer_id = c.customer_id
    GROUP BY c.customer_id
) t
WHERE june_spent >= 100 AND july_spent >= 100;



/*Q29*/


create table TVprogram
(
	program_date date,
    content_id int,
    channel varchar(20)
);

create table content
(
	conntent_id int,
    title varchar(20),
    kids_content varchar(20),
    content_type varchar(20)
);

insert into TVprogram values
("2020-06-10 08:00",1,"LC-Channel"),
("2020-05-11 12:00",2,"LC-Channel"),
("2020-05-12 12:00",3,"LC-Channel"),
("2020-05-13 14:00",4,"Disney Ch"),
("2020-06-18 14:00",4,"Disney Ch"),
("2020-07-15 16:00",5,"Disney Ch");

insert into content values
(1,"Leetcode Movies","N","Movies"),
(2,"Alg. for kids","Y","series"),
(3,"Database sols","N","series"),
(4,"Aladdin","Y","Movies"),
(5,"Cinderella","Y","Movies");

select * from content;

SELECT DISTINCT c.title
FROM content c
JOIN TVprogram t ON c.content_id = t.content_id
WHERE c.kids_content = 'Y'
  AND c.content_type = 'Movies'
  AND MONTH(t.program_date) = 6
  AND YEAR(t.program_date) = 2020;



/*Q30*/


create table NPV
(
	ID int,
    Year int,
    Npv int 

);

create table queries
(
	ID int,
    Year int
);

Insert into NPV values
(1,2018,100),
(7,2020,30),
(13,2019,40),
(1,2019,110),
(2,2008,121),
(3,2009,12),
(11,2020,99),
(7,2019,0);

Insert into queries values
(1,2019),
(2,2008),
(3,2009),
(7,2018),
(7,2019),
(7,2020),
(13,2019);


select q.id,q.year,coalesce(n.Npv,0) as NPV
from queries as q
join NPV n
on q.id  = n.id and q.year = n.year
order by q.id;

/*31*/

create table NPV
(
    id int,
    Year INT,
    Npv INT
);

create table Queries
(
    id int,
    Year INT
);

INSERT INTO NPV VALUES
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);


INSERT INTO Queries VALUES
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);






select * from NPV;


SELECT *  from Queries;

SELECT q.*,COALESCE(n.Npv,0) as NPV
from Queries as q
join NPV as n
on q.id = n.id and q.Year = n.Year
order BY q.id asc;

/*Q32*/

create TABLE Employees
(
    id INT PRIMARY KEY,
    Name VARCHAR(20)
);

create TABLE EmployeeUNI
(
    id INT,
    unique_id int,
    PRIMARY KEY(id,unique_id)
);


INSERT INTO Employees VALUES
(1,"Alice"),
(7,"Bob"),
(11,"Meir"),
(90,"Winston"),
(3,"Jonathan");

INSERT INTO EmployeeUNI VALUES
(3,1),
(11,2),
(90,3);

SELECT * from Employees;

SELECT * from EmployeeUNI;


select u.unique_id,e.name 
from Employees e
left join EmployeeUNI as u
on u.id = e.id
ORDER BY u.id ASC;




/*Q33*/


create table users
(
    id INT primary KEY,
    Name VARCHAR(20)
);

create table rides
(
    id INT PRIMARY KEY,
    user_id INT,
    distance INT
);


INSERT into users VALUES
(1,"Alice"),
(2,"Bob"),
(3,"Alex"),
(4,"Donald"),
(7,"Lee"),
(13,"Jonathan"),
(19,"Elvis");

INSERT into rides VALUES
(1,1,120),
(2,2,317),
(3,3,222),
(4,7,100),
(5,13,312),
(6,19,50),
(7,7,120),
(8,19,400),
(9,7,230);

SELECT u.name,COALESCE(SUM(r.distance),0) as travelled_distance
FROM users u
left JOIN rides r
on u.id = r.user_id
group by u.name
ORDER BY travelled_distance desc;



/*Q34*/

create table products
(
    product_id INT,
    product_name VARCHAR(30),
    product_category VARCHAR(20)
);

create table orders
(
    product_id INT,
    order_date DATE,
    unit INT
);

INSERT INTO products VALUES
(1,"Leetcode solution","Book"),
(2,"Jewels of stringology","Book"),
(3,"HP","Laptop"),
(4,"Lenovo","Laptop"),
(5,"Leetcode kit","T-shirt");

INSERT INTO orders VALUES
(1,"2020-02-05",60),
(1,"2020-02-10",70),
(2,"2020-01-18",30),
(2,"2020-02-11",80),
(3,"2020-02-17",02),
(3,"2020-02-24",03),
(4,"2020-03-01",20),
(4,"2020-03-04",30),
(4,"2020-03-04",60),
(5,"2020-02-25",50),
(5,"2020-02-27",50),
(5,"2020-03-01",50);


SELECT * from orders;

SELECT * from products;


SELECT p.product_name,sum(o.unit) as units
from products as p
LEFT JOIN orders as o
on p.product_id = o.product_id
where MONTH(o.order_date) = 2 and YEAR(o.order_date) = 2020
group by p.product_name
HAVING units >=100;




/*Q36*/

--Repeat as Q33

/*Q37*/

--Repeat as Q

/*Q38*/

create table departments
(
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT into departments VALUES
(1,"Electrical Engineering"),
(7,"Computer Engineering"),
(13,"Business Administration");


create Table students
(
    id INT PRIMARY KEY,
    name VARCHAR(20),
    department_id INT
);


INSERT INTO students VALUES
(23,"Alice",1),
(1,"Bob",7),
(5,"Jennifer",13),
(2,"John",14),
(4,"Jasmine",77),
(3,"Steve",74),
(6,"Luis",1),
(8,"Jonathan",7),
(7,"Daiana",33),
(11,"Madelynn",1);


select * from departments;
SELECT* from students;


SELECT
  id,
  name
FROM
  students
WHERE
  department_id NOT IN (
    SELECT
      id
    FROM
      departments
  );



/*Q39*/

create table calls
(
    from_id INT,
    to_id INT,
    duration INT
);

insert INTO calls VALUES
(1,2,59),
(2,1,11),
(1,3,20),
(3,4,100),
(3,4,200),
(3,4,200),
(4,3,499);

SELECT * from calls;


SELECT
  from_id AS person1,
  to_id AS person2,
  COUNT(*) AS call_count,
  SUM(duration) AS total_duration
FROM
  (
    SELECT *
    FROM calls
    UNION ALL
    SELECT to_id, from_id, duration
    FROM calls
  ) AS t1
WHERE
  from_id < to_id
GROUP BY person1, person2
ORDER BY person1, person2;




/*40*/

--repeat


/*41*/


create table warehouse
(
    name VARCHAR(20),
    product_id int,
    unit INT,
    PRIMARY KEY(name,product_id)
);
create Table products2
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(20),
    width INT,
    length INT,
    height  INT
);

INSERT INTO warehouse values
("LCHouse1" , 1 , 1),
("LCHouse1" , 2 , 10),
("LCHouse1" , 3 , 5),
("LCHouse2" , 1 , 2),
("LCHouse2" , 2 , 2),
("LCHouse3" , 4 , 1);


INSERT INTO products2 VALUES
(1,"LC-TV",5,50,40),
(2,"LC-KeyChain",5,5,5),
(3,"LC-Phone",2,10,10),
(4,"LC-T-Shirt",4,10,20);


SELECT * from products2;

SELECT * from warehouse;

SELECT w.name as warehouse_name,SUM(p.width*p.LENGTH*p.height * w.unit) as volume
from warehouse w
left JOIN products2 p
ON w.product_id  = p.product_id
GROUP BY w.name
ORDER BY w.name asc;


/*42*/


create table sales
(
    sale_date date,
    fruit VARCHAR(15),
    sold_num INT
);

INSERT INTO sales VALUES
("2020-05-01","apples",10),
("2020-05-01","oranges",08),
("2020-05-02","apples",15),
("2020-05-02","oranges",15),
("2020-05-03","apples",20),
("2020-05-03","oranges",0),
("2020-05-04","apples",15),
("2020-05-04","oranges",16);




SELECT t.sale_date,(t.apples_sold - t.oranges_sold) as diff
FROM
(Select sale_date,
MAX(CASE 
    WHEN fruit = "apples" THEN sold_num  
    ELSE  0
END) as apples_sold,
MAX(CASE 
    WHEN fruit = "oranges" THEN sold_num  
    ELSE  0
END) as oranges_sold
FROM sales
GROUP BY sale_date)t
ORDER BY t.sale_date;


/*43*/


CREATE TABLE activity
(
    player_id INT,
    device_id INT,
    event_date date,
    games_played INT
);

INSERT INTO activity VALUES
(1,2,"2016-03-01",5),
(1,2,"2016-03-02",6),
(2,3,"2017-06-25",1),
(3,1,"2016-03-02",0),
(3,4,"2018-07-03",5);

SELECT * from activity;





/*44*/

Create table Employee1
(
    id INT,
    name VARCHAR (10),
    department VARCHAR(5),
    managerid INT
);
INSERT INTO Employee1 VALUES
 (101,"John","A",NULL),
 (102,"Dan","A",101),
 (103,"James","A",101),
 (104,"Amy","A",101),
 (105,"Anne","A",101),
 (106,"Ron","B",101);

SELECT * from Employee1;


select a.id, a.name, count(b.managerid) as no_of_direct_reports 
from Employee1 a 
INNER JOIN Employee1 b 
on a.id = b.managerid
group by b.name


select	t.name from
(SELECT a.id, a.name, COUNT(b.managerid) AS no_of_direct_reports
FROM Employee1 a
INNER JOIN Employee1 b ON a.id = b.managerid
GROUP BY a.id, a.name)t
where no_of_direct_reports>=5
order by t.name;



/*45*/

create table department
(

	dept_id int primary key,
    dept_name varchar(15)
);

insert into department values
(1,"Engineering"),
(2,"Science"),
(3,"Law");


create table student
(

	student_id int primary key,
    student_name varchar(15),
    gender  varchar(10),
    dept_id int
);

insert into student values
(1,"jack","M",1),	
(2,"jane","F",1),
(3,"mark","M",2);

select * from	student;
select * from	department;


select d.dept_name,count(s.dept_id) as student_number
from department d
left join student s
on s.dept_id = d.dept_id
group by  d.dept_name

/*46*/

Create table customer
(
	customer_id int,
    product_key int

);

create table product1
(
	product_key int

);


insert into customer values
(1,5),
(2,6),
(3,5),
(3,6),
(1,6);

insert into product1 values
(4),
(6);

select * from product1;
select * from 	customer;

select customer_id from customer 
group by customer_id 
having count(distinct product_key)=(select count(*) from product);
 
 









