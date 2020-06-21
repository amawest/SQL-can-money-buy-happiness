-- world happiness data
-- replace all periods and spaces with "_"

DROP TABLE WORLD_HAPPINESS; 

CREATE TABLE WORLD_HAPPINESS(
Country varchar(50) NOT NULL,
Happiness_Rank INT NOT NULL, 
Happiness_Score	DEC(10, 2) NOT NULL,
Whisker_high DEC(10, 2) NOT NULL,
Whisker_low	DEC(10, 2) NOT NULL, 
Economy__GDP_per_Capita_ DEC(10, 2) NOT NULL,
Family DEC(10, 2) NOT NULL,
Health__Life_Expectancy_ DEC(10, 2) NOT NULL,
Freedom DEC(10, 2) NOT NULL,
Generosity DEC(10, 2) NOT NULL,
Trust__Government_Corruption_ DEC(10, 2) NOT NULL,
Dystopia_Residual DEC(10, 2) NOT NULL,
PRIMARY KEY(Country)
);

------------------------------------------------------------------------------------------------------------

-- UN country data
-- replace all periods and spaces with "_"

DROP TABLE UN_DATA; 

CREATE TABLE UN_DATA(
Country VARCHAR(50) NOT NULL,
Region VARCHAR(50) NOT NULL,
Population INT NOT NULL,
Area__sq__mi__ INT NOT NULL,
Pop__Density__per_sq__mi__ DEC(10,2),
Coastline__coast_area_ratio_ DEC(10,2),
Net_migration DEC(10,2) NOT NULL,
Infant_mortality__per_1000_births_ DEC(10,2) NOT NULL,
GDP____per_capita_ INT NOT NULL,
Literacy____ DEC(10,2),
Phones__per_1000_ DEC(10,2),
Arable____ DEC(10,2),
Crops____ DEC(10,2),
Other____ DEC(10,2),
Climate INT,
Birthrate DEC(10,2),
Deathrate DEC(10,2),
Agriculture DEC(10,2),
Industry DEC(10,2),
Service DEC(10,2),
PRIMARY KEY(Country)
);

-- Check to make sure the data is in correctly; 
select * from UN_DATA limit 10; 
select * from WORLD_HAPPINESS limit 10;

------------------------------------------------------------------------------------------------------------

-- Combine the two datasets with join, using "country" as the anchor column between them 
-- let's create a "view" combining columns from both datasets 
-- a "view" is like a separate file we can treat just like a new, third dataset

drop view total_data; 
create view total_data as
select	
    UN.GDP____per_capita_ as gdp_per_capita,
    UN.Literacy____ as literacy,
    UN.Infant_mortality__per_1000_births_ as infant_mortality_per_1000,
    UN.Net_migration as net_migration,
	WH.*
from
	UN_DATA UN
join
	WORLD_HAPPINESS WH
on
	UN.country = WH.country; 
-- 140 countries were accurately matched up between the two

-- check that it worked;
select * from total_data;

------------------------------------------------------------------------------------------------------------

-- First, 10 happiest countries:

select country, happiness_score from total_data
	order by happiness_score desc
	fetch first
		10 rows only;

-- OR -- 

select country, happiness_score from total_data
	order by happiness_score desc
	limit 10; 
	
-- A: 
-- Norway	7.53	*
-- Denmark	7.52	*
-- Iceland	7.50	*
-- Switzerland	7.49	*
-- Finland	7.46
-- Netherlands	7.37
-- Canada	7.31
-- New Zealand	7.31
-- Australia	7.28
-- Sweden
	
-- Second, 10 countries with the highest GDP-per-capita:

select country, gdp_per_capita from total_data
	order by gdp_per_capita desc
	fetch first
		10 rows only;

-- A:
-- Luxembourg	55100	
-- Norway	37800	*
-- U.S. 	37800
-- Switzerland	32700	*
-- Denmark	31100 	*
-- Iceland	30900	*
-- Austria	30000
-- Canada	29800
-- Ireland	29600
-- Belgium	29100


-- I added a * when a country was on both lists
-- Findings: 4 out of the top 10 of both lists matched up
