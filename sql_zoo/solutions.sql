-- "More JOIN Operations" https://sqlzoo.net/wiki/More_JOIN_operations
/* 
movie: 
movie id 	title 	yr 	director 	budget 	gross

actor: 
actor id 	name

casting : 
movieid 	actorid 	ord
*/
-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in. 

SELECT m.title, a.name as 'leading actor'
FROM movie m
   JOIN casting c ON m.id=c.movieid
   JOIN actor a ON c.actorid=a.id
WHERE m.id IN (
  SELECT m.id FROM movie m 
   JOIN casting c ON m.id=c.movieid
   JOIN actor a ON c.actorid=a.id
  WHERE a.name='Julie Andrews') && c.ord = 1


/*
SELECT movieid FROM casting
WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews')
*/

-- 13 Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. 

SELECT name
FROM (
    SELECT a.name 
    FROM movie m
    JOIN casting c ON m.id = c.movieid
    JOIN actor a ON c.actorid = a.id
    WHERE c.ord = 1
) AS subquery
GROUP BY name
HAVING COUNT(name) >= 15


-- 14 List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 

SELECT m.title, COUNT(c.actorid) FROM movie m 
   JOIN casting c ON m.id=c.movieid
   JOIN actor a ON c.actorid=a.id
WHERE m.yr = 1978
GROUP BY title
ORDER BY COUNT(c.actorid) DESC, m.title


-- 15 
-- List all the people who have worked with 'Art Garfunkel'. 
-- Grab movies that have 'Art Garfunkel'
-- Grab the actors that are in those same movies

SELECT a.name FROM movie m 
   JOIN casting c ON m.id=c.movieid
   JOIN actor a ON c.actorid=a.id
WHERE m.title IN (SELECT m.title FROM movie m
   JOIN casting c ON m.id=c.movieid
   JOIN actor a on c.actorid=a.id
WHERE a.name = 'Art Garfunkel') && a.name != 'Art Garfunkel'