-- Continue your exploration of data import and export with these exercises. Remember 
-- to consult the PostgreSQL documentation at 
-- https://www.postgresql.org/docs/current/static/sql-copy.html for hints:

-- Write a WITH statement to include with COPY to handle the import of an imaginary 
-- text file whose first couple of rows look like this:
-- id:movie:actor
-- 50:#Mission: Impossible#:Tom Cruise

create table movie_stars (
	id int,
	movie varchar(64),
	actor varchar(64)
);

copy movie_stars
from 'C:\Users\joni\Desktop\practical-sql\Chapter_04\movies.csv'
with (format csv, header, delimiter ':', quote '#');


-- Using the table us_counties_2010 you created and filled in this chapter, export to 
-- a CSV file the 20 counties in the United States that have the most housing units. 
-- Make sure you export only each county’s name, state, and number of housing units. 
-- (Hint: Housing units are totaled for each county in the column 
-- housing_unit_count_100_percent.)

copy (
	select geo_name, state_us_abbreviation, housing_unit_count_100_percent from us_counties_2010
	order by housing_unit_count_100_percent desc
	limit 20
	)
to 'C:\Users\joni\Desktop\practical-sql\Chapter_04\counties_housing_units.csv'
with (format csv, header, delimiter '|');
