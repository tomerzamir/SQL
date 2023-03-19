# select...from...where not exists (מחלק...not in(מחולק))

select name from drinker d1 join occupation using(ocupation_code) 
where occupation_name='football player'
and not exists(select beer_code from beer where alcohol_rate>7
and beer_code not in(select beer_code from favourite_beer as f1
join drinker d2 using(drinker_code) where f1.drinker_code==d1.drinker_code));
#
create view f as
(
	select drinker_code,count(beer_code) as beer_count
    from favourite_beers group by drinker_code
);
select name from drinker join f using(drinker_code)
where beer_count == (select max(beer_count) from f);
#
select name from drinker join occupation using(occupation_code)
where occupation_name='football player'
and year(now())-year(birth_date)<30;
#
select occupation_name,count(*) from drinker join occupation using(occupation_code)
where year(now())-year(birth_date)<25
#and occupation_code==(select occupation_code from occupation where avg(income>15000));
group by occupation_name having avg(income)>15000