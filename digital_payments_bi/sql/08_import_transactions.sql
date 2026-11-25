BULK INSERT raw.transactions
FROM 'C:\BI_Projects\digital_payments_bi\data\transactions.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO