create table test
(
	idtest int not null auto_increment,
    testname varchar(42),
    dateoftest date not null,
    del integer,
    primary key(idtest)
);
#
drop table test;
#
select * from test;
#
alter table test
auto_increment = 200,
#modify testname varchar(52),
drop column del,
change testname test_name varchar(420),
add column test_result int not null;
#
insert into test(test_name,dateoftest,test_result) values 
('oop','2021-08-24',87),
('infi1','2022-08-24',90),
('data science','2022-02-24',92);
update test set test_name = 'Infi 1' where test_name='infi1';
update test set test_name = 'OOP' where test_name='oop';
#
select * from test;
#
update test set test_name = replace(test_name,'data science','Data Science');
insert into test(test_name,dateoftest,test_result) values 
('infi2','2021-08-24',70);
delete from test where test_name='infi2'; 
#
create table test2
(
	idtest int not null auto_increment,
    tName varchar(42),
	year int not null,
    primary key(idtest)
);
select * from test2;
#
drop table test2;
#
insert into test2(tName,year) 
select concat (firstName,' ',lastName) as full_name,DateOfBirth from listofartists;
#
select * from listofartists;
#
create table test3
(
	idtest int not null auto_increment,
    tName varchar(42),
	test_result int not null,
    primary key(idtest),
    unique key(tName),
    check (test_result >=60 and test_result <=100)
);
select * from test3;
insert into test3(tName,test_result) values 
('infi1',60),
('math',88),
('data science',100);
#
create assertion bloop
check(not exists(select * from student
where studentID not in(select studentID from study));
#

