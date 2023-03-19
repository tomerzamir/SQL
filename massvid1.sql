#massvid
select * from listofartists;
select concat(FirstName,' ',LastName)as full_name from listofartists;
select LastName from listofartists where Nationality not in('spanish','german');
select firstName from listofartists where DateOfBirth between 1900 and 1999;
select distinct city from customer;
select artistID,count(workID) from work group by artistID;
select artistID,count(workID) as arts from work where arts>1;
#
select * from movie;
select * from movie where name like '%game%';
select * from movie where name like 'a%';
select * from theater;
#
select name from movie where idmovie in
(select distinct idmovie from screening where screeningid in
(select distinct idscreening from screening_occapancy so where idclient in
(select client_no from client where height<(select avg(height) from client))));
#
select distinct name from movie join screening s using(idmovie) 
join screening_occapancy so on s.screeningid=so.idscreening 
join client on so.idclient=client_no
where height<(select avg(height) from client);
#
select cname,max(height)from client;
select c1.cname from client c1,client c2 where c1.height>c2.height;
select c1.cname from client c1,client c2 where c1.cname=c2.cname;
