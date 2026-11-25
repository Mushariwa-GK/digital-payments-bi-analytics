SELECT
    status,
    COUNT(*) AS total_transactions
FROM clean.transactions
GROUP BY status
ORDER BY total_transactions DESC;