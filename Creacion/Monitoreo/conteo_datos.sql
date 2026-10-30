USE BikeStores;
GO

--CANTIDAD DE DATOS POR TABLA
SELECT 'categories' AS tabla, COUNT(*) AS registros
FROM production.categories

UNION ALL

SELECT 'brands', COUNT(*)
FROM production.brands

UNION ALL

SELECT 'products', COUNT(*)
FROM production.products

UNION ALL

SELECT 'customers', COUNT(*)
FROM sales.customers

UNION ALL

SELECT 'stores', COUNT(*)
FROM sales.stores

UNION ALL

SELECT 'staffs', COUNT(*)
FROM sales.staffs

UNION ALL

SELECT 'orders', COUNT(*)
FROM sales.orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM sales.order_items

UNION ALL

SELECT 'stocks', COUNT(*)
FROM production.stocks;

--SUCURSALES
SELECT store_id, store_name
    FROM sales.stores
    ORDER BY store_id;