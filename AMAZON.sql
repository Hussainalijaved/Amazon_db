--category table
CREATE TABLE category
(
category_id INT primary key,
category_name VARCHAR(25)
);

--customers table
CREATE TABLE customers
(
customer_id INT primary key,
customer_name VARCHAR(25),
state VARCHAR(30),
address VARCHAR(50) DEFAULT ('xxxx')
);

--seller table
CREATE TABLE sellers
(
seller_id INT primary key,
seller_name VARCHAR(25),
origin VARCHAR(25)
);

--product table
CREATE TABLE products
(
product_id INT primary key,
product_name VARCHAR(25),
price FLOAT,
cog FLOAT,
category_id INT,
CONSTRAINT product_fk_category FOREIGN KEY(category_id) REFERENCES category(category_id)
);

--order table
CREATE TABLE orders
(
order_id INT primary key,
order_date DATE,
customer_id INT,
seller_id INT,
order_status VARCHAR(15),
CONSTRAINT orders_fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
CONSTRAINT orders_fk_sellers FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

--orderitems table
CREATE TABLE order_items
(
order_item_id INT primary key,
order_id INT,
product_id INT,
quatity INT,
price_per_unit FLOAT,
CONSTRAINT order_items_fk_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
CONSTRAINT order_items_fk_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--payment table
CREATE TABLE payments
(
payment_id INT primary key,
order_id INT,
payment_date DATE,
payment_status VARCHAR(25),
CONSTRAINT payments_fk_orders FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

--shipping table
CREATE TABLE shipping
(
shipping_id	INT primary key,
shipping_date	DATE,
delivery_status	VARCHAR(15),
order_id INT,
CONSTRAINT shipping_fk_orders FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

--inventory table
CREATE TABLE inventory
(
inventory_id INT primary key,
product_id INT,
stock INT,
warehouse_id INT,
last_stock_date DATE,
CONSTRAINT inventory_fk_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

---end of schema

---eda
SELECT * FROM category
SELECT * FROM customers
SELECT * FROM sellers
SELECT * FROM products
SELECT * FROM orders
SELECT * FROM order_items
SELECT * FROM payments
SELECT * FROM shipping
SELECT * FROM inventory


SELECT 
DISTINCT payment_status
FROM payments

SELECT * 
FROM shippings
WHERE return_date IS NOT NULL


SELECT * 
FROM shippings
WHERE return_date IS NULL



--Q1
SELECT * FROM order_items
ALTER TABLE order_items
ADD COLUMN total_sale FLOAT

UPDATE order_items
SET total_sale * quantity = price_per_unit

SELECT * FROM order_items
ORDER BY quantity DESC

SELECT 
product_id.
product_name.
SUM(oi.total_sale) as total_sale
FROM orders as o
JOIN
order_items as oi
ON oi.order_id = o.order_id
JOIN
products as p
ON p.product_id = oi.product_id
ORDER BY 1,2


--Q2
SELECT 
p.category_id,
c.category_name,
SUM(oi.total_sale) as total_sale
FROM order _items as oi
JOIN
products as p
ON p.product_id = oi.product_id
LEFT JOIN category as c
ON c.category_id = p.category_id
GROUP BY 1,2
ORDER BY 3 DESC


--Q3
SELECT 
c.customer_id,
c.customer_name,
SUM(total_sale).
COUNT(o.order_id) as total_orders
FROM orders as o
JOIN
customers as c
ON c.customer_id = o.customer_id
JOIN
order_items as oi
ON oi.order_id = o.order_id