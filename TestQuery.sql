/* (12 + 12 * rating) = x (lifetime_months)
(10,000 * base price (min. 10,000) = y (cost)

(5,000x1 + 5,000x2) - y - 1,000(highest x) = (net_value)

name | price | rating | primary_genre | content_rating
name | price | rating | genres	      | content_rating*/

select name, price, rating, primary_genre, content_rating into apple_apps
from app_store_apps;

select name, price, rating, primary_genre, content_rating
from app_store_apps;

/* (12 + 12 * rating) = x
(10,000 * base price (min. 10,000) = y

(5,000x1 + 5,000x2) - y - 1,000(highest x) */

SELECT *, 
((5000 * lifetime_months) - cost - (1000 * lifetime_months)) as net_value 
FROM 
	(SELECT name, price, 
	CASE WHEN price > 1.00 THEN price * 10000
		ELSE 10000.00 END AS cost, 
		rating, 
 		(12 + (12 * rating))AS lifetime_months, 
 		primary_genre, 
 		content_rating
	FROM app_store_apps) AS AppData
ORDER BY net_value DESC;

select name, price, 
CASE WHEN price > 1.00 THEN price * 10000
	ELSE 10000.00 END AS cost, 
rating, (12 + (12 * rating))AS lifetime_months, primary_genre, content_rating
from app_store_apps;

/* SELECT [EmailAddress], [CustomerName] FROM [Customers] WHERE [EmailAddress] IN
  (SELECT [EmailAddress] FROM [Customers] GROUP BY [EmailAddress] HAVING COUNT(*) > 1) */
