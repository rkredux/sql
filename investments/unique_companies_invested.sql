-- Write a query that lists investors based on the number of companies in which they are invested. 
-- Include a row for companies with no investor, and order from most companies to least.

WITH unique_companies_invested AS (
SELECT 
inv.investor_permalink as investor_permalink,
COUNT(DISTINCT company_permalink) as unique_companies_invested
FROM tutorial.crunchbase_investments as inv
GROUP BY inv.investor_permalink
)

SELECT 
SUBSTRING(c.permalink,10) as name,
u.unique_companies_invested
FROM tutorial.crunchbase_companies as c 
INNER JOIN unique_companies_invested as u 
ON c.permalink = u.investor_permalink
ORDER BY 2 DESC;
