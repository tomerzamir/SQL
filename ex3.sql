select * from client;
select * from screening_occapancy;
select * from screening;
select * from movie;
select * from theater;
#4
select name,screening_time
from movie inner join screening on movie.idmovie=screening.idmovie
where screening_time > '2016-03-01' and idtheater%2=1;
#5
#pi cname  (client X screening_occapancy)
select count(cname) from client c join screening_occapancy so on c.client_no=so.idclient; 
#pi cname (sigma (client.client_no=screening_occapancy.idclient) (client X screening_occapancy)
select count(cname) from client c join screening_occapancy so on c.client_no=so.idclient
where c.client_no=so.idclient;  
#6
select distinct cname from client c #join screening_occapancy so on c.client_no=so.idclient
#join screening s on so.idscreening=s.screeningid
where not exists(select distinct idmovie from screening where idmovie not in
(select distinct idmovie from screening s1 join screening_occapancy so1 
on s1.screeningid=so1.idscreening where c.client_no=so1.idclient));
#6-sol
select cname from client as a
where not exists(select distinct m.idmovie from movie as m where m.idmovie not in
(select m2.idmovie from movie as m2 join screening s on (m2.idmovie=s.idmovie)
join screening_occapancy as so on (so.idscreening=s.screeningid)
where idclient=a.client_no));
#7
select * from screening s1 join theater t1 on s1.idtheater=t1.id;
select * from screening_occapancy so group by idscreening,so.row;
#
select * from screening_occapancy so join screening s on so.idscreening=s.screeningid
join theater t on s.idtheater=t.id
where count(so.row) = t.columns group by idscreening,so.row;
#
create view viewers_in_row as
(   
	select so.idscreening,so.row,count(so.row) as seats_taken
    from screening_occapancy so	group by idscreening,so.row
);
create view full_row as
(
	select distinct s.screeningid from screening s join theater t on s.idtheater=t.id
	join viewers_in_row v on(s.screeningid=v.idscreening) 
    where t.columns= v.seats_taken
);
#7
select m.name,s.screeningid from movie m join screening s using (idmovie)
where s.screeningid in(select screeningid from full_row); 
#8-sol
select cname from client c where c.client_no
not in(select idclient from screening_occapancy so where so.row=3);
