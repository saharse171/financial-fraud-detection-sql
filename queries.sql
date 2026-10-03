-- Financial Fraud Detection Database
-- Common queries for monitoring transactions and potential fraud.


-- 1. Show all customers and their accounts.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.account_id,
    a.account_type,
    a.balance,
    a.status
FROM customers AS c
JOIN accounts AS a
    ON c.customer_id = a.customer_id;


-- 2. Find large transactions.
SELECT
    transaction_id,
    account_id,
    amount,
    transaction_type,
    transaction_time
FROM transactions
WHERE amount >= 10000
ORDER BY amount DESC;


-- 3. Show high-risk fraud alerts.
SELECT
    alert_id,
    transaction_id,
    alert_type,
    risk_level,
    status
FROM fraud_alerts
WHERE risk_level = 'High'
ORDER BY created_at DESC;


-- 4. Show suspicious transactions with customer information.
SELECT *
FROM suspicious_transactions
ORDER BY amount DESC;


-- 5. Count fraud alerts by risk level.
SELECT
    risk_level,
    COUNT(*) AS alert_count
FROM fraud_alerts
GROUP BY risk_level
ORDER BY alert_count DESC;


-- 6. Find merchants associated with the most fraud alerts.
SELECT
    m.merchant_name,
    COUNT(fa.alert_id) AS alert_count
FROM merchants AS m
JOIN transactions AS t
    ON m.merchant_id = t.merchant_id
JOIN fraud_alerts AS fa
    ON t.transaction_id = fa.transaction_id
GROUP BY m.merchant_id, m.merchant_name
ORDER BY alert_count DESC;


-- 7. Find accounts with unusually high transaction activity.
SELECT
    account_id,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY account_id
HAVING COUNT(*) >= 5
ORDER BY transaction_count DESC;


-- 8. Find customers with fraud alerts.
SELECT DISTINCT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country
FROM customers AS c
JOIN accounts AS a
    ON c.customer_id = a.customer_id
JOIN transactions AS t
    ON a.account_id = t.account_id
JOIN fraud_alerts AS fa
    ON t.transaction_id = fa.transaction_id
ORDER BY c.customer_id;


-- 9. Show completed transactions above the average transaction amount.
SELECT
    transaction_id,
    account_id,
    amount,
    transaction_time
FROM transactions
WHERE status = 'Completed'
  AND amount > (
      SELECT AVG(amount)
      FROM transactions
      WHERE status = 'Completed'
  )
ORDER BY amount DESC;


-- 10. Show open high-risk alerts requiring investigation.
SELECT
    alert_id,
    transaction_id,
    alert_type,
    risk_level,
    created_at
FROM fraud_alerts
WHERE risk_level = 'High'
  AND status IN ('Open', 'Investigating')
ORDER BY created_at DESC;
