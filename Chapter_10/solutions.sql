-- Test your new skills with the following questions:

-- In Listing 10-2, the correlation coefficient, or r value, of the variables pct_bachelors_higher and median_hh_income was 
-- about .68. Write a query using the same data set to show the correlation between pct_masters_higher and median_hh_income. 
-- Is the r value higher or lower? What might explain the difference?

SELECT 
	corr(median_hh_income, pct_bachelors_higher) AS bachelors_income_r,
	corr(median_hh_income, pct_masters_higher) AS bachelors_income_r
FROM acs_2011_2015_stats;


-- In the FBI crime data, which cities with a population of 500,000 or more have the highest rates of motor vehicle thefts 
-- (column motor_vehicle_theft)? Which have the highest violent crime rates (column violent_crime)?

-- motor vehicle thefts
SELECT
    city,
    st,
    population,
    motor_vehicle_theft,
    round((motor_vehicle_theft::numeric / population) * 1000, 2) AS vehicle_theft_per_1000
FROM fbi_crime_data_2015
WHERE population >= 500000
ORDER BY vehicle_theft_per_1000 DESC;

-- violent crimes
SELECT
    city,
    st,
    population,
    violent_crime,
    round((violent_crime::numeric / population) * 1000, 2) AS violent_crime_per_1000
FROM fbi_crime_data_2015
WHERE population >= 500000
ORDER BY violent_crime_per_1000 DESC;


-- As a bonus challenge, revisit the libraries data in the table pls_fy2014_pupld14a in Chapter 8. Rank library agencies based 
-- on the rate of visits per 1,000 population (column popu_lsa), and limit the query to agencies serving 250,000 people or more.

SELECT
	stabr,
	libname,
	visits,
	popu_lsa,
	(visits::numeric / popu_lsa) * 1000 as visits_per_1000,
	rank() OVER (ORDER BY (visits::numeric / popu_lsa) * 1000 DESC)
FROM pls_fy2014_pupld14a
WHERE popu_lsa > 250000;
