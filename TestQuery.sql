/* (12 + 12 * rating) = x (lifetime_months)
(10,000 * base price (min. 10,000) = y (cost)

(5,000x1 + 5,000x2) - y - 1,000(highest x) = (net_value)

name | price | rating | primary_genre | content_rating
name | price | rating | genres	      | content_rating*/

select name, price, rating, primary_genre, content_rating
from app_store_apps;

select name, primary_genre
from app_store_apps
group by primary_genre;

select name, price, rating, genres, content_rating
from play_store_apps;

select name, genres
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

-- Group by App Layer
SELECT name, MAX (price), MAX (cost), rating, MAX (lifetime_months), genre_new, content_rating, 
CASE WHEN count 
FROM
	-- Net Value Layer
	(SELECT *, 
	((5000 * lifetime_months) - cost - (1000 * lifetime_months)) as net_value 
	FROM 
		-- Union Layer
		(SELECT distinct name, price, 
		CASE WHEN price > 1.00 THEN price * 10000
			ELSE 10000.00 END AS cost, 
			rating, 
			(12 + (24 * rating))AS lifetime_months, 
		CASE WHEN primary_genre ILIKE '%action%' OR primary_genre ILIKE '%adventure%' THEN 'Action/Adventure'
			WHEN primary_genre ILIKE '%art%' OR primary_genre ILIKE '%design%' OR primary_genre ILIKE '%photo%' THEN 'Art & Design'
			WHEN primary_genre ILIKE '%education%' OR primary_genre ILIKE'%learn%' THEN 'Educational'
			WHEN primary_genre ILIKE '%arcade%' OR primary_genre ILIKE '%trivia%' OR primary_genre ILIKE '%game%' OR primary_genre ILIKE '%puzzle%' OR primary_genre ILIKE '%racing%' OR primary_genre ILIKE '%action%' OR primary_genre ILIKE '%adventure%' THEN 'Games'
			WHEN primary_genre ILIKE '%social%' THEN 'Social'
			WHEN primary_genre ILIKE '%food%' THEN 'Food'
			WHEN primary_genre ILIKE '%shop%' OR primary_genre ILIKE '%catalogs%' THEN 'Shopping'
			WHEN primary_genre ILIKE '%entertain%' THEN 'Entertainment'
			WHEN primary_genre ILIKE '%sport%' THEN 'Sports'
			WHEN primary_genre ILIKE '%business' OR primary_genre ILIKE '%productivity' THEN 'Business'
			WHEN primary_genre ILIKE '%navigation%' THEN 'Travel'
			ELSE 'Other' END AS genre_new, 
		content_rating
		FROM app_store_apps
		UNION ALL
		SELECT distinct name, price, 
		CASE WHEN price > 1.00 THEN price * 10000
			ELSE 10000.00 END AS cost, 
		rating,
		(12 + (24 * rating))AS lifetime_months, 
		CASE WHEN genres ILIKE '%art%' OR genres ILIKE '%design%' THEN 'Art & Design'
			WHEN genres ILIKE '%education%' THEN 'Educational'
			WHEN genres ILIKE '%arcade%' OR genres ILIKE '%trivia%' OR genres ILIKE '%game%' OR genres ILIKE '%puzzle%' OR genres ILIKE '%racing%' OR genres ILIKE '%action%' OR genres ILIKE '%adventure%' THEN 'Games'
			WHEN genres ILIKE '%social%' THEN 'Social'
			WHEN genres ILIKE '%music%' THEN 'Music'
			WHEN genres ILIKE '%food%' THEN 'Food'
			WHEN genres ILIKE '%shop%' OR genres ILIKE '%catalogs%' THEN 'Shopping'
			WHEN genres ILIKE '%entertain%' THEN 'Entertainment'
			WHEN genres ILIKE '%sport%' THEN 'Sports'
			WHEN genres ILIKE '%business' OR genres ILIKE '%productivity' THEN 'Business'
			WHEN genres ILIKE '%navigation%' THEN 'Travel'
			ELSE 'Other' END AS genre_new, 
		content_rating
		FROM 
			--Cleanup Layer
			(SELECT distinct name, CAST(TRIM('$' FROM price) AS numeric) AS price,  
			Round
			 	((CASE WHEN rating IS NULL THEN 0 
				  ELSE rating END)/5,1)*5 as rating, 
			genres, 
			content_rating
			FROM play_store_apps) AS play_store_apps_clean
		) AS AppData
	ORDER BY net_value DESC)
GROUP BY name	
	
;

/* SELECT [EmailAddress], [CustomerName] FROM [Customers] WHERE [EmailAddress] IN
  (SELECT [EmailAddress] FROM [Customers] GROUP BY [EmailAddress] HAVING COUNT(*) > 1) */
  
