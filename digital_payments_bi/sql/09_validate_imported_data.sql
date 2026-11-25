SELECT
    'Customers' AS table_name,
    COUNT(*) AS total_records
FROM raw.customers

UNION ALL

SELECT
    'Merchants',
    COUNT(*)
FROM raw.merchants

UNION ALL

SELECT
    'Transactions',
    COUNT(*)
FROM raw.transactions;