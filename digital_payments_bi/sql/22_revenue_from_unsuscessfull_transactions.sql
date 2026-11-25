SELECT *
FROM raw.transactions
WHERE LOWER(TRIM(status)) <> 'successful'
  AND TRY_CAST(fee_sgd_equivalent AS DECIMAL(18,2)) > 0;