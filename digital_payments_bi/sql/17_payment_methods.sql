SELECT
    payment_method,
    COUNT(*) AS total_transactions
FROM raw.transactions
GROUP BY payment_method
ORDER BY total_transactions DESC;