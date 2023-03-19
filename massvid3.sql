#massvid 4
#2018-sb-1:
#1: שמות של כדורגלנים מתחת לגיל 30
select name from drinker join occupation using(occupation_code)
where year(now())-year(birth_date)<30 and occupation_name='football player';
#2: כמות השתיינים מתחת לגיל 25 עבור כל מקצוע עם ממוצע הכנסות מעל 15,000
select occupation_name,count(drinker_code) from drinker where year(now())-year(birth_date)<25
and occupation_code in(select occupation_code from drinker 
where avg(income)>15000 group by occupation_code) group by occupation_code;
#better-sol
select occupation_name,count(*) from drinker join occupation using(occupation_code) 
where year(now())-year(birth_date)<25
group by occupation_name having avg(income)>15000;
#3: שמות כל השתיינים ללא בירה מועדפת
select name from drinker join favourite_bear using(drinker_code) where beer_code!=NULL;
#better-sol:
select name from drinker where drinker_code not in(select drinker_code from favourite_bear);
#4: שם השתיין עם הכי הרבה בירות מועדפות
select name from 
(select drinker_code,count(beer_code) as num
from favourite_bear join drinker using(drinker_code) group by drinker_code) as temp
having max(num);
#5: הכדורגלנים שאוהבים את כל סוגי האלכוהול עם אחוז אלכוהול מעל 7%
select name from drinker join occupation using(occupation_code)
where occupation_name='football player'
and not exists(select beer_code from beer where alcohol_rate>7 and beer_code
not in(select beer_code from favourite_bear f where f.drinker_code=d.drinker_code));
#