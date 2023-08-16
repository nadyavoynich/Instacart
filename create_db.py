import mysql.connector
import json

# Load credentials from the JSON file
with open("credentials.json", "r") as file:
    creds = json.load(file)

# MySQL database connection configuration
db_config = {
    'user': creds["user_name"],
    'password': creds["user_password"],
    'host': creds["host_name"],
}

# Connect to the MySQL server
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()

# Create a new database
new_database = 'Instacart'
create_db_query = f"CREATE DATABASE IF NOT EXISTS {new_database}"
cursor.execute(create_db_query)

# Close the connection
conn.close()
