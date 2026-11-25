BULK INSERT raw.merchants
FROM 'C:\BI_Projects\digital_payments_bi\data\merchants.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO