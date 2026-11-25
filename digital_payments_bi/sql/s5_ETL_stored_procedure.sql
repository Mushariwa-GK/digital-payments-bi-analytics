USE digital_payments;
GO

CREATE OR ALTER PROCEDURE clean.usp_load_silver
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        -- =====================================
        -- 1. Clear existing Silver data
        -- =====================================

        DELETE FROM clean.transactions;
        DELETE FROM clean.customers;
        DELETE FROM clean.merchants;

        -- =====================================
        -- 2. Transform and load customers
        -- =====================================

        INSERT INTO clean.customers (
            customer_id,
            market,
            signup_date
        )
        SELECT
            CAST(customer_id AS INT),
            NULLIF(TRIM(market), ''),
            CAST(signup_date AS DATE)
        FROM raw.customers;

        -- =====================================
        -- 3. Transform and load merchants
        -- =====================================

        INSERT INTO clean.merchants (
            merchant_id,
            category,
            market
        )
        SELECT
            CAST(merchant_id AS INT),
            NULLIF(TRIM(category), ''),
            NULLIF(TRIM(market), '')
        FROM raw.merchants;

        -- =====================================
        -- 4. Transform and load transactions
        -- =====================================

        INSERT INTO clean.transactions (
            transaction_id,
            transaction_date,
            customer_id,
            merchant_id,
            payment_method,
            status,
            amount_sgd_equivalent,
            fee_sgd_equivalent,
            failure_reason
        )
        SELECT
            CAST(transaction_id AS INT),
            CAST(transaction_date AS DATE),
            CAST(customer_id AS INT),
            CAST(merchant_id AS INT),

            NULLIF(TRIM(payment_method), ''),

            CASE LOWER(TRIM(status))
                WHEN 'successful' THEN 'Successful'
                WHEN 'failed' THEN 'Failed'
                WHEN 'pending' THEN 'Pending'
                ELSE NULL
            END,

            CAST(amount_sgd_equivalent AS DECIMAL(18,2)),
            CAST(fee_sgd_equivalent AS DECIMAL(18,2)),

            NULLIF(
                TRIM(REPLACE(failure_reason, CHAR(13), '')),
                ''
            )

        FROM raw.transactions;

        -- =====================================
        -- 5. Validate record counts
        -- =====================================

        IF (SELECT COUNT(*) FROM raw.customers)
           <> (SELECT COUNT(*) FROM clean.customers)
        BEGIN
            THROW 50001, 'Customer count mismatch.', 1;
        END;

        IF (SELECT COUNT(*) FROM raw.merchants)
           <> (SELECT COUNT(*) FROM clean.merchants)
        BEGIN
            THROW 50002, 'Merchant count mismatch.', 1;
        END;

        IF (SELECT COUNT(*) FROM raw.transactions)
           <> (SELECT COUNT(*) FROM clean.transactions)
        BEGIN
            THROW 50003, 'Transaction count mismatch.', 1;
        END;

        -- =====================================
        -- 6. Validate registration dates
        -- =====================================

        IF EXISTS (
            SELECT 1
            FROM clean.transactions AS t
            INNER JOIN clean.customers AS c
                ON t.customer_id = c.customer_id
            WHERE t.transaction_date < c.signup_date
        )
        BEGIN
            THROW 50004, 'Transaction before signup date.', 1;
        END;

        COMMIT TRANSACTION;

        PRINT 'Silver layer loaded successfully.';

    END TRY

    BEGIN CATCH

        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        PRINT 'Silver layer load failed.';

        THROW;

    END CATCH;

END;
GO