SELECT
    t.transaction_id,
    t.customer_id,
    t.transaction_date,
    c.signup_date
FROM raw.transactions AS t
INNER JOIN raw.customers AS c
    ON t.customer_id = c.customer_id
WHERE TRY_CAST(t.transaction_date AS DATE)
    < TRY_CAST(c.signup_date AS DATE);