--customer log view
CREATE OR REPLACE VIEW business.customer_log AS
SELECT c.name AS customer_name, o.order_time, p.name AS product_name, h.quantity, h.price
FROM usertable.customer c 
JOIN business._order o ON c.id = o.customer_id
JOIN business.has h ON o.id = h._order_id
JOIN business.product p ON h.product_id = p.id
ORDER BY c.name, o.order_time;

--employee log view
CREATE OR REPLACE VIEW business.employee_log AS
SELECT e.name, o.id, o.order_time
FROM business._order o
JOIN usertable.employee e ON o.employee_id = e.id
ORDER BY e.name, o.order_time;

--category ranking
CREATE OR REPLACE VIEW business.category_ranking AS
SELECT p.type, AVG(r.score) as avg_score
FROM business.product p 
JOIN business.review r ON p.id = r.product_id
GROUP BY p.type
ORDER BY avg_score DESC;

--customer analysis
CREATE OR REPLACE VIEW business.customer_analysis AS
SELECT c.name, COUNT(c.id) as total_customer, SUM(o.total_charge) as total_revenue
FROM usertable.customer c 
JOIN business._order o ON c.id = o.customer_id
GROUP BY c.id
ORDER BY total_revenue DESC;

--employee analysis
CREATE OR REPLACE VIEW business.employee_analysis AS
SELECT e.name, COUNT(o.id) as total_order, SUM(o.total_charge) as total_revenue
FROM usertable.employee e
JOIN business._order o ON e.id = o.employee_id
GROUP BY e.id
ORDER BY total_revenue DESC;
