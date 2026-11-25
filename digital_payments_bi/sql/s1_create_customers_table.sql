USE digital_payments;
GO

CREATE TABLE clean.customers (
    customer_id INT PRIMARY KEY,
    market VARCHAR(100) NOT NULL,
    signup_date DATE NOT NULL
);
GO