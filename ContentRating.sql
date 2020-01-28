-- Content Rating
SELECT content_rating, count (content_rating) as count
FROM  
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
			ELSE primary_genre END AS genre_new, 
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
		 	WHEN genres ILIKE '%;%' THEN 'Other'
			ELSE genres END AS genre_new, 
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
	ORDER BY net_value DESC) AS test_data
GROUP BY content_rating
ORDER BY count DESC
