# Unpacking Instacart: A Deep Dive into North American Grocery E-Commerce Behavior
![Instacart mobile app screens](Instacart.png)

**Instacart** is the leading grocery technology company in North America, partnering with more than 1,400 national, regional, and local retail banners to deliver from more than 80,000 stores across more than 14,000 cities in North America.

## Project Description
The primary objective of the project is to delve into the Instacart sales data and craft every conceivable insight that can contribute to the further business growth.

**Main questions to answer:**
- What shopper behaviour is at different hours of the day? days of the week?
- How often and when are products from different department/aisle sold?
- How many days pass before people place another order?
- How many items do people buy?
- Which items are the best sellers?
- Which items are most frequently reordered?
- Which items are added to the cart first? second? third?

## Dataset Overview
### Source
“The Instacart Online Grocery Shopping Dataset 2017”, accessed from https://www.kaggle.com/competitions/instacart-market-basket-analysis/data.
### Dataset structure
This anonymized dataset contains a sample of over 3 million grocery orders from more than 200,000 Instacart users.
Most of the files and variable names should be self-explanatory.

The dataset is a relational set of **7 files** describing customers' orders over time:
* products.csv
* aisles.csv
* departments.csv
* orders.csv
* order_products__SET (see **SET** described below)

#### Key data descriptions
* order_id: order identifier
* user_id: customer identifier
* eval_set: which evaluation set this order belongs in (see **SET** described below)
* order_number: the order sequence number for this user (1 = first, n = nth)
* order_dow: the day of the week the order was placed on
* order_hour_of_day: the hour of the day the order was placed on
* days_since_prior: days since the last order, capped at 30 (with NAs for order_number = 1)
* add_to_cart_order: order in which each product was added to cart 
* reordered: 1 if this product has been ordered by this user in the past, 0 otherwise

SET is one of the four following evaluation sets (eval_set in orders):
* "prior": orders prior to that users most recent order (~3.2m orders)
* "train": training data supplied to participants (~131k orders)
* "test": test data reserved for machine learning competitions (~75k orders)

In the 'orders' table, "train" and "test" identify the last order for every user, and are randomly split between train and test.
They are "future data", but only on a per-user basis (e.g., the last order for user X might be earlier than the first order for user Y).

## Setup & Requirements
Follow these steps to get the data analysis project up and running on your local machine.

### Prerequisites
1. **Python**: This project requires Python 3.9 or higher.
If you don't have Python installed, [download and install](https://www.python.org/downloads/) the latest version.
2. **Jupyter Notebook**: Jupyter Notebook is used for the interactive analysis. If you don't have it, install it using pip:
``pip install jupyter``

### Setting Up a Virtual Environment (Recommended)
It's recommended to set up a virtual environment to avoid any package conflicts.
1. Install `virtualenv` if not installed: ``pip install virtualenv``
2. Navigate to the project directory and create a virtual environment: ``virtualenv venv``
3. Activate the virtual environment:
    - **Windows**: ``.\\venv\\Scripts\\activate``
    - **macOS/Linux**: ``source venv/bin/activate``

### Installing Required Libraries
With the virtual environment activated, install the necessary libraries using:
``pip install -r requirements.txt``

### Getting the Data
This project uses the `The Instacart Online Grocery Shopping Dataset 2017` dataset.
1. Download the dataset from [this link](https://www.kaggle.com/competitions/instacart-market-basket-analysis/data).
2. Place the downloaded dataset in the `data/` directory (create the directory if it doesn't exist).

### Running the Notebook
With everything set up, start the Jupyter Notebook server: ``jupyter notebook``
Navigate to the desired notebook and you're ready to start your analysis!

## Methodology
* ETL framework
* Exploratory data analysis (EDA)
* Descriptive statistics
* Unsupervised ML: clustering

## Project Structure
This repository contains all the necessary code and scripts for performing a detailed basket analysis on shopper data.
The primary aim is to uncover patterns in the purchasing habits of shoppers.
Below is a comprehensive breakdown of the project structure to guide you through its various components.

### Directory Structure & Components
### 1. `scripts/`
- `create_db.py`: Python script that sets up the necessary SQL database schema. Run this script first if you're setting up the database from scratch.
- `load_csv_to_db.py`: A utility script that uploads the dataset from the `data/` folder to the SQL database. Useful for initial data loading.

### 2. `notebooks/`
- `instacart-market-basket-analysis.ipynb`: The main Jupyter notebook where the comprehensive data analysis is performed.
This notebook leverages data both from the SQL database and local `data/` folder for optimal performance.
- `preliminary-data-exploration.ipynb`: A notebook used during the initial phases of the project.
It's designed to help understand the dataset's nature, its structure, and the relationships between different files.

### 3. `data/`
This directory contains raw dataset files.
Some of the analysis in the main notebook, `instacart-market-basket-analysis.ipynb`, directly loads data from this 
folder instead of the SQL connection to expedite the analysis process.

### Getting Started
1. **Database Setup**:
    - Run the `create_db.py` script to create the required SQL database structure.
    - Upload your dataset into the SQL database using the `load_csv_to_db.py` script.
2. **Preliminary Data Exploration**:
    - If you're new to the dataset, the `preliminary-data-exploration.ipynb` notebook will be beneficial in understanding the data's intricacies.
3. **Instacart Market Basket Analysis**:
    - Dive deep into the `instacart-market-basket-analysis.ipynb` notebook for a thorough exploration and insights related to shoppers' basket analysis.

I hope this structure provides clarity and facilitates ease of navigation.

## Findings & Conclusions
