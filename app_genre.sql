SELECT 
DISTINCT(primary_genre) as gname,(
	CASE WHEN primary_genre ILIKE '%action%' OR primary_genre ILIKE '%adventure%' THEN 'Action/Adventure'
	WHEN primary_genre ILIKE '%art%' OR primary_genre ILIKE '%design%' THEN 'Art & Design'
	ELSE 'Other' END) AS genre_new
FROM app_store_apps AS a
UNION ALL
SELECT DISTINCT(genres) as gname,(
	CASE WHEN genres ILIKE '%action%' OR genres ILIKE '%adventure%' THEN 'Action/adventure'
	WHEN genres ILIKE '%art%' OR genres ILIKE '%design%' THEN 'Art & Design'
	ELSE 'Other' END) AS genre_new
FROM play_store_apps AS p 
ORDER BY gname

