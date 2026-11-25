CREATE TABLE raw.transactions (
    transaction_id VARCHAR(50),
    transaction_date VARCHAR(50),
    customer_id VARCHAR(50),
    merchant_id VARCHAR(50),
    payment_method VARCHAR(100),
    status VARCHAR(50),
    amount_sgd_equivalent VARCHAR(50),
    fee_sgd_equivalent VARCHAR(50),
    failure_reason VARCHAR(255)
);
GO