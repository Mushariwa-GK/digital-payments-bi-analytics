SELECT
    status,
    COUNT(*) AS total_transactions
FROM raw.transactions
GROUP BY status
ORDER BY total_transactions DESC;