/* (12 + 12 * rating) = x
(10,000 * base price (min. 10,000) = y

(5,000x1 + 5,000x2) - y - 1,000(highest x) 

name | price | rating | primary_genre | content_rating
name | price | rating | genres	      | content_rating*/

select name, price, rating, primary_genre, content_rating into apple_apps
from app_store_apps;

select name, price, rating, primary_genre, content_rating
from app_store_apps;

select name, price, rating, genres, content_rating
from play_store_apps;

select distinct (name), price, rating, genres, content_rating
from play_store_apps;

select name, price, rating, genres, content_rating

/* SELECT [EmailAddress], [CustomerName] FROM [Customers] WHERE [EmailAddress] IN
  (SELECT [EmailAddress] FROM [Customers] GROUP BY [EmailAddress] HAVING COUNT(*) > 1) */
