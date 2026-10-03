-- Financial Fraud Detection Database
-- Stores customers, accounts, merchants, locations,
-- financial transactions, and potential fraud alerts.

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    country TEXT NOT NULL,
    occupation TEXT,
    created_at TEXT NOT NULL
);

CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    account_type TEXT NOT NULL CHECK (
        account_type IN ('Checking', 'Savings', 'Credit')
    ),
    balance NUMERIC NOT NULL CHECK (balance >= 0),
    opened_at TEXT NOT NULL,
    status TEXT NOT NULL CHECK (
        status IN ('Active', 'Frozen', 'Closed')
    ),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE merchants (
    merchant_id INTEGER PRIMARY KEY,
    merchant_name TEXT NOT NULL,
    category TEXT NOT NULL,
    country TEXT NOT NULL
);

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY,
    city TEXT NOT NULL,
    country TEXT NOT NULL
);

CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    account_id INTEGER NOT NULL,
    merchant_id INTEGER,
    location_id INTEGER NOT NULL,
    amount NUMERIC NOT NULL CHECK (amount > 0),
    transaction_type TEXT NOT NULL CHECK (
        transaction_type IN ('Purchase', 'Transfer', 'Withdrawal', 'Deposit')
    ),
    transaction_time TEXT NOT NULL,
    status TEXT NOT NULL CHECK (
        status IN ('Completed', 'Pending', 'Declined')
    ),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    FOREIGN KEY (merchant_id) REFERENCES merchants(merchant_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE fraud_alerts (
    alert_id INTEGER PRIMARY KEY,
    transaction_id INTEGER NOT NULL,
    alert_type TEXT NOT NULL,
    risk_level TEXT NOT NULL CHECK (
        risk_level IN ('Low', 'Medium', 'High')
    ),
    created_at TEXT NOT NULL,
    status TEXT NOT NULL CHECK (
        status IN ('Open', 'Investigating', 'Resolved')
    ),
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
);

-- Indexes improve searches frequently used for fraud analysis.

CREATE INDEX idx_transactions_account
ON transactions(account_id);

CREATE INDEX idx_transactions_time
ON transactions(transaction_time);

CREATE INDEX idx_transactions_amount
ON transactions(amount);

CREATE INDEX idx_fraud_alerts_risk
ON fraud_alerts(risk_level);

-- View for investigators reviewing potentially suspicious activity.

CREATE VIEW suspicious_transactions AS
SELECT
    t.transaction_id,
    c.customer_id,
    c.first_name,
    c.last_name,
    t.amount,
    t.transaction_type,
    t.transaction_time,
    fa.alert_type,
    fa.risk_level,
    fa.status AS alert_status
FROM transactions AS t
JOIN accounts AS a
    ON t.account_id = a.account_id
JOIN customers AS c
    ON a.customer_id = c.customer_id
JOIN fraud_alerts AS fa
    ON t.transaction_id = fa.transaction_id
WHERE fa.risk_level IN ('Medium', 'High');
