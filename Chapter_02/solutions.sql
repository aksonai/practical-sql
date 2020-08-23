-- TRY IT YOURSELF
-- Explore basic queries with these exercises:

-- The school district superintendent asks for a list of teachers in each school. Write a query
-- that lists the schools in alphabetical order along with teachers ordered by last name A–Z.

select *
from teachers
order by school asc, last_name asc;

-- Write a query that finds the one teacher whose first name starts with the letter S and who 
-- earns more than $40,000.

select *
from teachers
where first_name ilike 's%'
	and salary > 40000;

-- Rank teachers hired since January 1, 2010, ordered by highest paid to lowest.

select *
from teachers
where hire_date >= '2010-01-01'
order by salary desc;
