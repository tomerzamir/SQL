#1: לקוחות שהזמינו את כל העוגות שיש בהם קקאו
#not exists sol:
select clientName from client c1 where not exists(select distinct cakeName from cakeIng
where ingridient="קקאו" and cakeName not in
(select distinct cakeName from cakeOrder c2 where c1.clientPhone=c2.clientPhone));
#contains sol:
select clientPhone from cakeOrder co1 where
(select cakeName from cakeOrder co2 where co2.clientPhone=co.clientPhone)
contains
(select cakeName from cakeIng where ingridient="קקאו");
#
select something from t where x>all(select x from t where y=a);
#
select FirstName from 
(select ArtistID,FirstName,count(artistID) as num
from work join listofartists using(artistID) group by artistID) as temp
having max(num);
#
select * from movie;
select something from t where x>all(select x from t where y=a);
select name,price from movie where price>all(select price from movie where name like"%game%");
select name,price from movie where price>any(select price from movie where name like"%game%");