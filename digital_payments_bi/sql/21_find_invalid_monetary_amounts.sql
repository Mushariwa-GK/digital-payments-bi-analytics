SELECT *
FROM raw.transactions
WHERE TRY_CAST(amount_sgd_equivalent AS DECIMAL(18,2)) <= 0
   OR TRY_CAST(fee_sgd_equivalent AS DECIMAL(18,2)) < 0;