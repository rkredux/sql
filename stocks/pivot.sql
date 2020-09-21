WITH volume_by_month AS (SELECT 
year,
MAX(CASE WHEN month = 1 THEN 'JAN'
        WHEN month = 2 THEN 'FEB'
        WHEN month = 3 THEN 'MAR'
        WHEN month = 4 THEN 'APR'
        WHEN month = 5 THEN 'MAY'
        WHEN month = 6 THEN 'JUN'
        WHEN month = 7 THEN 'JUL'
        WHEN month = 8 THEN 'AUG'
        WHEN month = 9 THEN 'SEP'
        WHEN month = 10 THEN 'OCT'
        WHEN month = 11 THEN 'NOV'
        WHEN month = 12 THEN 'DEC'
        END) as month_name,
SUM(volume) as total_volume_of_shares_traded
FROM tutorial.aapl_historical_stock_price
GROUP BY month,year
)

SELECT 
year,
SUM(CASE WHEN month_name = 'JAN' THEN total_volume_of_shares_traded ELSE 0 END) as JAN, 
SUM(CASE WHEN month_name = 'FEB' THEN total_volume_of_shares_traded ELSE 0 END) as FEB, 
SUM(CASE WHEN month_name = 'MAR' THEN total_volume_of_shares_traded ELSE 0 END) as MAR,
SUM(CASE WHEN month_name = 'APR' THEN total_volume_of_shares_traded ELSE 0 END) as APR,
SUM(CASE WHEN month_name = 'MAY' THEN total_volume_of_shares_traded ELSE 0 END) as MAY,
SUM(CASE WHEN month_name = 'JUN' THEN total_volume_of_shares_traded ELSE 0 END) as JUN,
SUM(CASE WHEN month_name = 'JUL' THEN total_volume_of_shares_traded ELSE 0 END) as JUL,
SUM(CASE WHEN month_name = 'AUG' THEN total_volume_of_shares_traded ELSE 0 END) as AUG,
SUM(CASE WHEN month_name = 'SEP' THEN total_volume_of_shares_traded ELSE 0 END) as SEP,
SUM(CASE WHEN month_name = 'OCT' THEN total_volume_of_shares_traded ELSE 0 END) as OCT,
SUM(CASE WHEN month_name = 'NOV' THEN total_volume_of_shares_traded ELSE 0 END) as NOV,
SUM(CASE WHEN month_name = 'DEC' THEN total_volume_of_shares_traded ELSE 0 END) as DEC
FROM volume_by_month
GROUP BY year
ORDER BY year
