create database week11;
use week11;

create table grades 
(SName varchar(10), Assgn varchar(15), Grade INT);

-- modify path to CSV file for your file location
LOAD DATA LOCAL INFILE 'C:/Users/morga/Documents/grades.csv'
INTO TABLE grades
FIELDS TERMINATED BY ',' ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from grades;

-- Standardize homework column to HWd
update grades
set Assgn = concat('HW' , (right(Assgn,1)));

-- Sname to first letter capitalized
update grades
set Sname = concat(upper(left(sname,1)), lower(substring(sname, 2, length(sname) - 1)));

-- Create id as primary key
alter table grades
add column id int not null auto_increment first,
add primary key (id);

-- create column sid with unique numbers
alter table grades
add column sid int not null after id;

update grades
set sid =
case
when SName = 'Jesse' then 1
when SName = 'Julio' then 2
when SName = 'Percy' then 3
when SName = 'Samantha' then 4
end;

-- Try the following inquiry and set null grades to 0
select sname, count(*), sum(grade), avg(grade), sum(grade)/count(*) from grades group by sname;

update grades
set grade = '0' where grade is null;

-- Write query that shows name of assignment avrg grade, lowest grade, and highest grade on assgmnt sort from highest to lowest
select assgn, avg(grade), min(grade), max(grade) from grades group by assgn;


-- average grade
select avg(grade), sname,
case
when avg(grade) >= 90 then 'A'
when avg(grade) < 90 and avg(grade) >= 80 then 'B'
when avg(grade) < 80 and avg(grade) >= 70 then 'C'
when avg(grade) < 70 and avg(grade) >= 60 then 'D'
when avg(grade) < 60 and avg(grade) >= 0 then 'F'
end as 'Letter Grade'
from grades
group by sid;

select * from grades;






