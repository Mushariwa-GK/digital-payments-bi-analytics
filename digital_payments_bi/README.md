# Digital Payments BI
Independent simulated portfolio project; not affiliated with ShopeePay. All records and SGD-equivalent amounts are synthetic, not actual FX conversions. Customer and merchant markets are independently assigned, allowing cross-market payments. The generator intentionally varies failure probabilities by method; trends are simulation artifacts, not real market evidence.

## Start
1. Install Python dependencies: `pip install pandas numpy` (CSV files already included).
2. Create a PostgreSQL database named digital_payments; run sql/01_schema.sql once.
3. Import the three CSVs with headers using pgAdmin in the order listed in the schema.
4. Run sql/02_analysis.sql one query at a time. SQL supplied as starter code, not executed against PostgreSQL here.
5. Connect Power BI Desktop to PostgreSQL. Relate customers and merchants to transactions using their IDs, one-to-many, single direction. Add a calendar table related to transaction_date.

## DAX starter measures
Create each separately:
```
Attempts = COUNTROWS(transactions)
Successes = CALCULATE([Attempts], transactions[status] = "Successful")
Success Rate = DIVIDE([Successes], [Attempts])
TPV = CALCULATE(SUM(transactions[amount_sgd_equivalent]), transactions[status] = "Successful")
Revenue = SUM(transactions[fee_sgd_equivalent])
Active Customers = CALCULATE(DISTINCTCOUNT(transactions[customer_id]), transactions[status] = "Successful")
```
Use monthly date context for monthly active customers. Build executive, payment reliability, customer engagement and merchant performance pages. Retention cohorts and the PBIX are future work.
