-- =====================================================
-- Project: Bike Store Sales Analysis
-- Description: Sales performance analysis using SQL joins
-- =====================================================



-- 1. Orders and Customer Information
-- Description: Retrieves basic order and customer details

SELECT 
    ord.order_id,
    CONCAT(cus.first_name, ' ', cus.last_name) AS customer_name,
    cus.city,
    cus.state,
    ord.order_date
FROM sales.orders ord
JOIN sales.customers cus
    ON ord.customer_id = cus.customer_id;


-- 2. Order-Level Sales Metrics
-- Description: Calculates total units sold and revenue per order

SELECT 
    ord.order_id,
    CONCAT(cus.first_name, ' ', cus.last_name) AS customer_name,
    cus.city,
    cus.state,
    ord.order_date,
    SUM(ite.quantity) AS total_units,
    SUM(ite.quantity * ite.list_price) AS revenue
FROM sales.orders ord
JOIN sales.customers cus
    ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
    ON ord.order_id = ite.order_id
GROUP BY
    ord.order_id,
    CONCAT(cus.first_name, ' ', cus.last_name),
    cus.city,
    cus.state,
    ord.order_date;

-- 3. Detailed Sales Analysis (Products, Categories, Stores, Staff)
-- Description: Enriches sales data with product, category, store, and sales representative information

SELECT 
    ord.order_id,
    CONCAT(cus.first_name, ' ', cus.last_name) AS customer_name,
    cus.city,
    cus.state,
    ord.order_date,
    SUM(ite.quantity) AS total_units,
    SUM(ite.quantity * ite.list_price) AS revenue,
    pro.product_name,
    cat.category_name,
    sto.store_name,
    CONCAT(sta.first_name, ' ', sta.last_name) AS sales_rep
FROM sales.orders ord
JOIN sales.customers cus
    ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
    ON ord.order_id = ite.order_id
JOIN production.products pro
    ON ite.product_id = pro.product_id
JOIN production.categories cat
    ON pro.category_id = cat.category_id
JOIN sales.stores sto
    ON ord.store_id = sto.store_id
JOIN sales.staffs sta
    ON ord.staff_id = sta.staff_id
GROUP BY
    ord.order_id,
    CONCAT(cus.first_name, ' ', cus.last_name),
    cus.city,
    cus.state,
    ord.order_date,
    pro.product_name,
    cat.category_name,
    sto.store_name,
    CONCAT(sta.first_name, ' ', sta.last_name);
