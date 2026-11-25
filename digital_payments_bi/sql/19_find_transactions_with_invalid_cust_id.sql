SELECT
    t.transaction_id,
    t.customer_id
FROM raw.transactions AS t
LEFT JOIN raw.customers AS c
    ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL;