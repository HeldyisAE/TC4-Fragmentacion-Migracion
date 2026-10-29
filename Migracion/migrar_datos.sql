USE BikeStores_Central;
GO

-- 1. CATEGORÍAS
SET IDENTITY_INSERT production.categories ON;

INSERT INTO BikeStores_Central.production.categories(category_id, category_name)

SELECT
    category_id, category_name
    FROM BikeStores.production.categories;

SET IDENTITY_INSERT production.categories OFF;
GO

-- 2. MARCAS
SET IDENTITY_INSERT production.brands ON;

INSERT INTO BikeStores_Central.production.brands(brand_id, brand_name)

SELECT
    brand_id, brand_name
    FROM BikeStores.production.brands;

SET IDENTITY_INSERT production.brands OFF;
GO

-- 3. PRODUCTOS
SET IDENTITY_INSERT production.products ON;

INSERT INTO BikeStores_Central.production.products(product_id, product_name, brand_id, category_id, model_year, list_price)

SELECT
    product_id, product_name, brand_id, category_id,
    model_year, list_price
    FROM BikeStores.production.products;

SET IDENTITY_INSERT production.products OFF;
GO

-- 4. SUCURSALES
SET IDENTITY_INSERT sales.stores ON;

INSERT INTO BikeStores_Central.sales.stores(store_id, store_name, phone, email, street, city, state, zip_code)

SELECT
    store_id, store_name, phone, email, street,
    city, state, zip_code
    FROM BikeStores.sales.stores;

SET IDENTITY_INSERT sales.stores OFF;
GO


USE BikeStores;
GO

SELECT
    store_id,
    COUNT(DISTINCT customer_id) AS clientes_distintos,
    COUNT(*) AS total_pedidos
FROM sales.orders
GROUP BY store_id
ORDER BY store_id;

-- 5. CLIENTES Y EMPLEADOS: SUCURSAL 1
USE BikeStores_Sucursal1;
GO

INSERT INTO sales.customers_identidad(customer_id, first_name, last_name)

SELECT DISTINCT
    c.customer_id, c.first_name, c.last_name
FROM BikeStores.sales.customers AS c
INNER JOIN BikeStores.sales.orders AS o
    ON o.customer_id = c.customer_id
WHERE o.store_id = 1;

INSERT INTO sales.customers_contacto(customer_id, phone, email, street, city, state, zip_code)

SELECT DISTINCT
    c.customer_id, c.phone, c.email,
    c.street, c.city, c.state, c.zip_code
FROM BikeStores.sales.customers AS c
INNER JOIN BikeStores.sales.orders AS o
    ON o.customer_id = c.customer_id
WHERE o.store_id = 1;

INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id)

SELECT
    staff_id, first_name, last_name, email, phone,
    active, store_id, manager_id
FROM BikeStores.sales.staffs
WHERE store_id = 1;
GO

-- 6. CLIENTES Y EMPLEADOS: SUCURSAL 2
USE BikeStores_Sucursal2;
GO

INSERT INTO sales.customers_identidad(customer_id, first_name, last_name)

SELECT DISTINCT
    c.customer_id, c.first_name, c.last_name
FROM BikeStores.sales.customers AS c
INNER JOIN BikeStores.sales.orders AS o
    ON o.customer_id = c.customer_id
WHERE o.store_id = 2;

INSERT INTO sales.customers_contacto(customer_id, phone, email, street, city, state, zip_code)

SELECT DISTINCT
    c.customer_id, c.phone, c.email,
    c.street, c.city, c.state, c.zip_code
FROM BikeStores.sales.customers AS c
INNER JOIN BikeStores.sales.orders AS o
    ON o.customer_id = c.customer_id
WHERE o.store_id = 2;

INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id)

SELECT
    staff_id, first_name, last_name, email, phone,
    active, store_id, manager_id
FROM BikeStores.sales.staffs
WHERE store_id = 2;
GO

-- 7. CLIENTES Y EMPLEADOS: SUCURSAL 3
USE BikeStores_Sucursal3;
GO

INSERT INTO sales.customers_identidad(customer_id, first_name, last_name)

SELECT DISTINCT
    c.customer_id, c.first_name, c.last_name
FROM BikeStores.sales.customers AS c
INNER JOIN BikeStores.sales.orders AS o
    ON o.customer_id = c.customer_id
WHERE o.store_id = 3;

INSERT INTO sales.customers_contacto(customer_id, phone, email, street, city, state, zip_code)

SELECT DISTINCT
    c.customer_id, c.phone, c.email,
    c.street, c.city, c.state, c.zip_code
FROM BikeStores.sales.customers AS c
INNER JOIN BikeStores.sales.orders AS o
    ON o.customer_id = c.customer_id
WHERE o.store_id = 3;

INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id)

SELECT
    staff_id, first_name, last_name, email, phone,
    active, store_id, manager_id
FROM BikeStores.sales.staffs
WHERE store_id = 3;
GO

USE BikeStores_Sucursal1;
GO
SELECT
    (SELECT COUNT(*) FROM sales.customers_identidad)
        AS clientes_identidad,
    (SELECT COUNT(*) FROM sales.customers_contacto)
        AS clientes_contacto,
    (SELECT COUNT(*) FROM sales.staffs)
        AS empleados;