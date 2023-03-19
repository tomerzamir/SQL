###
select * from work;
select * from listofartists;
select * from trans;
#1
select LastName from listofartists join work using (ArtistID);
#2
select * from listofartists where ArtistID not in(select ArtistID from work);
#3
select FirstName,LastName from listofartists join work using(ArtistID)
join trans using (workid);
#where workID in(select workID from trans);
#4
select FirstName,LastName from listofartists 
where artistID not in(select workID from work join trans using(workID));
#5
select distinct LastName,FirstName,PhoneNumber from customer
join trans using (customerID);
#6
select distinct LastName,FirstName,PhoneNumber from customer
where customerID not in(select customerID from trans);
#7
select distinct Title,LastName 
from listofartists join work using(ArtistID)
where Copy='Unique';
#8
select distinct LastName 
from listofartists join work using(ArtistID)
where Description like "%Impressionist%";
#9
select distinct LastName
from listofartists join customer_artist_int using(ArtistID);
#10
select distinct Title 
from work join customer_artist_int using(ArtistID)
where workID not in(select workID from trans);