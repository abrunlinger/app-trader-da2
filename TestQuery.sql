/* (12 + 12 * rating) = x (lifetime_months)
(10,000 * base price (min. 10,000) = y (cost)

(5,000x1 + 5,000x2) - y - 1,000(highest x) = (net_value)

name | price | rating | primary_genre | content_rating
name | price | rating | genres	      | content_rating*/

select name, price, rating, primary_genre, content_rating
from app_store_apps;

select name, price, rating, genres, content_rating
from play_store_apps;

select distinct genres
from play_store_apps;

select distinct primary_genre
from app_store_apps;

select name, primary_genre, genres
from app_store_apps
join play_store_apps
using (name)
order by primary_genre;

SELECT name,
CASE WHEN primary_genre is not null THEN primary_genre
WHEN primary_genre is null THEN ( select LEFT(genres, CHARINDEX(';', genres)-1) 
								 from play_store_apps 
								 where CHARINDEX (';', genres) > 0) as 
ELSE 'No Genre' END AS genre
FROM app_store_apps
FULL OUTER JOIN play_store_apps
using (name)
order by genre;

--SET MyText = LEFT(MyText, CHARINDEX(';', MyText) - 1)
--WHERE CHARINDEX(';', MyText) > 0
/* (12 + 12 * rating) = x
(10,000 * base price (min. 10,000) = y

(5,000x1 + 5,000x2) - y - 1,000(highest x) */

-- Net Value Layer
SELECT *, 
((5000 * lifetime_months) - cost - (1000 * lifetime_months)) as net_value 
FROM 
	-- Union Layer
	(SELECT distinct name, price, 
	CASE WHEN price > 1.00 THEN price * 10000
		ELSE 10000.00 END AS cost, 
		rating, 
 		(12 + (12 * rating))AS lifetime_months, 
 		primary_genre, 
 		content_rating
	FROM app_store_apps
	UNION ALL
	SELECT distinct name, price, 
	CASE WHEN price > 1.00 THEN price * 10000
		ELSE 10000.00 END AS cost, 
		rating,
 		(12 + (12 * rating))AS lifetime_months, 
 		genres, 
 		content_rating
	FROM 
	 	(SELECT distinct name, CAST(TRIM('$' FROM price) AS numeric) AS price,  
		ROUND(FLOOR(
			(CASE WHEN rating IS NULL THEN 0
			ELSE rating END)*2)/2,1) AS rating, 
 		genres, 
 		content_rating
		FROM play_store_apps) AS play_store_apps_clean
	) AS AppData
ORDER BY net_value DESC;



/* SELECT [EmailAddress], [CustomerName] FROM [Customers] WHERE [EmailAddress] IN
  (SELECT [EmailAddress] FROM [Customers] GROUP BY [EmailAddress] HAVING COUNT(*) > 1) */
  
SELECT Distinct primary_genre
from (SELECT distinct name, price, 
	CASE WHEN price > 1.00 THEN price * 10000
		ELSE 10000.00 END AS cost, 
		rating, 
 		(12 + (12 * rating))AS lifetime_months, 
 		primary_genre, 
 		content_rating
	FROM app_store_apps
	UNION ALL
	SELECT distinct name, price, 
	CASE WHEN price > 1.00 THEN price * 10000
		ELSE 10000.00 END AS cost, 
		rating,
 		(12 + (12 * rating))AS lifetime_months, 
 		genres, 
 		content_rating
	FROM 
	 	(SELECT distinct name, CAST(TRIM('$' FROM price) AS numeric) AS price,  
		ROUND(FLOOR(
			(CASE WHEN rating IS NULL THEN 0
			ELSE rating END)*2)/2,1) AS rating, 
 		genres, 
 		content_rating
		FROM play_store_apps) AS play_store_apps_clean
	) AS AppData
