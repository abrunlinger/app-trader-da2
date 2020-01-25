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