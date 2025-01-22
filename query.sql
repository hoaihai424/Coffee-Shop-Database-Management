-- Get all customers who have accumulated between 100 and 120 points.
SELECT id, name, phone_number, point
FROM usertable.customer
WHERE point BETWEEN 100 AND 120;

-- Find the total number of orders placed by each customer and their total charges, ordered by total spent in descending order.
SELECT c.id, c.phone_number AS customer_phone_number, c.name AS customer_name, COUNT(o.id) AS total_orders, SUM(o.total_charge) AS total_spent
FROM usertable.customer c
LEFT JOIN business._order o ON c.id = o.customer_id
GROUP BY c.id, c.phone_number, c.name
HAVING COUNT(o.id) > 0
ORDER BY total_spent DESC;

-- Get all customers who have spent an average of more than 500 per order.
SELECT c.id, c.phone_number AS customer_phone_number, c.name AS customer_name, AVG(o.total_charge) AS avg_spent
FROM usertable.customer c
LEFT JOIN business._order o ON c.id = o.customer_id
GROUP BY c.id, c.phone_number, c.name
HAVING AVG(o.total_charge) > 500;

-- Find employees whose positions are either 'Manager' or 'Cashier' or have a unit salary greater than 10000.
SELECT id, name, position
FROM usertable.employee
WHERE position IN ('Manager', 'Cashier') OR unit_salary > 10000;

-- Get all available gifts, ordered by the points required in descending order.
SELECT id, name, point
FROM business.gift
WHERE is_available = B'1'
ORDER BY point DESC;

-- Find the minimum and maximum rating for available products.
SELECT MIN(rating) AS min_rating, MAX(rating) AS max_rating
FROM business.product
WHERE is_available = B'1';

-- Count how many customers have a name starting with 'A'.
SELECT COUNT(*) AS count_customers
FROM usertable.customer
WHERE name LIKE 'A%';

-- List orders made by customers with IDs 1, 2, or 3 and with total charges less than 200.
SELECT id, customer_id, total_charge
FROM business._order
WHERE customer_id IN (1, 2, 3) AND total_charge < 200;

-- Find customers who have exchanged more than 3 gifts.
SELECT c.name AS customer_name, c.phone_number AS customer_phone_number, SUM(e.quantity) AS total_gifts
FROM usertable.customer c
LEFT JOIN business.exchange e ON c.id = e.customer_ID
GROUP BY c.phone_number, c.name
HAVING SUM(e.quantity) > 3;

-- Find the total salary paid to each employee based on their schedule.
SELECT e.ID AS employee_ID, e.name AS employee_name, SUM(e.unit_salary * sh.hour) AS total_salary
FROM usertable.employee e
LEFT JOIN business.schedule s ON e.id = s.employee_ID
JOIN shift sh ON s.shift_ID = sh.ID
GROUP BY e.ID, e.name;

-- Count the number of reviews each product has received, ordered by review count in descending order.
SELECT p.name AS product_name, COUNT(r.customer_ID) AS review_count
FROM business.product p
LEFT JOIN business.review r ON p.id = r.product_ID
GROUP BY p.name
ORDER BY review_count DESC;
