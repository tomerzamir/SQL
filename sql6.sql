select * from listofartists;
select * from work;
select * from trans;
# select...from...where not exists (מחלק...not in(מחולק))
#1
select FirstName,LastName from listofartists A1 join work using(artistID)
where not exists(select workID from work W1 where W1.artistID=A1.artistID
and workID not in(select workID from trans));
#2
select FirstName,LastName from listofartists as A1
where (select workID from trans) contains 
(select workID from work where work.artistID=A1.artistID)
#4
select FirstName,LastName from listofartists A1 join work using(artistID)
where not exists(select workID from work W1 where W1.artistID=A1.artistID
and not exists(select * from trans t where W1.workID=t.workID));
#5
select FirstName,LastName from listofartists A1 join work using(artistID)
where (select count(workID) from work W1 where A1.artistID=W1.artistID)=
(select count(workID) from trans join work T using(workID) 
where A1.artistID=T.artistID);
#5-sol
select FirstName,LastName from listofartists A1 join work using(artistID)
group by artistID
having count(workID) = (select count(workID) from trans join work w using(workID)
where A1.artistID=w.artistID);
#7
select C,B from r,s where r.D=s.D;
#cinima
select * from client;
select * from movie;
select * from screening;
select * from screening_occapancy;
select * from theater;
#8
create view female as
(   
	select idscreening, so.row, count(idclient) as num_of_females
	from screening_occapancy so join client c on so.idclient=c.client_no
    where gender='female' group by idscreening,so.row
);
create view male as
(   
	select idscreening, so.row, count(idclient) as num_of_males
	from screening_occapancy so join client c on so.idclient=c.client_no
    where gender='male' group by idscreening,so.row
);
select name,idtheater,screening_time,so.row 
from movie mo, screening s, screening_occapancy so, client, male m, female f
where m.idscreening=f.idscreening and m.row=f.row
and num_of_males=num_of_females
and s.screeningid=f.idscreening
and mo.idmovie=s.idmovie;
#9
create view viewers as
(   
	select so1.idscreening, so1.row, count(so1.idclient) as num_of_viewers
	from screening_occapancy so1,screening_occapancy so2 
    where so1.idscreening=so2.idscreening and so1.row=so2.row
    group by so1.idscreening,so1.row
);
select so.idscreening,so.row from screening_occapancy so,viewers v
where so.row=v.row and so.row=num_of_viewers and so.idscreening=v.idscreening;
#9-sol-no good
select idscreening,so.row,count(col) as c from screening_occapancy so
group by idscreening,so.row
having(so.row=c);
#9-optimal
select so.idscreening, so.row, count(distinct idclient) as num
from screening_occapancy so group by idscreening,so.row
having(so.row=num);
#10
create view viewer as
(   
	select so.idscreening, so.row, count(distinct idclient) as num
	from screening_occapancy so group by idscreening,so.row
	#having(so.row=num)
);
#
create view occ as
(   
	select t.rows,idscreening,count(distinct so.row) as occ_rows
    from theater t join screening_occapancy so on t.id=so.idscreening
	group by idscreening
	having(t.rows=occ_rows)
);
create view occ2 as
(   
	select t.rows,idscreening,occ_rows
    from theater t join screening_occapancy so on t.id=so.idscreening
    join viewer using(idscreening)
	#group by idscreening
	having(t.rows=occ_rows)
);
#
select idscreening from viewer v1
where not exists(select so1.row from screening_occapancy so1
where v1.row=so1.row and v1.num!=0 and so1.idscreening=v1.idscreening and so1.row 
not in(select v2.row from viewer v2));
#10-sol

