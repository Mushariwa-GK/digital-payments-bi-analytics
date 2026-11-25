SELECT
    'Customer IDs' AS column_name,
    COUNT(*) AS invalid_integer_values
FROM raw.customers
WHERE TRY_CAST(
    NULLIF(TRIM(customer_id), '') AS INT
) IS NULL

UNION ALL

SELECT
    'Merchant IDs',
    COUNT(*)
FROM raw.merchants
WHERE TRY_CAST(
    NULLIF(TRIM(merchant_id), '') AS INT
) IS NULL

UNION ALL

SELECT
    'Transaction IDs',
    COUNT(*)
FROM raw.transactions
WHERE TRY_CAST(
    NULLIF(TRIM(transaction_id), '') AS INT
) IS NULL;