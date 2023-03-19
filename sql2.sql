select * from customer;
select * from trans;

select distinct FirstName,LastName
from
customer join trans using (customerID);

select firstName,LastName
from
listofartists la join customer_artist_int cai using (artistID)
join trans using (customerID); 

select * from customer c join customer_artist_int cai using(customerID);

select FirstName,LastName,title,workid
from customer left join trans using (customerID) 
left join work using (workID);

select area,count(email) from looking
where maxBudget>2000 and endStudyYear like '%11%'
group by area
order by area desc;

create view occupancy as (select adress, count(email)
from renting
#from renting as r1,renting as r2
#where r1.adress=r2.adress;
group by adress);

###
select * from listofartists;

select * from listofartists
where (DateDeceased-DateOfBirth) = (select max(DateDeceased-DateOfBirth) from listofartists);

select count(*) ArtistCount
from listofartists
where DateOfBirth between 1900 and 1950;
##3
select nationality,count(nationality) NumberofArtists
from listofartists
group by nationality;
#4
select lastName as Name, nationality, DateDeceased-DateOfBirth as age
from listofartists
order by age asc;
#5
select distinct Nationality from listofartists;
#6
select LastName from listofartists
where DateOfBirth between 1900 and 1999;
#7
select distinct country from customer
order by Country asc;
#8
select Country,count(*) from customer
group by Country order by Country;
#9
select concat(FirstName,' ',LastName) as Name, Nationality
from listofartists;
#10
select LastName,Nationality,DateDeceased
from listofartists order by DateDeceased desc,LastName asc;

