-- =========================================================
-- VALIDACIÓN GENERAL DE INTEGRIDAD
-- =========================================================

-- CATÁLOGOS CENTRALES
SELECT 'categories' AS tabla, COUNT(*) AS total
    FROM BikeStores_Central.production.categories

UNION ALL

SELECT 'brands', COUNT(*)
    FROM BikeStores_Central.production.brands

UNION ALL

SELECT 'products', COUNT(*)
    FROM BikeStores_Central.production.products

UNION ALL

SELECT 'stores', COUNT(*)
    FROM BikeStores_Central.sales.stores;


-- PEDIDOS POR SUCURSAL
SELECT 'Sucursal 1 - orders' AS tabla, COUNT(*) AS total
    FROM BikeStores_Sucursal1.sales.orders_operativos

UNION ALL

SELECT 'Sucursal 2 - orders', COUNT(*)
    FROM BikeStores_Sucursal2.sales.orders_operativos

UNION ALL

SELECT 'Sucursal 3 - orders', COUNT(*)
    FROM BikeStores_Sucursal3.sales.orders_operativos;
GO


-- CLIENTES POR SUCURSAL
SELECT 'Sucursal 1 - Identidad' AS tabla, COUNT(*) AS total
    FROM BikeStores_Sucursal1.sales.customers_identidad

UNION ALL

SELECT 'Sucursal 1 - Contacto', COUNT(*)
    FROM BikeStores_Sucursal1.sales.customers_contacto

UNION ALL

SELECT 'Sucursal 2 - Identidad', COUNT(*)
    FROM BikeStores_Sucursal2.sales.customers_identidad

UNION ALL

SELECT 'Sucursal 2 - Contacto', COUNT(*)
    FROM BikeStores_Sucursal2.sales.customers_contacto

UNION ALL

SELECT 'Sucursal 3 - Identidad', COUNT(*)
    FROM BikeStores_Sucursal3.sales.customers_identidad

UNION ALL

SELECT 'Sucursal 3 - Contacto', COUNT(*)
    FROM BikeStores_Sucursal3.sales.customers_contacto;


-- EMPLEADOS POR SUCURSAL

SELECT 'Sucursal 1 - Empleados' AS tabla, COUNT(*) AS total
    FROM BikeStores_Sucursal1.sales.staffs

UNION ALL

SELECT 'Sucursal 2 - Empleados', COUNT(*)
    FROM BikeStores_Sucursal2.sales.staffs

UNION ALL

SELECT 'Sucursal 3 - Empleados', COUNT(*)
    FROM BikeStores_Sucursal3.sales.staffs;
GO


-- DETALLES DE PEDIDOS
SELECT 'Original - order_items' AS tabla, COUNT(*) AS total
    FROM BikeStores.sales.order_items

UNION ALL

SELECT 'Sucursal 1 - order_items', COUNT(*)
    FROM BikeStores_Sucursal1.sales.order_items

UNION ALL

SELECT 'Sucursal 2 - order_items', COUNT(*)
    FROM BikeStores_Sucursal2.sales.order_items

UNION ALL

SELECT 'Sucursal 3 - order_items', COUNT(*)
    FROM BikeStores_Sucursal3.sales.order_items;


-- INVENTARIO
SELECT 'Original - stocks' AS tabla, COUNT(*) AS total
    FROM BikeStores.production.stocks

UNION ALL

SELECT 'Sucursal 1 - stocks', COUNT(*)
    FROM BikeStores_Sucursal1.production.stocks

UNION ALL

SELECT 'Sucursal 2 - stocks', COUNT(*)
    FROM BikeStores_Sucursal2.production.stocks

UNION ALL

SELECT 'Sucursal 3 - stocks', COUNT(*)
    FROM BikeStores_Sucursal3.production.stocks;
GO



-- =========================================================
-- VALIDA LA INTEGRIDAD ENTRE LAS PARTES FRAGMENTADAS
-- =========================================================

-- SUCURSAL 1
SELECT 'Sucursal 1 - Identidades sin contacto' AS validacion, COUNT(*) AS inconsistencias
    FROM BikeStores_Sucursal1.sales.customers_identidad i
    WHERE NOT EXISTS (
        SELECT 1
        FROM BikeStores_Sucursal1.sales.customers_contacto c
        WHERE c.customer_id = i.customer_id
    )

UNION ALL

SELECT 'Sucursal 1 - Contactos sin identidad', COUNT(*)
    FROM BikeStores_Sucursal1.sales.customers_contacto c
    WHERE NOT EXISTS (
        SELECT 1
        FROM BikeStores_Sucursal1.sales.customers_identidad i
        WHERE i.customer_id = c.customer_id
    )

UNION ALL

SELECT 'Sucursal 1 - Pedidos sin logística', COUNT(*)
    FROM BikeStores_Sucursal1.sales.orders_operativos o
    WHERE NOT EXISTS (
        SELECT 1
        FROM BikeStores_Sucursal1.sales.orders_logistica l
        WHERE l.order_id = o.order_id
    );


-- SUCURSAL 2
SELECT 'Sucursal 2 - Identidades sin contacto' AS validacion, COUNT(*) AS inconsistencias
    FROM BikeStores_Sucursal2.sales.customers_identidad i
    WHERE NOT EXISTS (
        SELECT 1
        FROM BikeStores_Sucursal2.sales.customers_contacto c
        WHERE c.customer_id = i.customer_id
    )

UNION ALL

SELECT 'Sucursal 2 - Contactos sin identidad', COUNT(*)
    FROM BikeStores_Sucursal2.sales.customers_contacto c
    WHERE NOT EXISTS (
        SELECT 1
        FROM BikeStores_Sucursal2.sales.customers_identidad i
        WHERE i.customer_id = c.customer_id
    )

UNION ALL

SELECT 'Sucursal 2 - Pedidos sin logística', COUNT(*)
    FROM BikeStores_Sucursal2.sales.orders_operativos o
    WHERE NOT EXISTS (
        SELECT 1
        FROM BikeStores_Sucursal2.sales.orders_logistica l
        WHERE l.order_id = o.order_id
    );


-- SUCURSAL 3
SELECT 'Sucursal 3 - Identidades sin contacto' AS validacion, COUNT(*) AS inconsistencias
    FROM BikeStores_Sucursal3.sales.customers_identidad i
    WHERE NOT EXISTS (
        SELECT 1
        FROM BikeStores_Sucursal3.sales.customers_contacto c
        WHERE c.customer_id = i.customer_id
    )

UNION ALL

SELECT 'Sucursal 3 - Contactos sin identidad', COUNT(*)
    FROM BikeStores_Sucursal3.sales.customers_contacto c
    WHERE NOT EXISTS (
        SELECT 1
        FROM BikeStores_Sucursal3.sales.customers_identidad i
        WHERE i.customer_id = c.customer_id
    )

UNION ALL

SELECT 'Sucursal 3 - Pedidos sin logística', COUNT(*)
    FROM BikeStores_Sucursal3.sales.orders_operativos o
    WHERE NOT EXISTS (
        SELECT 1
        FROM BikeStores_Sucursal3.sales.orders_logistica l
        WHERE l.order_id = o.order_id
    );

GO



-- =========================================================
-- PRUEBA NEGATIVA: RESTRICCIÓN DE SUCURSAL
-- =========================================================

USE BikeStores_Sucursal1;
GO

BEGIN TRY

    INSERT INTO production.stocks
        (store_id, product_id, quantity)
    VALUES
        (2, 999999, 10);

    PRINT 'ERROR: Se permitió insertar un registro de otra sucursal.';

END TRY
BEGIN CATCH

    PRINT 'Inserción rechazada correctamente.';
    PRINT ERROR_MESSAGE();

END CATCH;
GO

-- COMPROBAR QUE EL REGISTRO NO EXISTE

SELECT *
    FROM BikeStores_Sucursal1.production.stocks
    WHERE product_id = 999999;
GO




-- =========================================================
-- COMPARACIÓN DE REGISTROS: ORIGEN VS DESTINO
-- =========================================================

SELECT
    'Empleados' AS Tabla,
    (SELECT COUNT(*) FROM BikeStores.sales.staffs) AS Origen,
    (
        (SELECT COUNT(*) FROM BikeStores_Sucursal1.sales.staffs) +
        (SELECT COUNT(*) FROM BikeStores_Sucursal2.sales.staffs) +
        (SELECT COUNT(*) FROM BikeStores_Sucursal3.sales.staffs)
    ) AS Destino

UNION ALL

SELECT
    'Pedidos',
    (SELECT COUNT(*) FROM BikeStores.sales.orders),
    (
        (SELECT COUNT(*) FROM BikeStores_Sucursal1.sales.orders_operativos) +
        (SELECT COUNT(*) FROM BikeStores_Sucursal2.sales.orders_operativos) +
        (SELECT COUNT(*) FROM BikeStores_Sucursal3.sales.orders_operativos)
    )

UNION ALL

SELECT
    'Detalles de pedidos',
    (SELECT COUNT(*) FROM BikeStores.sales.order_items),
    (
        (SELECT COUNT(*) FROM BikeStores_Sucursal1.sales.order_items) +
        (SELECT COUNT(*) FROM BikeStores_Sucursal2.sales.order_items) +
        (SELECT COUNT(*) FROM BikeStores_Sucursal3.sales.order_items)
    )

UNION ALL

SELECT
    'Inventario',
    (SELECT COUNT(*) FROM BikeStores.production.stocks),
    (
        (SELECT COUNT(*) FROM BikeStores_Sucursal1.production.stocks) +
        (SELECT COUNT(*) FROM BikeStores_Sucursal2.production.stocks) +
        (SELECT COUNT(*) FROM BikeStores_Sucursal3.production.stocks)
    );
GO
