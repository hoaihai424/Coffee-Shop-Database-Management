--get list of available gifts
CREATE OR REPLACE FUNCTION get_available_gifts(IN p_customer_id INTEGER)
RETURNS TABLE(
    id INTEGER,
    name VARCHAR(255),
    point INTEGER
) 
LANGUAGE plpgsql
AS $$
BEGIN 
    RETURN QUERY
    SELECT gift.id, gift.name, gift.point
    FROM business.gift
    WHERE gift.is_available = B'1' AND gift.point <= (SELECT customer.point FROM usertable.customer WHERE customer.id = p_customer_id);
END $$;

--select * from get_available_gifts(1);

--get customer order log
CREATE OR REPLACE FUNCTION get_customer_order_log(IN p_customer_id INTEGER)
RETURNS TABLE(
    order_id INTEGER,
    order_time DATE,
    total_charge DECIMAL(10, 2)
)
LANGUAGE plpgsql
AS $$
BEGIN 
    RETURN QUERY
    SELECT o.id, o.order_time, o.total_charge
    FROM business._order as o
    WHERE o.customer_id = p_customer_id;
END $$;

--select * from get_customer_order_log(1);

--get customer review log
CREATE OR REPLACE FUNCTION get_customer_review_log(IN p_customer_id INTEGER)
RETURNS TABLE(
    product_id INTEGER,
    product_name VARCHAR(255),
    date DATE,
    score INTEGER,
    comment VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN 
    RETURN QUERY
    SELECT p.id, p.name, r.date, r.score, r.comment
    FROM business.review as r 
    JOIN business.product as p ON r.product_id = p.id
    WHERE r.customer_id = p_customer_id;
END $$;

--select * from get_customer_review_log(1);

--get customer exchange log
CREATE OR REPLACE FUNCTION get_customer_exchange_log(IN p_customer_id INTEGER)
RETURNS TABLE(
    gift_id INTEGER,
    gift_name VARCHAR(255),
    date DATE,
    quantity INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN 
    RETURN QUERY
    SELECT e.gift_id, g.name, e.date, e.quantity
    FROM business.exchange as e
    JOIN business.gift as g ON e.gift_id = g.id
    WHERE e.customer_id = p_customer_id;
END $$;

--select * from get_customer_exchange_log(1);

--calculate total revenue for a specific time span
CREATE OR REPLACE FUNCTION calculate_total_revenue(IN p_start_date DATE, IN p_end_date DATE)
RETURNS DECIMAL(10, 2)
LANGUAGE plpgsql
AS $$
DECLARE
    total DECIMAL(10, 2);
BEGIN
    SELECT SUM(o.total_charge) INTO total
    FROM business._order as o
    WHERE o.order_time BETWEEN p_start_date AND p_end_date;

    RETURN total;
END $$;

--select calculate_total_revenue('2021-01-01', '2021-01-31');
