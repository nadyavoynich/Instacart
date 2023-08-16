import pandas as pd
from sqlalchemy import create_engine
import pymysql
import logging
import json

# Load credentials from the JSON file
with open("credentials.json", "r") as file:
    creds = json.load(file)

# Set Up Logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Enable PyMySQL Logging:
pymysql_logger = logging.getLogger('pymysql')
pymysql_logger.setLevel(logging.INFO)

# List of CSV files and corresponding table names
csv_files = ['data/aisles.csv', 'data/departments.csv', 'data/order_products__prior.csv',
             'data/order_products__train.csv', 'data/orders.csv', 'data/products.csv', 'data/sample_submission.csv']
table_names = ['aisles', 'departments', 'orders_prior', 'orders_train', 'orders', 'products', 'sample_submission']

# Create a SQL database connection
pymysql.install_as_MySQLdb()
database_url = f'mysql+pymysql://{creds["user_name"]}:{creds["user_password"]}@{creds["host_name"]}:3306/{creds["database_name"]}'
engine = create_engine(database_url, echo=True)

for i, table_name in enumerate(table_names):
    print(f"Loading {table_name}")
    # Read CSV file into a Pandas DataFrame
    dataframe = pd.read_csv(csv_files[i])
    # Load data into the database table
    dataframe.to_sql(table_name, con=engine, if_exists='replace', index=False, chunksize=10000, method='multi')
    print(f"Finished loading {table_name}")

# Close the database connection
engine.dispose()
