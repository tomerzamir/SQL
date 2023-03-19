###
create view occupancy as (select adress,count(email) as numofTennants 
from renting group by adress);
#
select adress,price/numBeds as roomPrice
from apartments join occupancy
where numBeds>numofTennants
order by roomPrice asc;
#
select adress from apartments where price>=all(select price from apartments);
#
select name,email,adress,price/numBeds as roomPrice
from student join looking using(email) join apartments using (area)
where maxBudget>=roomPrice
order by roomPrice;
#
select cityLocation, count(distinct courseName) as numCourses,
avg(hourEnd-hourStart) as avgLength
from CourseStudies group by cityLocation;
#
select distinct name from Student s join CourseStudies c using(email)
where email not in (select ownerEmail from Car)
and s.city != c.city;
##
# select...from...where(מחולק)...contains(מחלק)
select FirstName from listofartists l
where (select workID from trans)
contains (select workID from work w where l.artistID = w.artistID)
#
select usrername from Client c 
where(select gamename from Play p where(c.username = p.username))
contains(select gamename from Game where type="cards") 
####
# select...from...where not exists (מחלק...not in(מחולק))
#5
select SID from printjob pj1 where not exists
(select printerID from printerModel pm join printerInstance pi using(model)
join printJob using(printerID) where company='hp'
and pi.printerID not in(select printerID from printjob pj2 where pj1.SID=pj2.SID)); 
#6
select company from printerModel as PM1
where not exists (select printerID from printerInstance join printerModel PM2 using(model)
where PM1.company=PM2.company and printerID not in(select printerID from printJob));
#
select name from student as s where not exists
(select courseName from courseStudies cs where s.city = cs.cityLocation
and courseName not in(select courseName from courseStudies cs2 where cs2.email=s.email));
###
select concat(FirstName,' ',LastName) as name from listofartists;
##
select * from listofartists;
