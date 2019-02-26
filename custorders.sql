use custorders;

create table orders2
(custID varchar(10), CompName varchar(40), ContName varchar(40), ContTitle varchar(40), city varchar(20), Region varchar(10), PostC varchar(10), Country varchar(15), 
 OrderID INT, EmpID INT, Freight double, ProdID INT, UnitPrice double, Quantity INT, Discount double);
 
LOAD DATA LOCAL INFILE 'C:/Users/morga/Downloads/CustomerOrders.csv'
INTO TABLE orders2
FIELDS TERMINATED BY ','
IGNORE 2 LINES;

select * from orders2;

drop table orders2;

select avg(CountOfOrders) from (select count(*) as CountOfOrders from orders group by OrderID)a;

select OrderID, sum(unitPrice * quantity - unitPrice * quantity * (discount/100)) as "total" from orders group by OrderID order by total desc;

select ProdID, sum(quantity) as BestSell from orders group by ProdID order by BestSell desc;

select ProdID, sum(quantity) as BestSell from orders where Country = "Brazil" group by ProdID order by BestSell desc;

select * from orders2 where OrderID = 10782;
select * from orders2 where OrderID = 10865;