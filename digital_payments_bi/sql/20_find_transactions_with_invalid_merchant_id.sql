SELECT
    t.transaction_id,
    t.merchant_id
FROM raw.transactions AS t
LEFT JOIN raw.merchants AS m
    ON t.merchant_id = m.merchant_id
WHERE m.merchant_id IS NULL;