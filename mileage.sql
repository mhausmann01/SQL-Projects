-- Worked with Carly Hamilton

create database mileage;
use mileage;

CREATE TABLE fillups 
(id INT not null PRIMARY KEY AUTO_INCREMENT, 
date_time datetime, 
volume DOUBLE, 
vehicle_id INTEGER, 
odometer DOUBLE, 
economy DOUBLE, 
total_cost DOUBLE, 
price DOUBLE, 
is_partial INTEGER, 
`restart` INTEGER
);

select from_unixtime(1392164473694 / 1000);

LOAD DATA LOCAL INFILE 'C:/Users/morga/Documents/mileage.csv'
INTO TABLE fillups
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(id, @date_time, volume, vehicle_id, odometer, economy, total_cost, price, is_partial, `restart`)
set date_time=from_unixtime(@date_time / 1000);

select * from fillups;

-- remove the restart column
alter table fillups
drop `restart`;

-- Remove erroneous data by identity
select id, price from fillups order by price desc;

update fillups
set price = '3.419' where id = '74';

-- Minimum, average, and maximum prices of gas
select price, min(price), avg(price), max(price) from fillups;

-- vehicle id, total price of gas all fillups each vehicle
select vehicle_id, sum(price) from fillups group by vehicle_id;

-- Vehicle id avg fuel economy of each rounded to the nearest mile/gallon
select vehicle_id, economy from fillups order by economy;

select vehicle_id, round(avg(nullif(economy, 0))) as RoundedAverage
from fillups 
group by vehicle_id;

-- modify to include case statement to display Prius for vehicle ids that are Prius and other for others
select vehicle_id, round(avg(nullif(economy, 0))) as RoundedAverage,
case
when round(avg(nullif(economy, 0))) <= 26 and round(avg(nullif(economy, 0))) >= 0 then 'Prius'
when round(avg(nullif(economy, 0))) >= 27 then 'Other'
end as 'What car is it'
from fillups
group by vehicle_id;

-- How many times gas was pumped for any given hour of the day that gas was pumped
select date_time from fillups group by date_time;

select extract(hour from date_time) as gasup, count('gasup') as occurences from fillups group by gasup;

-- Show how many times gas was pumped for each day of the week (abrv) sorted from most number of fillups to least
select dayname(date_time) as 'weekday', count('weekday') as 'gasup' from fillups group by weekday order by gasup desc;

-- select vehicle_id, month and year of fill up, number of times the car was filled with gas that month, total number of gallons of gas
-- for that month sorted in descending order of total numbers of gallons
select vehicle_id, concat(month(date_time),'/', year(date_time)) as 'month_year', count('month_year'), total_cost/price as gallons from fillups group by month_year order by gallons;



