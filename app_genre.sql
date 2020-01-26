SELECT (
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
	ELSE 'Other' END) AS genre_new
FROM app_store_apps AS a 
GROUP BY genre_new
UNION
SELECT (
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
 	ELSE 'Other' END) AS genre_new
FROM play_store_apps AS p 
GROUP BY genre_new
ORDER BY genre_new

