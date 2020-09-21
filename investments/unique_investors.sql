-- Write a query that shows a company's name, "status" (found in the Companies table), 
-- and the number of unique investors in that company. Order by the number of investors 
-- from most to fewest. Limit to only companies in the state of New York.

WITH unique_investors AS (
SELECT 
inv.company_permalink as company_permalink_investments,
COUNT(DISTINCT investor_permalink) as unique_investors
FROM tutorial.crunchbase_investments as inv
-- this filters at the time of investment
WHERE inv.company_state_code = 'NY'
-- group by the permalink and not company name
-- two companies can have the same name but their 
-- permalinks may differ 
GROUP BY inv.company_permalink
)

SELECT 
SUBSTRING(c.permalink,10) as name,
c.status as status,
u.unique_investors
FROM tutorial.crunchbase_companies as c 
-- only returns those results that are common to both
INNER JOIN unique_investors as u 
ON c.permalink = u.company_permalink_investments
-- this filters on where the company is located now which
-- may have updated after the investment
-- WHERE c.state_code = 'NY'
ORDER BY 3 DESC;
