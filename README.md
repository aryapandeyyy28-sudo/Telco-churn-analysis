# Telco Customer Churn & Revenue Intelligence Dashboard

## Overview

This project analyzes telecom customer data to understand customer churn, identify high-value customers, and generate revenue insights. The workflow includes data cleaning, SQL analysis, machine learning, and an interactive Power BI dashboard.

## Tech Stack

- Python (Pandas, NumPy, Scikit-learn)
- SQL (MySQL/PostgreSQL)
- Power BI
- Git & GitHub

## Project Workflow

- Cleaned and preprocessed the customer dataset.
- Created customer segments using RFM analysis and Customer Lifetime Value (CLV).
- Built a Random Forest model to predict customer churn.
- Used SQL to analyze customer behavior, revenue, and contract types.
- Developed a Power BI dashboard to visualize churn, revenue, and customer segments.

## Key Insights

- Customers with month-to-month contracts have the highest churn rate.
- High-value customers contribute the majority of recurring revenue.
- Retaining high-risk, high-value customers can improve overall revenue.

## Project Structure

```text
Telco-Churn-Analysis/
├── Data/
├── SQL/
├── notebooks/
├── scripts/
├── powerbi/
└── README.md
```

## How to Run

```bash
git clone https://github.com/yourusername/Telco-Churn-Analysis.git

cd Telco-Churn-Analysis

pip install -r requirements.txt

python scripts/process_data.py
```

## Author

Arya Pandey
