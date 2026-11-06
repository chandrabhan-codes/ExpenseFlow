-- ====================================================================
-- ExpenseFlow: Day 6 PostgreSQL Practicals & Practice Queries
-- ====================================================================

-- Task 2: Create the Database
-- English: Creates a new isolated database named expenseflow.
-- Hindi: 'expenseflow' naam ka ek naya aur alag database banata hai.
CREATE DATABASE expenseflow;

-- Connect to expenseflow database in psql:
-- \c expenseflow

-- ====================================================================
-- Task 3 & 4: Create Table with Primary Key & Constraints
-- ====================================================================
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    amount NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
    type VARCHAR(10) NOT NULL CHECK (type IN ('income', 'expense')),
    category VARCHAR(50) NOT NULL,
    date DATE NOT NULL DEFAULT CURRENT_DATE,
    payment_method VARCHAR(50) DEFAULT 'UPI',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ====================================================================
-- Task 5: Insert Sample Income and Expense Records
-- ====================================================================
INSERT INTO transactions (name, amount, type, category, date, payment_method)
VALUES
    ('TechCorp Solutions', 30000.00, 'income', 'Salary', '2026-11-01', 'Direct Deposit'),
    ('FreshMart Supermarket', 1850.00, 'expense', 'Groceries', '2026-11-03', 'UPI'),
    ('Tata Power Electricity', 1200.00, 'expense', 'Utilities', '2026-11-03', 'Net Banking'),
    ('Amazon India', 950.00, 'expense', 'Shopping', '2026-11-04', 'Credit Card'),
    ('Blue Tokai Coffee Roasters', 450.00, 'expense', 'Food & Dining', '2026-11-04', 'UPI'),
    ('Netflix & Spotify', 550.00, 'expense', 'Entertainment', '2026-11-05', 'Auto Debit');

-- ====================================================================
-- Task 6: Practise SELECT, WHERE and ORDER BY
-- ====================================================================

-- 6.1: View all transactions
SELECT * FROM transactions;

-- 6.2: View only Expenses
SELECT name, amount, category, date
FROM transactions
WHERE type = 'expense';

-- 6.3: View transactions where amount is greater than ₹1,000
SELECT name, amount, type, category
FROM transactions
WHERE amount > 1000;

-- 6.4: Sort transactions by date (newest first) and amount (highest first)
SELECT name, amount, type, date
FROM transactions
ORDER BY date DESC, amount DESC;

-- ====================================================================
-- Task 7: Practise UPDATE and DELETE Safely
-- ====================================================================

-- 7.1: Safe UPDATE: Update amount for transaction with ID 5
UPDATE transactions
SET amount = 500.00, name = 'Blue Tokai Coffee & Pastry'
WHERE id = 5;

-- 7.2: Safe DELETE: Delete specific transaction with ID 6
DELETE FROM transactions
WHERE id = 6;

-- ====================================================================
-- Task 8: Calculate Income, Expenses and Balance using SQL
-- ====================================================================
SELECT
    COALESCE(SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END), 0) AS total_income,
    COALESCE(SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END), 0) AS total_expenses,
    COALESCE(SUM(CASE WHEN type = 'income' THEN amount ELSE -amount END), 0) AS remaining_balance
FROM transactions;

