SELECT
    merchant_id,
    COUNT(*) AS duplicate_count
FROM raw.merchants
GROUP BY merchant_id
HAVING COUNT(*) > 1;