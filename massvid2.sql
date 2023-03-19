#massvid 1-3
#division-contains:
# select x from..as a where (select y from...where a.x=x) contains(select y...)
# select..............where (מחולק)........................contains(מחלק)
# בודקים האם המחולק מכיל את המחלק
#division-double negation:
# select...from..as a where not exists (select y from...where a.x=x and y not in(select y...))
# select............. where not exists (מחלק.............................. not in(מחולק))
# בודקים האם המחלק מוכל במחולק
#sql-1: 2018-S.a_1
#1: מחזירה לכל לקוח את המשחקים שהוא שיחק בהם ושילם מעל ל-1000 שקל
select username,gamename from play where payed>1000;
#2: המייל של הלקוח שהפסיד הכי הרבה
select email from client join play using(username)
where profitLoss = (select min(profitloss) from play);
#3: משחקים המכילים את המילה פוקר, בהם המינימום כניסה גדול מ-50 שקל
select gamename from game where gamename like '%POKER%' and minAmount>50;
#4: מי הם הלקוחות שמעולם לא שיחקו בבלאק-ג'אק?
select username from play where username not in
(select username from play where gamename='BlackJack');
#5: מיהם הלקוחות ששיחקו בכל משחקי הקלפים באתר?
select username from play p join game using(gamename)
where not exists (select gamename from game where type='cards' 
not in(select gamename from play where p.username=username));
#sol-2:
select username from play p where (select gamename from play where username=p.username)
contains(select gamename from game where type='cards');
#6: לכל לקוח, חשבו מה סך הרווח שלו
select username,sum(profitloss-payed) as profit from play group by username;
###
#sql-2: 2018-9SA1
#1: מס' הקורסים הנלמדים בכל עיר ואורכם הממוצע
select distinct cityLocation,count(distinct courseName), avg(hourEnd-hourStart) 
from courseStudies group by cityLocation;
#2: שמות הסטודנטים שגרים בקרוס בה הם גרים ושמם נגמר באותיות בה
select name from student s1
where exists (select coursename from student s2 join courseStudies using(email)
where s1.name=s2.name and city=cityLocation and name like '%בה');
#sol-2:
select name from student s1 join courseStudies cs using(email)
where s1.city=cs.cityLocation and name like 'בה%';
#3: כל הקורסים עם הזמן הכי ארוך
select courseName from courseStudies 
where (hourEnd-HourStart) in (select max(hourEnd-hourStart) from courseStudies);
#5: שמות כל הסטונדטים ללא רכב אבל לומדים לפחות קורס אחד מחוץ לעיר בה גרים
select name from student s1 where email not in(select ownerEmail from car)
and exists(select courseName from courseStudies where s1.email=email 
and s1.city!=cityLoaction);
#sol-2:
select name from student s1 join courseStudies using(email)
where s1.city!=cityLoaction and email not in(select ownerEmail from car);
#4: סה"כ מחיר הנסיעות לכל סטודנט
select email,sum(costPerKm*numKm*2) from student s1 join courseStudies cs using(email)
join car on cs.email=car.ownerEmail
join routes r on s1.city=r.fromCity and cs.cityLocation=r.toCity group by email;
#5: כל הסטודנטים הלומדים את כל הקורסים הנלמדים בעיר מגוריהם
select name from student s1 
where not exists(select courseName from courseStudies where cityLocation=s1.city
and courseName not in (select courseName from courseStudies cs where s1.email=cs.email));



