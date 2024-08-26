## 2. Joining Three Tables ##

SELECT il.track_id, t.name 'track_name', mt.name 'track_type', il.unit_price, il.quantity FROM invoice_line 'il'
INNER JOIN track 't' ON t.track_id = il.track_id
INNER JOIN media_type 'mt' ON t.media_type_id = mt.media_type_id
WHERE invoice_id = 4;

## 3. Joining More Than Three Tables ##

SELECT il.track_id, t.name 'track_name', a.name 'artist_name', mt.name 'track_type', il.unit_price, il.quantity FROM invoice_line 'il'
INNER JOIN track 't' ON t.track_id = il.track_id
INNER JOIN media_type 'mt' ON mt.media_type_id = t.media_type_id
INNER JOIN album 'alb' ON alb.album_id = t.album_id
INNER JOIN artist 'a' ON a.artist_id = alb.artist_id
WHERE il.invoice_id = 4;

## 4. Combining Multiple Joins with Subqueries ##

SELECT alb_trk.album_title 'album', alb_trk.artist, COUNT(*) 'tracks_purchased'
FROM invoice_line 'il'
INNER JOIN (SELECT alb.title 'album_title', t.track_id, a.name 'artist'
FROM album 'alb'
            INNER JOIN artist 'a' ON alb.artist_id = a.artist_id
            INNER JOIN track 't' ON alb.album_id = t.album_id
            ) 'alb_trk' ON il.track_id = alb_trk.track_id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5;

## 5. Self-joins ##

SELECT e1.first_name || ' ' || e1.last_name 'employee_name',
       e1.title 'employee_title',
       e2.first_name || ' ' || e2.last_name 'supervisor_name',
       e2.title 'supervisor_title'
FROM employee 'e1'
LEFT JOIN employee 'e2' ON e1.reports_to = e2.employee_id
ORDER BY employee_name ASC;

## 6. Pattern Matching Using Like ##

SELECT first_name,
       last_name,
       phone
FROM customer
WHERE first_name LIKE '%Belle%';

## 7. Revisiting CASE ##

SELECT c.first_name || ' ' || c.last_name 'customer_name',
       COUNT(i.invoice_id) 'number_of_purchases',
       SUM(i.total) 'total_spent',
       CASE 
       WHEN SUM(i.total) < 40 THEN 'small spender'
            WHEN SUM(i.total) > 100 THEN 'big spender'
            WHEN (SUM(i.total) > 40) AND (SUM(i.total)                    
            <= 100) THEN 'regular'
            END
            AS 'customer_category'
       FROM customer 'c'
INNER JOIN invoice 'i' ON c.customer_id = i.customer_id
GROUP BY customer_name
ORDER BY customer_name;
       