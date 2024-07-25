# Unpacking Instacart: A Deep Dive into North American Grocery E-Commerce Behaviour
![Instacart mobile app screens](images/Instacart.png)

**Instacart** is the leading grocery technology company in North America, partnering with more than 1,400 national, regional, and local retail banners to deliver from more than 80,000 stores across more than 14,000 cities in North America.

## Project Description
The key objective of the project is to uncover patterns in the purchasing habits of Instacart shoppers and
provide recommendations based on the average shopper's behaviour.

**Main questions to answer:**
- How many orders are made at different hours of the day, different days of the week?
- How many items do people buy?
- After how many days do people order again?
- How many items do people buy since a previous order?
- Which items are the bestsellers? 
- Which items are most frequently reordered?
- Which items are added to the cart first? second? third?
- How often and when are products from different department/aisle sold?

**Project goals:**
1. Extract data from the data source.
2. Load data to SQL database.
3. Provide answers to the main business questions, using:
   + (a) SQL queries, or
   + (b) Jupyter notebook & Python code.

## Dataset Overview
### Source
“The Instacart Online Grocery Shopping Dataset 2017”, accessed from https://www.kaggle.com/competitions/instacart-market-basket-analysis/data.
### Dataset structure
This anonymized dataset contains a sample of over 3 million grocery orders from more than 200,000 Instacart users.
Most of the files and variable names are self-explanatory.

The dataset is a relational set of 7 files describing customers' orders over time:
* products.csv
* aisles.csv
* departments.csv
* orders.csv
* order_products__SET.csv (see **SET** described below)

**SET** is one of the four following evaluation sets (eval_set in orders):
* "prior": orders prior to that users most recent order (~3.2m orders)
* "train": training data supplied to participants (~131k orders)
* "test": test data reserved for machine learning competitions (~75k orders)

#### Key data descriptions
* `order_id`: order identifier
* `user_id`: customer identifier
* `eval_set`: which evaluation set this order belongs in (see **SET** described below)
* `order_number`: the order sequence number for this user (1 = first, n = nth)
* `order_dow`: the day of the week the order was placed on
* `order_hour_of_day`: the hour of the day the order was placed on
* `days_since_prior`: days since the last order, capped at 30 (with NAs for order_number = 1)
* `add_to_cart_order`: order in which each product was added to cart 
* `reordered`: 1 if this product has been ordered by this user in the past, 0 otherwise

In the `orders` table, "train" and "test" identify the last order for every user, and are randomly split between train and test.
They are "future data", but only on a per-user basis (e.g., the last order for user X might be earlier than the first order for user Y).

**NOTE**: This dataset includes orders from many different retailers and is **a heavily biased subset** of Instacart’s production data.
And so it is not a representative sample of its products, users or their purchasing behavior.

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
Navigate to the desired notebook and you're ready to start your analysis.

## Methodology
* ELT pipeline
* Exploratory data analysis (EDA)
* Descriptive statistics
* Unsupervised ML: clustering

## Project Structure
This repository contains all the necessary code and scripts for performing a detailed basket analysis on shopper data.
Below is a comprehensive breakdown of the project structure to guide you through its various components.

### Directory Structure & Components
![Instacart mobile app screens](images/Instacart_directory_structure.png)
### 1. `data/`
This directory contains raw dataset files.

### 2. Scripts
- `create_db.py`: Python script that sets up the necessary SQL database schema. Run this script first if you're setting 
up the database from scratch.
- `load_csv_to_db.py`: A utility script that uploads the dataset from the `data/` folder to the SQL database. 
Useful for initial data loading.
- `Instacart_eda.sql`: SQL script that contains quiries for exploratory data analysis (answers the same questions as in the `Instacart_eda.ipynb`).

### 3. Notebooks
- `Instacart_prelim_eda.ipynb`: A notebook used during the initial phases of the project.
It's designed to help understand the dataset's nature, its structure, and the relationships between different files.
- `Instacart_eda.ipynb`: The main Jupyter notebook where the comprehensive data analysis is performed.
N.B.: This notebook leverages data both from the SQL database and local `data/` folder for optimal performance.


### Getting Started
1. **Database Setup**:
    - Run the `create_db.py` script to create the required SQL database structure.
    - Upload your dataset into the SQL database using the `load_csv_to_db.py` script.
2. **Preliminary Data Exploration**:
    - If you're new to the dataset, the `preliminary-data-exploration.ipynb` notebook will be beneficial in understanding the data's intricacies.
3. **Instacart Market Basket Analysis**:
    - Dive deep into the `instacart-market-basket-analysis.ipynb` notebook for a thorough exploration and insights related to shoppers' basket analysis.


## Findings & Conclusions

### Q.1: How many orders are made at different hours of the day, different days of the week?
* Most orders are placed between 8:00 and 19:00, peaking from 10:00 to 16:00. 
* Sunday and Monday are the most popular days for online grocery shopping. 
* Higher activity from Sunday afternoon to Monday afternoon, likely for stocking up after the weekend. 
* Order volumes are stable from Tuesday to Friday between 9:00 and 16:00, with a slight lunchtime dip. 
* Fewer orders on Saturday, possibly due to other activities like housekeeping or outdoor pursuits.

### Q.2: How many items do people buy?
* Users bought over 33.8 million products on the platform.
  * NOTE: Data is available for 3,346,083 orders (97.8% of total), excluding 75,000 orders with missing content.
* Average purchase is 8 products bought per order (median).
* Typical orders contain 1 to 27 products, while outlier orders (3.3%) consist of 28 to 145 products.

### Q.3: How many days pass before people place another order?
* On average, people order groceries online approximately once a week. The same applies to Instacart users: they order again in 7 days (median).
* Initial orders constitute 6.4% of the total orders.

### Q.4: How many items do people buy since a previous order?
* **Initial Orders:** Users typically purchase an average of 10 products, 
indicating users are trying out the service or making smaller, essential purchases.
* **Reordering:**
  * **Minimum Purchase:** Regardless of the interval since the last order, users always buy at least 1 product, showing a consistent need to restock.
  * **Short interval** (when re-ordering within 6 days of a previous order):
    * **Average purchase:** ranges from 9 to 14
    * **Maximum purchase:** ranges from 17 to 27
  * **Longer interval** (if there is a gap of 7 days or more since the last order):
    * **Average purchase:** increases to 15 
    * **Maximum purchase:** increases to between 27 and 30
* Short intervals between orders lead to smaller, frequent purchases, while longer intervals result in larger, planned restocks. Promotions and reminders for periodic restocks can optimize delivery loads and encourage bulk buying.

### Q.5: Which items are the bestsellers?
* **Fresh fruits, vegetables, and organic whole milk dominate the bestsellers list**, highlighting users' preference for health-conscious choices. 
* **Bananas** are the top-selling item on the platform. Strawberries, avocados, spinach, and lemons follow closely behind bananas. 
* Bread and other dairy products are not among the top sellers, despite expectations. 
* The prominence of certain items like bananas, avocados, and spinach may be driven by advertising banners or product recommendations on the platform.

### Q.6: Which items are most frequently reordered?
* The most frequently reordered items are **similar to the bestsellers list**, indicating that popular products are often reordered. 
  * Bananas top the chart for most frequently reordered items.
  * Other frequently reordered items include strawberries, avocados, and spinach, similar to their order in the bestsellers list. 
  * These products are likely considered essential or staple items for many Instacart shoppers.
* Aisles with high reorder frequency:
  * Fresh fruits and vegetables, milk, and water are consistently at the top.
  * Other high-reorder frequency items include yogurt, soy/lactose-free products, bread, refrigerated items, eggs, and cheese.
* Fresh fruits are reordered more frequently than vegetables, possibly due to shorter shelf life, versatile consumption forms, and taste preferences.
* Items like spices, seasonings, condiments, and baking ingredients are less frequently reordered, likely because they are used in smaller quantities.

### Q.7: Which items are added to the cart first, second, and third?

The sequence of product additions shed light on how customers typically navigate the store.
Shoppers tend to add these essentials first before moving on to other items.
Based on the ordering sequence of bestsellers, three product groups can be distinguished:
* **Group 1: First to Third Additions**
  * These items are highly likely to be purchased and are often the first, second, or third items added to the cart.
  * Includes: Bananas, strawberries, avocados, spinach, whole milk, raspberries, lemons, and limes.
* **Group 2: Second and Third Additions**
  * These products are frequently added second or third, sometimes first. 
  * Includes: Fuji apples, cucumber kirbi, blueberries, yellow onion, half & half, and raspberries.
* **Group 3: Comparable but Fewer Units Sold:**
  * These items have fewer units sold compared to Groups 1 and 2 but are still significant.
  * Includes: Soda, reduced fat milk, Hass avocados, garlic, and honeycrisp apples.
* Most products in these groups align closely with the most frequently reordered items.

**Recommendations:**
* Prioritise and prominently display these products when users first log in or visit the site.
* Offer bundle deals or recommend related products to increase the average order value.

### Q.8: How often and when are products from different departments/aisles sold?
**Order Frequency by Department**
  * **Group 1: Top Departments (~46%):** Produce (30%) and dairy & eggs are the highest-priority departments, featuring bestsellers and frequently reordered items. 
  * **Group 2: Major Departments (~30%):** Snacks, beverages, frozen, and pantry goods each account for 5% to 10% of all orders. 
  * **Group 3: Small Departments (~20%):** Bakery, canned goods, deli, dry goods, pasta, household, meat & seafood, and breakfast represent 2% to 5% of orders each. 
  * **Group 4: Niche Departments (~4%):** Personal care, baby products, international items, alcohol, and pet supplies each contribute less than 1.5% of total sales.
  * Groups 1 and 2 generate ~76% of all sales and should be the primary focus for inventory and marketing efforts.

**Order Frequency by Aisle**
* Produce and dairy & eggs are the largest, including fresh and packaged fruits and vegetables, herbs, yogurt, cheese, milk, soy lactose-free products, and eggs.
* Popular Aisles in Small/Niche Departments: Bread (bakery), lunch meat (deli), baby food formula (babies), cereal (breakfast), and soup broth bouillon (canned goods). 
* Pantry department is more fragmented with a broad range of infrequently purchased products, such as baking ingredients, spreads, oils & vinegars, and seasonings.

**Timing of Orders**
* **Time of Day Trends:** Convenience and quick meal items are purchased more in the morning, while alcoholic beverages dominate evening purchases. Other products show minor variations between morning and afternoon. 
* **Day of Week Trends:**
  * Fridays: Peak sales for alcoholic beverages. 
  * Mondays: Surge in sales for fresh and pantry staples, household, and personal care products, as customers stock up for the week ahead.

**Recommendations:**
* Ensure top departments and popular aisles are well-stocked and prominently displayed to meet customer demand and enhance satisfaction.


## Recommendations
- Prioritize displaying these essential products prominently when users log in or visit the site. 
- Offer bundle deals and recommend related products to increase the average order value.

#### Inventory management:
  * Ensure the consistent availability of top-selling and frequently re-ordered products to maintain customer satisfaction and a smooth supply chain. 
  * Ensure continuous availability and optimal stock levels for produce and dairy eggs, as these departments account for nearly 46% of orders. Regularly monitor inventory to prevent stockouts of high-demand items. 
  * Prioritize restocking and expanding popular aisles within the produce and dairy eggs departments. Consider increasing the variety of fresh fruits, vegetables, and dairy products to meet customer demand.

#### Enhance Product Visibility:
  - Highlight products from top departments (produce and dairy eggs) on the homepage and in marketing campaigns to drive sales. Utilize advertising banners and product recommendations to promote these items.
  - Create dedicated sections on the platform for popular aisles from smaller or niche departments (e.g., bakery, deli, breakfast) to increase their visibility and encourage purchases. 

#### Targeted Marketing and Promotions:
  * Offer bundle deals and discounts on frequently reordered items to increase average order value. For example, create bundles that include staple items like bananas, strawberries, and spinach with complementary products.
  * Implement loyalty programs or subscription services for high-demand categories (e.g., produce and dairy) to encourage repeat purchases and improve customer retention. 
  * Develop targeted marketing campaigns for different customer segments based on their purchasing behavior. For example, promote health-focused products to health-conscious customers and convenience items to busy professionals.

#### Improve Pantry Department Offerings:
  - Evaluate the extensive selection of pantry items and identify low-performing products. Focus on stocking high-demand items and consolidating less popular ones to streamline the inventory. 
  - Provide detailed product descriptions, usage tips, and recipe ideas for pantry items to increase their appeal and drive sales. Highlight the versatility and benefits of these products to attract more customers.