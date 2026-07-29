-- 1. DATABASE & SCHEMAS SETUP
CREATE DATABASE IF NOT EXISTS churn_project; 
USE churn_project;

DROP TABLE IF EXISTS revenue;
DROP TABLE IF EXISTS customers;

-- Primary Customer Table
CREATE TABLE customers (
    customerID VARCHAR(50) PRIMARY KEY, 
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(50),
    InternetService VARCHAR(50),
    OnlineSecurity VARCHAR(50),
    OnlineBackup VARCHAR(50),
    DeviceProtection VARCHAR(50),
    TechSupport VARCHAR(50),
    StreamingTV VARCHAR(50),
    StreamingMovies VARCHAR(50),
    Contract VARCHAR(50),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(10)
);

-- Monthly Revenue History Table
CREATE TABLE revenue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customerID VARCHAR(50),
    month DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- 2. KEY METRICS & KPI ANALYSIS
-- Total Customer Count
SELECT COUNT(*) AS total_customers FROM customers;

-- Churn Distribution Count
SELECT 
    Churn, 
    COUNT(*) AS total_customers
FROM customers
GROUP BY Churn;

-- Average Monthly Charges by Churn Status
SELECT 
    Churn, 
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM customers
GROUP BY Churn;


-- 3. ANALYTICAL VIEWS FOR POWER BI

-- View 1: Monthly Customer Metrics
CREATE OR REPLACE VIEW customer_monthly_metrics AS
SELECT
    c.customerID,
    c.gender,
    c.tenure,
    c.MonthlyCharges,
    c.TotalCharges,
    c.Churn,
    r.month,
    r.amount AS monthly_revenue,
    cp.churn_probability
FROM customers c
LEFT JOIN revenue r
    ON c.customerID = r.customerID
LEFT JOIN churn_predictions cp
    ON c.customerID = cp.customerID;

-- View 2: Customer Lifetime Value (CLV) Summary
CREATE OR REPLACE VIEW clv_summary AS
SELECT
    c.customerID,
    MAX(c.tenure) AS tenure,
    ROUND(AVG(r.amount), 2) AS avg_monthly_revenue,
    ROUND(AVG(r.amount) * MAX(c.tenure), 2) AS lifetime_value,
    MAX(cp.churn_probability) AS churn_probability
FROM customers c
LEFT JOIN revenue r
    ON c.customerID = r.customerID
LEFT JOIN churn_predictions cp
    ON c.customerID = cp.customerID
GROUP BY c.customerID;

-- View 3: Intermediate Combined Forecast Data
CREATE OR REPLACE VIEW forecast_combined AS
SELECT 
    rf.ds,
    DATE(rf.ds) AS join_date,
    r.month AS revenue_month,
    r.amount AS actual_revenue,
    rf.yhat AS forecast_revenue,
    rf.yhat_lower AS lower_bound,
    rf.yhat_upper AS upper_bound
FROM revenue_forecast rf
LEFT JOIN revenue r
    ON DATE(rf.ds) = r.month;

-- View 4: Final Cleaned Monthly Revenue & Forecast Dashboard Source
CREATE OR REPLACE VIEW forecast_combined_clean AS
SELECT
    DATE(COALESCE(ds, revenue_month)) AS month,
    SUM(actual_revenue) AS actual_revenue,
    AVG(forecast_revenue) AS forecast_revenue,
    AVG(lower_bound) AS forecast_lower,
    AVG(upper_bound) AS forecast_upper
FROM forecast_combined
GROUP BY DATE(COALESCE(ds, revenue_month));


-- 4. VALIDATION CHECKPOINTS
SELECT * FROM customer_monthly_metrics LIMIT 5;
SELECT DISTINCT month FROM revenue ORDER BY month DESC LIMIT 5;
SELECT * FROM forecast_combined_clean LIMIT 5;