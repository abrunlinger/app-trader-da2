SELECT DISTINCT(p.name) as name, a.price, a.rating, genres,primary_genre, a.content_rating
FROM app_store_apps as a
FULL OUTER JOIN play_store_apps as p
	ON p.name = a.name
 ORDER BY name