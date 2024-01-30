##### Unpacking Instacart: A Deep Dive into North American Grocery E-Commerce Behavior #####
##### ----- Exploratory Data Analysis ----- #####

### How many items were sold on the platform?
SELECT 
    COUNT(*)
FROM
    orders;

### How many orders are made at different hours of the day?
SELECT
    order_hour_of_day, COUNT(*) AS number_of_orders
FROM
    orders
    GROUP BY order_hour_of_day
    ORDER BY order_hour_of_day;

### How many orders are made at different days of the week?
SELECT
    order_dow, COUNT(*) AS number_of_orders
FROM
    orders
    GROUP BY order_dow
    ORDER BY order_dow;
    
    
### What is an hourly trend by each day of the week?
SELECT
    order_dow, order_hour_of_day, COUNT(*) AS number_of_orders
FROM
    orders
    GROUP BY order_dow, order_hour_of_day
    ORDER BY order_dow, order_hour_of_day;


### After how many days to people order again?
# Min, Max, Average days since prior order
SELECT 
    MIN(days_since_prior_order) AS max_days,
    MAX(days_since_prior_order) AS min_days,
    AVG(days_since_prior_order) AS average_days
FROM
    orders;

# The minimum value is 0 (indicating NaN values), signifying an absence of previous order history.
# Re-calculating minimum days since prior order:
SELECT 
    MIN(days_since_prior_order) AS min_days
FROM
    orders
WHERE
    days_since_prior_order > 0;

# Median days since prior order
SELECT 
    AVG(dd.days_since_prior_order) AS median
FROM
    (SELECT 
        d.days_since_prior_order,
            @rownum:=@rownum + 1 AS 'row_number',
            @total_rows:=@rownum
    FROM
        orders d, (SELECT @rownum:=0) r
    WHERE
        d.days_since_prior_order IS NOT NULL
    ORDER BY d.days_since_prior_order) AS dd
WHERE
    dd.row_number IN (FLOOR((@total_rows + 1) / 2) , FLOOR((@total_rows + 2) / 2));


### How many items do people buy on average per order?
SELECT 
    AVG(item_count) AS avg_items_per_order
FROM
    (SELECT order_id, COUNT(*) AS item_count
    FROM
        (SELECT order_id, product_id FROM orders_prior
        UNION ALL
        SELECT order_id, product_id FROM orders_train
        ) AS combined_orders
    GROUP BY order_id
    ) AS orders_count;


### What are the best selling items?
# Top 20
SELECT 
    co.product_id,
    p.product_name,
    COUNT(co.product_id) AS item_count
FROM
    (SELECT product_id
    FROM orders_prior 
    UNION ALL
	SELECT product_id
    FROM orders_train) AS co
JOIN products p ON co.product_id = p.product_id
GROUP BY co.product_id , p.product_name
ORDER BY item_count DESC
LIMIT 20;


### What items are most frequently re-ordered?
# Top 20
SELECT 
    co.product_id,
    p.product_name,
    SUM(co.reordered) AS times_reordered
FROM
    (SELECT product_id, reordered
    FROM orders_prior 
    UNION ALL
	SELECT product_id, reordered
    FROM orders_train) AS co
JOIN products p ON co.product_id = p.product_id
GROUP BY co.product_id , p.product_name
ORDER BY times_reordered DESC
LIMIT 20;


### Which items are part into a card first? second? third?
# Top 20 items that are part into a card first?
SELECT 
    co.product_id,
    p.product_name,
    COUNT(co.product_id) AS item_count
FROM
    (SELECT product_id, add_to_cart_order
    FROM orders_prior 
    UNION ALL
	SELECT product_id, add_to_cart_order
    FROM orders_train) AS co
JOIN products p ON co.product_id = p.product_id
WHERE co.add_to_cart_order = 1
GROUP BY co.product_id , p.product_name
ORDER BY item_count DESC
LIMIT 20;

# Top 20 items that are part into a card second?
SELECT 
    co.product_id,
    p.product_name,
    COUNT(co.product_id) AS item_count
FROM
    (SELECT product_id, add_to_cart_order
    FROM orders_prior 
    UNION ALL
	SELECT product_id, add_to_cart_order
    FROM orders_train) AS co
JOIN products p ON co.product_id = p.product_id
WHERE co.add_to_cart_order = 2
GROUP BY co.product_id , p.product_name
ORDER BY item_count DESC
LIMIT 20;

# Top 20 items that are part into a card third?
SELECT 
    co.product_id,
    p.product_name,
    COUNT(co.product_id) AS item_count
FROM
    (SELECT product_id, add_to_cart_order
    FROM orders_prior 
    UNION ALL
	SELECT product_id, add_to_cart_order
    FROM orders_train) AS co
JOIN products p ON co.product_id = p.product_id
WHERE co.add_to_cart_order = 3
GROUP BY co.product_id , p.product_name
ORDER BY item_count DESC
LIMIT 20;


### How often are products from the department sold?
SELECT 
    d.department,
    COUNT(co.product_id) AS department_sales
FROM
    (SELECT product_id
    FROM orders_prior 
    UNION ALL
	SELECT product_id
    FROM orders_train) AS co
JOIN products p ON co.product_id = p.product_id
JOIN departments d ON p.department_id = d.department_id
GROUP BY d.department_id , d.department
ORDER BY department_sales DESC;

### How often are products from the aisle sold?
SELECT 
    a.aisles,
    COUNT(co.product_id) AS aisle_sales
FROM
    (SELECT product_id
    FROM orders_prior 
    UNION ALL
	SELECT product_id
    FROM orders_train) AS co
JOIN products p ON co.product_id = p.product_id
JOIN aisles a ON p.aisle_id = a.aisle_id
GROUP BY a.aisle_id, a.aisle
ORDER BY aisle_sales DESC;
