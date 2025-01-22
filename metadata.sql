CREATE TABLE customer (
    id INTEGER PRIMARY KEY,
    customer_since DATE,
    dob DATE,
    gender CHAR(1),
    point INTEGER NOT NULL,
    address VARCHAR(255),
    name VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) UNIQUE
);

CREATE TABLE employee (
    id INTEGER PRIMARY KEY,
    dob DATE,
    gender CHAR(1),
    start_date DATE NOT NULL,
    total_salary INTEGER NOT NULL,
    unit_salary INTEGER NOT NULL,
    address VARCHAR(255),
    name VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) UNIQUE,
    position VARCHAR(255) NOT NULL
);

CREATE TABLE gift (
    id INTEGER PRIMARY KEY,
    is_available BIT NOT NULL,
    point INTEGER NOT NULL,
    name VARCHAR(255)
);

CREATE TABLE _order (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    employee_id INTEGER,
    order_time DATE,
    total_charge DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employee (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE exchange (
    customer_ID INTEGER NOT NULL,
    gift_ID INTEGER NOT NULL,
    DATE DATE NOT NULL, 
    quantity INTEGER NOT NULL,
    PRIMARY KEY (customer_ID, gift_ID),
    FOREIGN KEY (customer_ID) REFERENCES customer (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (gift_ID) REFERENCES gift (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE product (
    id INTEGER PRIMARY KEY,
    discount INTEGER NOT NULL,
    is_available BIT NOT NULL,
    rating FLOAT(23) NOT NULL,
    unit_price FLOAT(23) NOT NULL,
    description VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255)
);

CREATE TABLE has (
    _order_ID INTEGER NOT NULL,
    price INTEGER NOT NULL,
    product_ID INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (_order_ID, product_ID),
    FOREIGN KEY (_order_ID) REFERENCES _order (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_ID) REFERENCES product (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE review (
    customer_ID INTEGER NOT NULL,
    product_ID INTEGER NOT NULL,
    date DATE NOT NULL,
    score INTEGER NOT NULL,
    comment VARCHAR(255),
    PRIMARY KEY (customer_ID, product_ID),
    FOREIGN KEY (customer_ID) REFERENCES customer (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_ID) REFERENCES product (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE shift (
    id INTEGER PRIMARY KEY,
    hour INTEGER NOT NULL,
    end_time VARCHAR(255) NOT NULL,
    start_time VARCHAR(255) NOT NULL
);

CREATE TABLE schedule (
    employee_ID INTEGER NOT NULL,
    shift_ID INTEGER NOT NULL,
    data DATE NOT NULL,
    PRIMARY KEY (employee_ID, shift_ID),
    FOREIGN KEY (employee_ID) REFERENCES employee (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (shift_ID) REFERENCES shift (id) ON DELETE CASCADE ON UPDATE CASCADE
);

