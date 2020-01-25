SELECT DISTINCT(a.name),
a.price as price,
ROUND(FLOOR(a.rating*2)/2,1) as rating, 
primary_genre,
a.content_rating
FROM app_store_apps AS a
UNION ALL
SELECT DISTINCT(p.name),
CAST(TRIM('$' FROM p.price) AS numeric),
ROUND(FLOOR(p.rating*2)/2,1) as rating, 
genres,
p.content_rating 
FROM play_store_apps AS p
	WHERE p.price IS NOT NULL 
ORDER BY rating DESC

