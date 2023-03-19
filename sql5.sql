select * from listofartists;
#1
delete from listofartists where Nationality='American';
#2
update listofartists set Nationality = 'Belgian' where Nationality='French';
#3
alter table work
add column sold bool default false;
#
select * from work;
#4
update work set sold = true where workID in(select workID from trans);
#
select * from customer_artist_int;
#5
insert into customer_artist_int
(select ArtistID,CustomerID from listofartists a,customer c
 where a.lastName in('Matisse','Chagall') and
 c.FirstName = 'Susan' and c.lastName='Wu');
select * from customer_artist_int;
select * from customer;
#6
create table styles
(
	styleID int not null auto_increment primary key,
    styleName varchar(50)
);
#drop table styles;
#7
select * from work;
select * from styles;
alter table work add column styleID int,
add foreign key (styleID) references styles(styleID) on delete cascade; 
#8
create view OwnedWork as
(   
    select TransactionID as transID,
	title,concat(a.firstName,' ',a.lastName) as artist,
    concat(c.firstName,' ',c.lastName) as owner
    from trans join work using(workID) join listofartists a using(artistID)
    join customer c using(customerID)
);
select * from OwnedWork;
drop view OwnedWork;
#9
update listofartists set dateofBirth = dateofBirth-10 where(dateofBirth<1900);
select * from listofartists;
#10
select * from trans;
select * from work;
update work set AcquisitionPrice = (select AcquisitionPrice from trans 
where work.workID=trans.workID);
alter table trans
drop column AcquisitionPrice;
#