## 1. Introducing Joins ##

SELECT * FROM facts
    INNER JOIN cities ON facts.id = cities.facts_id
  LIMIT 10;

## 2. Understanding Inner Joins ##

SELECT c.*, f.name AS 'country_name' FROM facts AS f
  INNER JOIN cities AS c ON c.facts_id = f.id
 LIMIT 5;

## 3. Practicing Inner Joins ##

SELECT f.name AS 'country', c.name AS 'capital_city' FROM cities AS c
    INNER JOIN facts AS f ON f.id = c.facts_id
  WHERE c.capital = 1;

## 4. Left Joins ##

SELECT f.name AS 'country', f.population FROM facts AS f
LEFT JOIN cities AS c ON f.id = c.facts_id
WHERE c.facts_id IS NULL;



## 6. Finding the Most Populous Capital Cities ##

SELECT c.name AS 'capital_city', f.name AS 'country', c.population FROM cities AS c
	LEFT JOIN facts as f ON c.facts_id = f.id
  WHERE capital = 1
    ORDER BY 3 DESC
  LIMIT 10;

## 7. Combining Joins with Subqueries ##

SELECT c.name AS 'capital_city', f.name AS 'country', c.population FROM facts AS f
    INNER JOIN (SELECT * FROM cities
               WHERE (population > 10000000) AND (capital = 1)) AS c ON c.facts_id = f.id
    ORDER BY 3 DESC;
   

## 8. Challenge: Complex Query with Joins and Subqueries ##

SELECT 
    f.name AS 'country', 
    c.urban_pop, 
    f.population AS 'total_pop', 
    (CAST(c.urban_pop AS Float)/f.population) AS 'urban_pct' 
FROM facts AS f
INNER JOIN (SELECT 
            facts_id, SUM(population) AS 'urban_pop' 
            FROM cities
            GROUP BY 1) AS c ON c.facts_id = f.id
WHERE urban_pct > .5
ORDER BY 4 ASC;