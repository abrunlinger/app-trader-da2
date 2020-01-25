SELECT DISTINCT(name),
price as price, 
ROUND(FLOOR(
	(CASE WHEN rating IS NULL THEN 0
	ELSE rating END)
	*2)/2,1) as rating, 
primary_genre,
content_rating
FROM app_store_apps AS a
UNION ALL
SELECT DISTINCT(name),
CAST(TRIM('$' FROM price) AS numeric),
ROUND(FLOOR((
	CASE WHEN rating IS NULL THEN 0
	ELSE rating END)*2)/2,1) as rating, 
genres,
content_rating 
FROM play_store_apps AS p
	WHERE price IS NOT NULL 
ORDER BY rating  DESC


