import pandas as pd
import numpy as np
from datetime import datetime
from db_config import engine

df = pd.read_sql("SELECT * FROM customers", engine)

rows = []
start_choice = pd.date_range("2018-01-01", "2022-12-01", freq="MS").to_pydatetime().tolist()

for _, r in df.iterrows():
    cust = r['customerID']
    tenure = int(r['tenure']) if pd.notnull(r['tenure'])  and r['tenure'] >0  else 1
    monthly = float(r['MonthlyCharges']) if pd.notnull(r['MonthlyCharges']) else 0.0
    start = np.random.choice(start_choice)
    dates = pd.date_range(start, periods=tenure, freq='MS')
    for d in dates:
        noise = np.random.normal(0, 0.03)
        amount = max(0.0, monthly * (1 + noise))
        rows.append({'customerID': cust, 'month' : d.date(), 'amount': round(amount, 2)})
        
df_revenue = pd.DataFrame(rows)
df_revenue.to_sql('revenue', engine , if_exists='append', index=False)
print("Revenue rows written:", len(df_revenue))