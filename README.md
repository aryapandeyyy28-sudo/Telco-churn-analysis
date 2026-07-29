# 📊 Telco Customer Churn Analysis And Revenue Forecasting

# Executive Customer Analytics & Revenue Intelligence Pipeline

## Project Overview
This project delivers an end-to-end data analytics pipeline to analyze customer churn, segment high-value accounts, and forecast revenue. Built with Python, SQL, and Power BI, it transforms raw customer data into actionable executive insights.

---

## Tech Stack
* Python (Pandas, NumPy, Scikit-Learn)
* SQL (PostgreSQL / MySQL)
* Power BI
* GitHub

---

## Data Pipeline & Methods
1. Data Cleaning & Feature Engineering: Standardized values, handled missing data, and created custom Customer Lifetime Value (CLV) and RFM value tiers.
2. Predictive Modeling: Built a Random Forest classification model in Python to calculate individual customer churn probabilities and identify high-risk accounts.
3. SQL Analytics: Executed queries to segment customers by contract type, revenue contributions, and tenure.
4. Power BI Dashboard: Created an interactive multi-page dashboard for revenue forecasting, churn driver analysis, and retention strategy simulation.

---

## Key Business Insights
* Month-to-month contracts account for the highest proportion of customer churn.
* High-value customer segments contribute to over 60% of total recurring revenue.
* Targeted retention campaigns focused on high-risk, high-value tiers yield the highest projected ROI.

---

## Repository Structure
├── Data/                 # Raw and processed customer datasets
├── SQL/                  # SQL queries for RFM analysis and customer segmentation
├── notebooks/            # Jupyter notebooks for EDA and machine learning
├── scripts/              # Python automation scripts for data preprocessing
├── powerbi/              # Power BI report files (.pbix)
└── README.md             # Project documentation
---

## How to Run

1. Clone the repository:
   git clone https://github.com/yourusername/Telco-Churn-Analysis.git

2. Navigate to the project folder:
   cd Telco-Churn-Analysis

3. Execute the data processing script:
   python scripts/process_data.py

---

## Author
Arya Pandey