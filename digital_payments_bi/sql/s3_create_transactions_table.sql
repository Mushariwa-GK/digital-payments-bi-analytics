CREATE TABLE clean.transactions (
    transaction_id INT PRIMARY KEY,
    transaction_date DATE NOT NULL,
    customer_id INT NOT NULL,
    merchant_id INT NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL,
    amount_sgd_equivalent DECIMAL(18,2) NOT NULL,
    fee_sgd_equivalent DECIMAL(18,2) NOT NULL,
    failure_reason VARCHAR(255),

    CONSTRAINT FK_transactions_customer
        FOREIGN KEY (customer_id)
        REFERENCES clean.customers(customer_id),

    CONSTRAINT FK_transactions_merchant
        FOREIGN KEY (merchant_id)
        REFERENCES clean.merchants(merchant_id),

    CONSTRAINT CHK_transaction_amount
        CHECK (amount_sgd_equivalent > 0),

    CONSTRAINT CHK_fee_amount
        CHECK (fee_sgd_equivalent >= 0),

    CONSTRAINT CHK_transaction_status
        CHECK (status IN (
            'Successful', 'Failed', 'Pending'
        )),

    CONSTRAINT CHK_unsuccessful_fee
        CHECK (
            status = 'Successful'
            OR fee_sgd_equivalent = 0
        )
);
GO