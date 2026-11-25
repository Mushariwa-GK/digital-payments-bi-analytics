SELECT
    'Customers' AS table_name,
    (SELECT COUNT(*) FROM raw.customers) AS raw_count,
    (SELECT COUNT(*) FROM clean.customers) AS clean_count

UNION ALL

SELECT
    'Merchants',
    (SELECT COUNT(*) FROM raw.merchants),
    (SELECT COUNT(*) FROM clean.merchants)

UNION ALL

SELECT
    'Transactions',
    (SELECT COUNT(*) FROM raw.transactions),
    (SELECT COUNT(*) FROM clean.transactions);