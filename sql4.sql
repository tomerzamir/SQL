###
select * from customer;
select * from work;
select * from listofartists;
select * from trans;
#1
select distinct Country from customer order by Country asc;
#2
select distinct Country, count(CustomerID) 
from customer group by Country order by Country asc;
#3
(select LastName,FirstName from customer)
UNION (select LastName,FirstName from listofartists) order by LastName asc;
#4
(select LastName,FirstName,'c' as type from customer)
UNION (select LastName,FirstName,'a' from listofartists) order by LastName asc;
#6
select FirstName,LastName,Title
from customer left join trans using(customerID) left join work using(workID);
#7
select FirstName, LastName, count(workID) as 'number of paintings'
from listofartists left join work using(artistID) group by ArtistID;
#8
select FirstName, LastName from listofartists join
(select artistID,count(*) as c from work group by artistID) t using(artistID)
where t.c=(select max(c) from (select artistID,count(*) as c from work group by artistID) p);
#9
select avg(DateDeceased-DateOfBirth) as 'average age' from listofartists
where DateOfBirth<1900;
#10
select Nationality,avg(DateDeceased-DateOfBirth)'average age', 
min(DateDeceased-DateOfBirth)as min,max(DateDeceased-DateOfBirth) as max,
count(*) as numofArtists from listofartists group by Nationality 
order by avg(DateDeceased-DateOfBirth) desc;
#