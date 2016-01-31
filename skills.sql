-- Note: Please consult the directions for this assignment 
-- for the most explanatory version of each question.

-- 1. Select all columns for all brands in the Brands table.
select * from brands;

-- 2. Select all columns for all car models made by Pontiac in the Models table.
select * from models where brand_name = 'Pontiac';

-- 3. Select the brand name and model 
--    name for all models made in 1964 from the Models table.
select brand_name, name from models where year = '1964';

-- 4. Select the model name, brand name, and headquarters for the Ford Mustang 
--    from the Models and Brands tables.
select models.name, models.brand_name, brands.headquarters from          
models left join brands                                                         
on (models.brand_name = brands.name)                                            
where models.brand_name = 'Ford' and models.name ='Mustang';
-- 5. Select all rows for the three oldest brands 
--    from the Brands table (Hint: you can use LIMIT and ORDER BY).
select * from brands order by founded limit 3;

-- 6. Count the Ford models in the database (output should be a number).
select count(*) as total from models where brand_name ='Ford'group by brand_name;

-- 7. Select the name of any and all car brands that are not discontinued.
select count(name) from brands where discontinued is NOT NULL;

-- 8. Select rows 15-25 of the DB in alphabetical order by model name.
 select * from models where id <25 and id > 15 order by name;

-- 9. Select the brand, name, and year the model's brand was 
--    founded for all of the models from 1960. Include row(s)
--    for model(s) even if its brand is not in the Brands table.
--    (The year the brand was founded should be NULL if 
--    the brand is not in the Brands table.)

select models.brand_name, models.name, brands.founded from               
models left join brands                                                         
on (models.brand_name = brands.name) and models.year ='1960';

-- Part 2: Change the following queries according to the specifications. 
-- Include the answers to the follow up questions in a comment below your
-- query.

-- 1. Modify this query so it shows all brands that are not discontinued
-- regardless of whether they have any models in the models table.
-- before:
SELECT b.name,                                                                  
        b.founded,                                                                      
        m.name                                                                   
FROM brands AS b                                                                
    LEFT JOIN models AS m                                                            ON b.name = m.brand_name                                                      
WHERE b.discontinued IS NULL;

-- 2. Modify this left join so it only selects models that have brands in the Brands table.
-- before: 
    SELECT m.name,
           m.brand_name,
           b.founded
    FROM Models AS m
      JOIN Brands AS b
        ON b.name = m.brand_name;

-- followup question: In your own words, describe the difference between 
-- left joins and inner joins.
-- LEFT JOINS are used when we need to get all the rows from the master table regardless
-- of the second table. INNER JOINS are used when we need the elements that are 
-- related in both tables.

-- 3. Modify the query so that it only selects brands that don't have any models in the models table. 
-- (Hint: it should only show Tesla's row.)
-- before: 
    SELECT name,
           founded
    FROM brands
    WHERE brands.name NOT IN (select brand_name from models);

-- 4. Modify the query to add another column to the results to show 
-- the number of years from the year of the model until the brand becomes discontinued
-- Display this column with the name years_until_brand_discontinued.
-- before: 
    SELECT b.name,
           m.name,
           m.year,
           b.discontinued,
           (b.discontinued - m.year) as years_until_brand_discontinued 
    FROM models AS m
      LEFT JOIN brands AS b
        ON m.brand_name = b.name
    WHERE b.discontinued IS NOT NULL;




-- Part 3: Further Study

-- 1. Select the name of any brand with more than 5 models in the database.
select name from brands 
where name in 
    (select brand_name 
        from models group by brand_name having count(brand_name) > 5);
-- 2. Add the following rows to the Models table.

-- year    name       brand_name
-- ----    ----       ----------
-- 2015    Chevrolet  Malibu
-- 2015    Subaru     Outback
insert into models (brand_name, name, year)  values('Chevrolet', 'Malibu', '2015');
insert into models (brand_name, name, year)  values('Subaru', 'Outback', '2015');
-- 3. Write a SQL statement to crate a table called `Awards`
--    with columns `name`, `year`, and `winner`. Choose
--    an appropriate datatype and nullability for each column
--   (no need to do subqueries here).

create table Awards(
    NAME VARCHAR(30) NOT NULL,
    YEAR CHAR(10),
    WINNER_ID INT NOT NULL);

-- 4. Write a SQL statement that adds the following rows to the Awards table:

--   name                 year      winner_model_id
--   ----                 ----      ---------------
--   IIHS Safety Award    2015      the id for the 2015 Chevrolet Malibu
--   IIHS Safety Award    2015      the id for the 2015 Subaru Outback
insert into Awards (name, year, winner_id) values ('IIHS Safety Award', '2015', 49);
insert into Awards (name, year, winner_id) values ('IIHS Safety Award', '2015', 50);

-- 5. Using a subquery, select only the *name* of any model whose 
-- year is the same year that *any* brand was founded.
select models.name from models where year in 
(select year from brands where founded = models.year)





