--create customer
CREATE OR REPLACE PROCEDURE create_customer(
    IN p_customer_since DATE,
    IN p_dob DATE,
    IN p_gender CHAR(1),
    IN p_address VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_phone_number VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM usertable.customer WHERE phone_number = p_phone_number) THEN
        RAISE EXCEPTION 'Phone number % already exists', p_phone_number;
    ELSE
        INSERT INTO usertable.customer(id, customer_since, dob, gender, point, address, name, password, phone_number)
        VALUES ((SELECT COUNT(*) FROM usertable.customer) + 1, p_customer_since, p_dob, p_gender, 0, p_address, p_name, p_password, p_phone_number);
    END IF;
END;
$$;

--call create_customer('2021-01-01', '1999-01-01', 'M', 'Hanoi', 'Duy', '123', '090-8371-234');
--call create_customer('2021-01-01', '1999-01-01', 'M', 'Hanoi', 'Khang', '123', '090-8371-234');

--create employee
CREATE OR REPLACE PROCEDURE create_employee(
    IN p_dob DATE,
    IN p_gender CHAR(1),
    IN p_start_date DATE,
    IN p_unit_salary INTEGER,
    IN p_address VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_phone_number VARCHAR(255),
    IN p_position VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM usertable.employee WHERE phone_number = p_phone_number) THEN
        RAISE EXCEPTION 'Phone number % already exists', p_phone_number;
    ELSE
        INSERT INTO usertable.employee(id, dob, gender, start_date, total_salary, unit_salary, address, name, password, phone_number, position)
        VALUES ((SELECT COUNT(*) FROM usertable.employee) + 1, p_dob, p_gender, p_start_date, 0, p_unit_salary, p_address, p_name, p_password, p_phone_number, p_position);
    END IF;
END;
$$;

--call create_employee('1999-01-01', 'M', '2021-01-01', 1000, 'Hanoi', 'Duy', '123', '090-8371-234', 'Manager');
--call create_employee('1999-01-01', 'M', '2021-01-01', 1000, 'Hanoi', 'Khang', '123', '090-8371-234', 'Manager');

--create order
CREATE OR REPLACE PROCEDURE create_order(
    IN p_customer_id INTEGER,
    IN p_employee_id INTEGER,
    IN p_order_time DATE,
    IN p_total_charge DECIMAL(10, 2)
)
LANGUAGE plpgsql
AS $$
BEGIN 
    INSERT INTO business._order(id, customer_id, employee_id, order_time, total_charge)
    VALUES ((SELECT COUNT(*) FROM business._order) + 1, p_customer_id, p_employee_id, p_order_time, p_total_charge);
END;
$$;

--call create_order(1, 1, '2021-01-01', 1000);

--exchange gift
CREATE OR REPLACE PROCEDURE exchange_gift(
    IN p_customer_id INTEGER,
    IN p_gift_id INTEGER,
    IN p_date DATE,
    IN p_quantity INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF (SELECT point FROM usertable.customer WHERE id = p_customer_id) < (SELECT point FROM business.gift WHERE id = p_gift_id) * p_quantity THEN
        RAISE EXCEPTION 'Not enough point';
    ELSE
        INSERT INTO business.exchange(customer_id, gift_id, date, quantity)
        VALUES (p_customer_id, p_gift_id, p_date, p_quantity);
    END IF;
END;
$$;

--call exchange_gift(15, 1, '2021-01-01', 1);
--call exchange_gift(15, 1, '2021-01-01', 1);

--create product
CREATE OR REPLACE PROCEDURE create_product(
    IN p_unit_price FLOAT(23),
    IN p_description VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_type VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO business.product(id, discount, is_available, rating, unit_price, description, name, type)
    VALUES ((SELECT COUNT(*) FROM business.product) + 1, 0, B'1', 0, p_unit_price, p_description, p_name, p_type);
END;
$$;

--call create_product(5, 'This is a product', 'Product 1', 'Type 1');

--create review
CREATE OR REPLACE PROCEDURE create_review(
    IN p_customer_id INTEGER,
    IN p_product_id INTEGER,
    IN p_date DATE,
    IN p_score INTEGER,
    IN p_comment VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 
                    FROM business._order
                    JOIN business.has ON business._order.id = business.has._order_id
                    WHERE business._order.customer_id = p_customer_id AND business.has.product_id = p_product_id) THEN
        RAISE EXCEPTION 'You have not bought this product';
    ELSE
        INSERT INTO business.review(customer_id, product_id, date, score, comment)
        VALUES (p_customer_id, p_product_id, p_date, p_score, p_comment);
    END IF;
END;
$$;

--call create_review(1, 1, '2021-01-01', 5, 'Good product');

--create schedule
CREATE OR REPLACE PROCEDURE create_schedule(
    IN p_employee_id INTEGER,
    IN p_shift_id INTEGER,
    IN p_date DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO business.schedule(employee_id, shift_id, date)
    VALUES (p_employee_id, p_shift_id, p_date);
END;
$$;

--call create_schedule(1, 1, '2024-01-11');
