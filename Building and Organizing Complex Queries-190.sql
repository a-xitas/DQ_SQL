## 3. The With Clause ##

WITH 'playlist_info' AS
    (
     SELECT
        p.playlist_id,
        p.name 'playlist_name',
        t.name,
        (t.milliseconds/1000) 'length_seconds'
        FROM playlist 'p'
        LEFT JOIN playlist_track 'pt' ON p.playlist_id = pt.playlist_id
        LEFT JOIN track 't' ON pt.track_id = t.track_id
     )
SELECT playlist_id,
       playlist_name,
       COUNT(name) 'number_of_tracks',
       SUM(length_seconds) 'length_seconds'
       FROM playlist_info
GROUP BY playlist_id
ORDER BY playlist_id ASC;

## 4. Creating Views ##

CREATE VIEW chinook.customer_gt_90_dollars AS
    SELECT customer.* FROM chinook.customer
INNER JOIN (SELECT * FROM invoice
            GROUP BY customer_id
            HAVING SUM(total) > 90) 'i' ON customer.customer_id = i.customer_id;
    
SELECT * FROM chinook.customer_gt_90_dollars;




## 5. Combining Rows with Union ##

SELECT *
FROM customer_usa

UNION

SELECT *
FROM customer_gt_90_dollars;

## 6. Combining Rows Using Intersect and Except ##

WITH customers_usa_gt_90 AS
    (
     SELECT * FROM customer_usa

     INTERSECT

     SELECT * FROM customer_gt_90_dollars
    )

SELECT
    e.first_name || " " || e.last_name employee_name,
    COUNT(c.customer_id) customers_usa_gt_90
FROM employee e
LEFT JOIN customers_usa_gt_90 c ON c.support_rep_id = e.employee_id
WHERE e.title = 'Sales Support Agent'
GROUP BY 1 ORDER BY 1;

## 7. Multiple Named Subqueries ##

WITH 
'c_india' AS
    (
     SELECT * FROM customer
     WHERE country = 'India'
    ),
'i_total' AS
    (
     SELECT SUM(total) 'total', customer_id FROM invoice
     GROUP BY customer_id
    )
    

SELECT 
    c_india.first_name ||' '||c_india.last_name 'customer_name',
    indi_total.total 'total_purchases'
FROM c_india
INNER JOIN i_total 'indi_total' ON c_india.customer_id = indi_total.customer_id
ORDER BY customer_name;

        

## 8. Challenge: Each Country's Best Customer ##

WITH 
'customer_name_country' AS
    (
     SELECT
        country,
        first_name ||' '|| last_name 'customer_name',
        customer_id
     FROM customer
     ),
'purchases' AS 
    (
     SELECT
        SUM(total) 'total',
        customer_id
     FROM invoice
     GROUP BY customer_id
    )
    
SELECT
    country,
    customer_name,
    total 'total_purchased'
FROM customer_name_country
INNER JOIN purchases 'p' ON customer_name_country.customer_id = p.customer_id
GROUP BY country
HAVING total_purchased = MAX(total_purchased)
ORDER BY country;
     