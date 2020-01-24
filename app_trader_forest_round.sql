SELECT DISTINCT(p.name), p.price as price, ROUND(FLOOR(p.rating*2)/2,1) as rating, genres, primary_genre, a.content_rating
FROM app_store_apps AS a
FULL OUTER JOIN play_store_apps AS p
	ON p.name = a.name 
	WHERE p.price IS NOT NULL 
ORDER BY rating 