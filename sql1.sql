###
select * from customer;
#
SELECT 
    LastName,Nationality 
FROM
    listofartists
WHERE
    Nationality not in ('French' , 'Spanish')
    and dateofbirth>1890;
###
SELECT 
    LastName,Nationality,DateOfBirth
FROM
    listofartists
WHERE
    LastName like 'k%';
#    
SELECT 
   FirstName, LastName, DateOfBirth
FROM
    listofartists
WHERE
    FirstName like '%e%';
###
SELECT 
    LastName, FirstName, Email
FROM
    customer
WHERE
    Email is null;
#    
SELECT 
    LastName, FirstName, Email
FROM
    customer    
WHERE
    Email is not null;
###
SELECT 
    LastName,Nationality 
FROM
    listofartists
WHERE
    Nationality in ('French' , 'German')
    order by LastName,FirstName desc;
###