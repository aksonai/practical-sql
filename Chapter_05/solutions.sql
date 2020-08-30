-- Here are three exercises to test your SQL math skills:

-- Write a SQL statement for calculating the area of a circle whose radius is 5 inches.
-- (If you don’t remember the formula, it’s an easy web search.) Do you need 
-- parentheses in your calculation? Why or why not?

select pi() * 5 ^ 2;

-- Using the 2010 Census county data, find out which New York state county has the 
-- highest percentage of the population that identified as “American Indian/Alaska 
-- Native Alone.” What can you learn about that county from online research that 
-- explains the relatively large proportion of American Indian population compared 
-- with other New York counties?
-- p0010001 = total poulation
-- p0010004 = am indian/alask native alone

select
	geo_name,
	(cast(p0010004 as numeric(8,1)) / p0010001) * 100
		as "pct_am_indian_alaska_native_alone"
from us_counties_2010
where state_us_abbreviation = 'NY'
order by pct_am_indian_alaska_native_alone desc
limit 1;


-- Was the 2010 median county population higher in California or New York?

select 
	percentile_cont(.5)
	within group (order by p0010001)
from us_counties_2010
where state_us_abbreviation = 'NY';

select 
	percentile_cont(.5)
	within group (order by p0010001)
from us_counties_2010
where state_us_abbreviation = 'CA';


