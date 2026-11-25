SELECT
    COUNT(*) AS total_records,

    SUM(CASE
        WHEN NULLIF(TRIM(transaction_id), '') IS NULL
        THEN 1 ELSE 0
    END) AS missing_transaction_id,

    SUM(CASE
        WHEN NULLIF(TRIM(customer_id), '') IS NULL
        THEN 1 ELSE 0
    END) AS missing_customer_id,

    SUM(CASE
        WHEN NULLIF(TRIM(merchant_id), '') IS NULL
        THEN 1 ELSE 0
    END) AS missing_merchant_id,

    SUM(CASE
        WHEN NULLIF(TRIM(transaction_date), '') IS NULL
        THEN 1 ELSE 0
    END) AS missing_transaction_date,

    SUM(CASE
        WHEN NULLIF(TRIM(amount_sgd_equivalent), '') IS NULL
        THEN 1 ELSE 0
    END) AS missing_amount,

    SUM(CASE
        WHEN NULLIF(TRIM(status), '') IS NULL
        THEN 1 ELSE 0
    END) AS missing_status

FROM raw.transactions;