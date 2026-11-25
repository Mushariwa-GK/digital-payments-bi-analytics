WITH raw_totals AS (
    SELECT
        SUM(CAST(amount_sgd_equivalent
            AS DECIMAL(18,2))) AS total_amount,

        SUM(CAST(fee_sgd_equivalent
            AS DECIMAL(18,2))) AS total_fee

    FROM raw.transactions
),
clean_totals AS (
    SELECT
        SUM(amount_sgd_equivalent) AS total_amount,
        SUM(fee_sgd_equivalent) AS total_fee
    FROM clean.transactions
)
SELECT
    r.total_amount AS raw_total_amount,
    c.total_amount AS clean_total_amount,
    r.total_amount - c.total_amount AS amount_difference,

    r.total_fee AS raw_total_fee,
    c.total_fee AS clean_total_fee,
    r.total_fee - c.total_fee AS fee_difference

FROM raw_totals AS r
CROSS JOIN clean_totals AS c;