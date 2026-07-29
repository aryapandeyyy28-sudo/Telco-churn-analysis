# db_connection.py
import pandas as pd
from sqlalchemy import create_engine

# Try to import connection settings from db_config
try:
    import db_config

    # Prefer CONNECTION_STRING if it exists
    if hasattr(db_config, "CONNECTION_STRING"):
        CONNECTION_STRING = db_config.CONNECTION_STRING
    else:
        # Build one manually if not defined
        CONNECTION_STRING = (
            f"mysql+mysqlconnector://{getattr(db_config, 'DB_USER', 'root')}:"
            f"{getattr(db_config, 'DB_PASSWORD', 'F0rceA!rking25')}@"
            f"{getattr(db_config, 'DB_HOST', '127.0.0.1')}:"
            f"{getattr(db_config, 'DB_PORT', '3306')}/"
            f"{getattr(db_config, 'DB_NAME', 'churn_project')}"
        )

except ImportError:
    raise ImportError("db_config.py not found. Please create it or adjust your import path.")

# Create SQLAlchemy engine
engine = create_engine(CONNECTION_STRING, echo=False)

def get_connection():
    """
    Return a SQLAlchemy connection object.
    Safely connects using the configuration from db_config.py.
    """
    try:
        conn = engine.connect()
        return conn
    except Exception as e:
        raise ConnectionError(f"Failed to connect to the database: {e}")

def query_to_df(query):
    """
    Execute a SQL query and return a pandas DataFrame.
    Automatically closes the connection after execution.
    """
    with get_connection() as conn:
        df = pd.read_sql(query, conn)
    return df

# Self-test
if __name__ == "__main__":
    try:
        df = query_to_df("SELECT COUNT(*) AS n FROM customers;")
        print("Successful.")
        print(df)
    except Exception as e:
        print("Connection test failed:", e)


