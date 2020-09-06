-- 1. The table us_counties_2010 contains 3,143 rows, and us_counties_2000 has 3,141. 
-- That reflects the ongoing adjustments to county-level geographies that typically 
-- result from government decision making. Using appropriate joins and the NULL 
-- value, identify which counties don’t exist in both tables. For fun, search online 
-- to find out why they’re missing.

SELECT c2010.geo_name AS name_2010,
       c2010.state_us_abbreviation AS state_2010,
	   c2000.geo_name AS name_2000,
       c2000.state_us_abbreviation AS state_2000
FROM us_counties_2010 c2010 FULL OUTER JOIN us_counties_2000 c2000
ON c2010.state_fips = c2000.state_fips
   AND c2010.county_fips = c2000.county_fips
WHERE c2010.geo_name is NULL OR c2000.geo_name is NULL;


-- 2. Using either the median() or percentile_cont() functions in Chapter 5, determine 
-- the median of the percent change in county population.

CREATE TEMPORARY TABLE us_pop_temp AS
SELECT c2010.geo_name,
	c2010.state_us_abbreviation AS state,
	c2010.p0010001 AS pop_2010,
	c2000.p0010001 AS pop_2000,
	c2010.p0010001 - c2000.p0010001 AS raw_change,
	round( (CAST(c2010.p0010001 AS numeric(8,1)) - c2000.p0010001)
	/ c2000.p0010001 * 100, 1 ) AS pct_change
FROM us_counties_2010 c2010 INNER JOIN us_counties_2000 c2000
ON c2010.state_fips = c2000.state_fips
	AND c2010.county_fips = c2000.county_fips
	AND c2010.p0010001 <> c2000.p0010001
ORDER BY pct_change DESC;
	
SELECT 
	PERCENTILE_CONT(.5)
	WITHIN GROUP (ORDER BY pct_change)
FROM us_pop_temp;


-- 3. Which county had the greatest percentage loss of population between 2000 and 2010? 
-- Do you have any idea why? (Hint: A major weather event happened in 2005.)

SELECT *
FROM us_pop_temp
ORDER BY pct_change ASC
LIMIT 1;


-- After finishing we can drop the temporary table
DROP table us_pop_temp;
