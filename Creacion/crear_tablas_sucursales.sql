-- TABLAS DE LA SUCURSAL 1
USE BikeStores_Sucursal1;
GO

CREATE SCHEMA sales;
GO

CREATE SCHEMA production;
GO

CREATE TABLE sales.staffs (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(25),
    active TINYINT NOT NULL,
    store_id INT NOT NULL CHECK (store_id = 1),
    manager_id INT NULL,
    FOREIGN KEY (manager_id) REFERENCES sales.staffs(staff_id)
);
GO

CREATE TABLE sales.customers_identidad (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);
GO

CREATE TABLE sales.customers_contacto (
    customer_id INT PRIMARY KEY,
    phone VARCHAR(25),
    email VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(10),
    zip_code VARCHAR(5),
    FOREIGN KEY (customer_id) REFERENCES sales.customers_identidad(customer_id)
);
GO

CREATE TABLE sales.orders_operativos (
    order_id INT PRIMARY KEY,
    customer_id INT NULL,
    order_status TINYINT NOT NULL,
    order_date DATE NOT NULL,
    store_id INT NOT NULL CHECK (store_id = 1),
    staff_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES sales.customers_identidad(customer_id),
    FOREIGN KEY (staff_id) REFERENCES sales.staffs(staff_id)
);
GO

CREATE TABLE sales.orders_logistica (
    order_id INT PRIMARY KEY,
    required_date DATE NOT NULL,
    shipped_date DATE NULL,
    FOREIGN KEY (order_id) REFERENCES sales.orders_operativos(order_id)
);
GO

CREATE TABLE sales.order_items (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(4,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES sales.orders_operativos(order_id)
);
GO

CREATE TABLE production.stocks (
    store_id INT NOT NULL CHECK (store_id = 1),
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (store_id, product_id)
);
GO

-- TABLAS DE LA SUCURSAL 2
USE BikeStores_Sucursal2;
GO

CREATE SCHEMA sales;
GO

CREATE SCHEMA production;
GO

CREATE TABLE sales.staffs (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(25),
    active TINYINT NOT NULL,
    store_id INT NOT NULL CHECK (store_id = 2),
    manager_id INT NULL,
    FOREIGN KEY (manager_id) REFERENCES sales.staffs(staff_id)
);
GO

CREATE TABLE sales.customers_identidad (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);
GO

CREATE TABLE sales.customers_contacto (
    customer_id INT PRIMARY KEY,
    phone VARCHAR(25),
    email VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(10),
    zip_code VARCHAR(5),
    FOREIGN KEY (customer_id) REFERENCES sales.customers_identidad(customer_id)
);
GO

CREATE TABLE sales.orders_operativos (
    order_id INT PRIMARY KEY,
    customer_id INT NULL,
    order_status TINYINT NOT NULL,
    order_date DATE NOT NULL,
    store_id INT NOT NULL CHECK (store_id = 2),
    staff_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES sales.customers_identidad(customer_id),
    FOREIGN KEY (staff_id) REFERENCES sales.staffs(staff_id)
);
GO

CREATE TABLE sales.orders_logistica (
    order_id INT PRIMARY KEY,
    required_date DATE NOT NULL,
    shipped_date DATE NULL,
    FOREIGN KEY (order_id) REFERENCES sales.orders_operativos(order_id)
);
GO

CREATE TABLE sales.order_items (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(4,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES sales.orders_operativos(order_id)
);
GO

CREATE TABLE production.stocks (
    store_id INT NOT NULL CHECK (store_id = 2),
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (store_id, product_id)
);
GO

-- TABLAS DE LA SUCURSAL 3
USE BikeStores_Sucursal3;
GO

CREATE SCHEMA sales;
GO

CREATE SCHEMA production;
GO

CREATE TABLE sales.staffs (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(25),
    active TINYINT NOT NULL,
    store_id INT NOT NULL CHECK (store_id = 3),
    manager_id INT NULL,
    FOREIGN KEY (manager_id) REFERENCES sales.staffs(staff_id)
);
GO

CREATE TABLE sales.customers_identidad (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);
GO

CREATE TABLE sales.customers_contacto (
    customer_id INT PRIMARY KEY,
    phone VARCHAR(25),
    email VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(10),
    zip_code VARCHAR(5),
    FOREIGN KEY (customer_id) REFERENCES sales.customers_identidad(customer_id)
);
GO

CREATE TABLE sales.orders_operativos (
    order_id INT PRIMARY KEY,
    customer_id INT NULL,
    order_status TINYINT NOT NULL,
    order_date DATE NOT NULL,
    store_id INT NOT NULL CHECK (store_id = 3),
    staff_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES sales.customers_identidad(customer_id),
    FOREIGN KEY (staff_id) REFERENCES sales.staffs(staff_id)
);
GO

CREATE TABLE sales.orders_logistica (
    order_id INT PRIMARY KEY,
    required_date DATE NOT NULL,
    shipped_date DATE NULL,
    FOREIGN KEY (order_id) REFERENCES sales.orders_operativos(order_id)
);
GO

CREATE TABLE sales.order_items (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(4,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES sales.orders_operativos(order_id)
);
GO

CREATE TABLE production.stocks (
    store_id INT NOT NULL CHECK (store_id = 3),
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (store_id, product_id)
);
GO

--AJUSTE DE RESTRICCIONES
USE BikeStores_Sucursal1;
GO

ALTER TABLE sales.staffs
DROP CONSTRAINT FK__staffs__manager___398D8EEE;
GO

USE BikeStores_Sucursal2;
GO

ALTER TABLE sales.staffs
DROP CONSTRAINT FK__staffs__manager___398D8EEE;
GO

USE BikeStores_Sucursal3;
GO

ALTER TABLE sales.staffs
DROP CONSTRAINT FK__staffs__manager___398D8EEE;
GO