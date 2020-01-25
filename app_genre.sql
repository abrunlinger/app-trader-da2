SELECT (
	CASE WHEN primary_genre ILIKE '%action%' OR primary_genre ILIKE '%adventure%' THEN 'Action/Adventure'
	WHEN primary_genre ILIKE '%art%' OR primary_genre ILIKE '%design%' THEN 'Art & Design'
	WHEN primary_genre ILIKE '%education%' THEN 'Educational'
	WHEN primary_genre ILIKE '%game%' OR primary_genre ILIKE '%puzzle%' THEN 'Games'
	WHEN primary_genre ILIKE '%social%' THEN 'Social'
	WHEN primary_genre ILIKE '%food%' THEN 'Food'
	WHEN primary_genre ILIKE '%shop%' OR primary_genre ILIKE '%catalogs%' THEN 'Shopping'
	WHEN primary_genre ILIKE '%entertain%' THEN 'Entertainment'
	WHEN primary_genre ILIKE '%sport%' THEN 'Sports'
	ELSE primary_genre END) AS genre_new
FROM app_store_apps AS a 
GROUP BY genre_new
UNION
SELECT (
	CASE WHEN genres ILIKE '%art%' OR genres ILIKE '%design%' THEN 'Art & Design'
	WHEN genres ILIKE '%education%' THEN 'Educational'
	WHEN genres ILIKE '%trivia%' OR genres ILIKE '%game%' OR genres ILIKE '%puzzle%' OR genres ILIKE '%racing%' OR genres ILIKE '%action%' OR genres ILIKE '%adventure%' THEN 'Games'
	WHEN genres ILIKE '%social%' THEN 'Social'
	WHEN genres ILIKE '%music%' THEN 'Music'
	WHEN genres ILIKE '%food%' THEN 'Food'
	WHEN genres ILIKE '%shop%' OR genres ILIKE '%catalogs%' THEN 'Shopping'
	WHEN genres ILIKE '%entertain%' THEN 'Entertainment'
	WHEN genres ILIKE '%sport%' THEN 'Sports' 
 	ELSE 'other' END) AS genre_new
FROM play_store_apps AS p 
GROUP BY genre_new
ORDER BY genre_new

