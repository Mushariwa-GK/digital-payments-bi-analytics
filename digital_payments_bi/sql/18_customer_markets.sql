SELECT
    market,
    COUNT(*) AS total_customers
FROM raw.customers
GROUP BY market
ORDER BY total_customers DESC;