-- Identify companies that received investments from Great Britain following an investment from Japan

WITH jpn_investments AS (
SELECT 
company_permalink, 
company_name,
investor_country_code,
funded_at
FROM tutorial.crunchbase_investments as i
WHERE i.investor_country_code = 'JPN'
),

jpn_with_following_investments AS (SELECT
jpn.company_permalink jcp,
jpn.investor_country_code,
i.investor_country_code AS icc
FROM jpn_investments jpn
JOIN tutorial.crunchbase_investments as i
ON jpn.company_permalink = i.company_permalink 
AND jpn.funded_at < i.funded_at
),

gbr_followed_by_jpn AS (SELECT 
i.jcp, 
SUM(CASE WHEN i.icc = 'GBR' THEN 1 ELSE 0 END) AS count_of_investments_from_gbr_following_jpn
FROM jpn_with_following_investments  i
GROUP BY i.jcp
)

SELECT * 
FROM gbr_followed_by_jpn 
WHERE gbr_followed_by_jpn.count_of_investments_from_gbr_following_jpn > 0
ORDER by gbr_followed_by_jpn.count_of_investments_from_gbr_following_jpn DESC; 