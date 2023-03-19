select * from client;
select * from movie;
select * from screening;
select * from screening_occapancy;
select * from theater;
select * from client join screening_occapancy on client_no=idclient;
#1
select max(c) from(select count(client_no) as c from client t1,screening_occapancy t2
where t1.client_no=t2.idclient group by client_no)as maxi;
#2
select count(distinct idclient) from screening_occapancy;
#3
select max(height),min(height) from client;
#4
select idclient from screening_occapancy so join theater t on (so.idscreening=t.id)
where (so.idscreening=2 and so.row=t.rows and so.col=t.columns)
or (so.idscreening=2 and so.row=1 and so.col=1);
#5
select count(*) from client c, (select avg(height) as avgH from client) t where c.height>avgH;
#6
# select...from...where not exists (מחלק...not in(מחולק))
select count(distinct idclient) from
screening_occapancy so join client c on idclient=client_no
where not exists(select distinct idclient from screening_occapancy so where so.row=1
not in(select distinct client_no from client));

select count(distinct client_no) from client where client_no 
not in(select idclient from screening_occapancy so where so.row=1);
#7
select count(distinct client_no) from
client join screening_occapancy on idclient=client_no where client_no
not in(select idclient from screening_occapancy so where so.row=1);
#8
select max(height)-min(height) as gap from client;
#9
select distinct man.cname as man_name, woman.cname as woman_name
from client as man inner join screening_occapancy as mano
on man.client_no=mano.idclient,
client as woman inner join screening_occapancy as womo
on woman.client_no=womo.idclient
where man.gender='male' and woman.gender='female'
and mano.idscreening=womo.idscreening;
#10
select cname from client c1, 
(select avg(height) as avgF from client c2 where gender='female') f,
(select avg(height) as avgM from client c3 where gender='male') m
where c1.height>avgF and c1.gender='female' or c1.height>avgM and c1.gender='male';
#13
select * from client where gender='male' and height>=175 and height<=180;
#
SELECT distinct m.idmovie, m.name
FROM movie m,screening s
WHERE m.idmovie = s.idmovie and DATEDIFF(now(), screening_time) > 130
ORDER BY name;