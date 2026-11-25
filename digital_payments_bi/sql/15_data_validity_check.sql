SELECT *
FROM raw.transactions
WHERE TRY_CAST(transaction_date AS DATE) IS NULL
   OR TRY_CAST(amount_sgd_equivalent AS DECIMAL(18,2)) IS NULL
   OR TRY_CAST(fee_sgd_equivalent AS DECIMAL(18,2)) IS NULL;