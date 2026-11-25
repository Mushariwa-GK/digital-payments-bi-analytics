BULK INSERT raw.customers
FROM 'C:\BI_Projects\digital_payments_bi\data\customers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO

