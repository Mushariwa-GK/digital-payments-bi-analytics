USE digital_payments;
GO

SELECT
    'Duplicate customer IDs' AS quality_check,
    COUNT(*) AS issue_count
FROM (
    SELECT customer_id
    FROM raw.customers
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS duplicates

UNION ALL

SELECT
    'Duplicate merchant IDs',
    COUNT(*)
FROM (
    SELECT merchant_id
    FROM raw.merchants
    GROUP BY merchant_id
    HAVING COUNT(*) > 1
) AS duplicates

UNION ALL

SELECT
    'Duplicate transaction IDs',
    COUNT(*)
FROM (
    SELECT transaction_id
    FROM raw.transactions
    GROUP BY transaction_id
    HAVING COUNT(*) > 1
) AS duplicates

UNION ALL

SELECT
    'Invalid transaction dates',
    COUNT(*)
FROM raw.transactions
WHERE TRY_CAST(
    NULLIF(TRIM(transaction_date), '') AS DATE
) IS NULL

UNION ALL

SELECT
    'Invalid signup dates',
    COUNT(*)
FROM raw.customers
WHERE TRY_CAST(
    NULLIF(TRIM(signup_date), '') AS DATE
) IS NULL

UNION ALL

SELECT
    'Invalid transaction amounts',
    COUNT(*)
FROM raw.transactions
WHERE TRY_CAST(
    NULLIF(TRIM(amount_sgd_equivalent), '')
    AS DECIMAL(18,2)
) IS NULL

UNION ALL

SELECT
    'Invalid fee amounts',
    COUNT(*)
FROM raw.transactions
WHERE TRY_CAST(
    NULLIF(TRIM(fee_sgd_equivalent), '')
    AS DECIMAL(18,2)
) IS NULL

UNION ALL

SELECT
    'Non-positive transaction amounts',
    COUNT(*)
FROM raw.transactions
WHERE TRY_CAST(
    amount_sgd_equivalent AS DECIMAL(18,2)
) <= 0

UNION ALL

SELECT
    'Negative fee amounts',
    COUNT(*)
FROM raw.transactions
WHERE TRY_CAST(
    fee_sgd_equivalent AS DECIMAL(18,2)
) < 0

UNION ALL

SELECT
    'Unmatched customer IDs',
    COUNT(*)
FROM raw.transactions AS t
LEFT JOIN raw.customers AS c
    ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL

UNION ALL

SELECT
    'Unmatched merchant IDs',
    COUNT(*)
FROM raw.transactions AS t
LEFT JOIN raw.merchants AS m
    ON t.merchant_id = m.merchant_id
WHERE m.merchant_id IS NULL

UNION ALL

SELECT
    'Invalid transaction statuses',
    COUNT(*)
FROM raw.transactions
WHERE LOWER(TRIM(status)) NOT IN (
    'successful', 'failed', 'pending'
)
OR NULLIF(TRIM(status), '') IS NULL;