
-- =========================================================
-- CONSULTA DISTRIBUIDA: RECONSTRUCCIÓN DE PEDIDOS
-- =========================================================

WITH PedidosDistribuidos AS (

    -- SUCURSAL 1
    SELECT
        o.order_id AS Pedido,
        o.customer_id AS Cliente,
        o.order_status AS Estado_Pedido,
        o.order_date AS Fecha_Pedido,
        l.required_date,
        l.shipped_date,
        o.store_id AS Sucursal,
        o.staff_id

    FROM BikeStores_Sucursal1.sales.orders_operativos o
    INNER JOIN BikeStores_Sucursal1.sales.orders_logistica l ON o.order_id = l.order_id

    UNION ALL

    -- SUCURSAL 2
    SELECT
        o.order_id AS Pedido,
        o.customer_id AS Cliente,
        o.order_status AS Estado_Pedido,
        o.order_date AS Fecha_Pedido,
        l.required_date,
        l.shipped_date,
        o.store_id AS Sucursal,
        o.staff_id

    FROM BikeStores_Sucursal2.sales.orders_operativos o
    INNER JOIN BikeStores_Sucursal2.sales.orders_logistica l ON o.order_id = l.order_id

    UNION ALL

    -- SUCURSAL 3
    SELECT
        o.order_id AS Pedido,
        o.customer_id AS Cliente,
        o.order_status AS Estado_Pedido,
        o.order_date AS Fecha_Pedido,
        l.required_date,
        l.shipped_date,
        o.store_id AS Sucursal,
        o.staff_id

    FROM BikeStores_Sucursal3.sales.orders_operativos o
    INNER JOIN BikeStores_Sucursal3.sales.orders_logistica l ON o.order_id = l.order_id
)

SELECT TOP 20 *
    FROM PedidosDistribuidos
    ORDER BY Pedido;
GO


-- COMPROBAR EL TOTAL DE PEDIDOS RECONSTRUIDOS
WITH PedidosDistribuidos AS (
    SELECT o.order_id
        FROM BikeStores_Sucursal1.sales.orders_operativos o
        INNER JOIN BikeStores_Sucursal1.sales.orders_logistica l ON o.order_id = l.order_id

    UNION ALL

    SELECT o.order_id
        FROM BikeStores_Sucursal2.sales.orders_operativos o
        INNER JOIN BikeStores_Sucursal2.sales.orders_logistica l ON o.order_id = l.order_id

    UNION ALL

    SELECT o.order_id
        FROM BikeStores_Sucursal3.sales.orders_operativos o
        INNER JOIN BikeStores_Sucursal3.sales.orders_logistica l ON o.order_id = l.order_id
)
SELECT COUNT(*) AS total_pedidos_reconstruidos
    FROM PedidosDistribuidos;
GO



-- =========================================================
-- CONSULTA DISTRIBUIDA: RECONSTRUCCIÓN DE CLIENTES
-- =========================================================

WITH ClientesDistribuidos AS (

    -- SUCURSAL 1
    SELECT
        i.customer_id AS Cliente,
        i.first_name,
        i.last_name,
        c.phone,
        c.email,
        c.street,
        c.city,
        c.state,
        c.zip_code,
        1 AS Sucursal

    FROM BikeStores_Sucursal1.sales.customers_identidad i
    INNER JOIN BikeStores_Sucursal1.sales.customers_contacto c ON i.customer_id = c.customer_id

    UNION ALL

    -- SUCURSAL 2
    SELECT
        i.customer_id AS Cliente,
        i.first_name,
        i.last_name,
        c.phone,
        c.email,
        c.street,
        c.city,
        c.state,
        c.zip_code,
        2 AS Sucursal

    FROM BikeStores_Sucursal2.sales.customers_identidad i
    INNER JOIN BikeStores_Sucursal2.sales.customers_contacto c ON i.customer_id = c.customer_id

    UNION ALL

    -- SUCURSAL 3
    SELECT
        i.customer_id AS Cliente,
        i.first_name,
        i.last_name,
        c.phone,
        c.email,
        c.street,
        c.city,
        c.state,
        c.zip_code,
        3 AS Sucursal

    FROM BikeStores_Sucursal3.sales.customers_identidad i
    INNER JOIN BikeStores_Sucursal3.sales.customers_contacto c ON i.customer_id = c.customer_id
)

SELECT TOP 20 *
    FROM ClientesDistribuidos
    ORDER BY Cliente;
GO


-- COMPROBAR EL TOTAL DE CLIENTES RECONSTRUIDOS
WITH ClientesDistribuidos AS (
    SELECT i.customer_id
        FROM BikeStores_Sucursal1.sales.customers_identidad i
        INNER JOIN BikeStores_Sucursal1.sales.customers_contacto c ON i.customer_id = c.customer_id

    UNION ALL

    SELECT i.customer_id
        FROM BikeStores_Sucursal2.sales.customers_identidad i
        INNER JOIN BikeStores_Sucursal2.sales.customers_contacto c ON i.customer_id = c.customer_id

    UNION ALL

    SELECT i.customer_id
        FROM BikeStores_Sucursal3.sales.customers_identidad i
        INNER JOIN BikeStores_Sucursal3.sales.customers_contacto c ON i.customer_id = c.customer_id
)
SELECT COUNT(*) AS total_clientes_reconstruidos
    FROM ClientesDistribuidos;
GO



-- =========================================================
-- CONSULTA DISTRIBUIDA: DETALLE DE VENTAS
-- =========================================================

WITH DetallesDistribuidos AS (

    -- SUCURSAL 1
    SELECT
        oi.order_id,
        oi.item_id,
        oi.product_id,
        oi.quantity,
        oi.list_price,
        oi.discount,
        o.order_date,
        o.store_id AS Sucursal

    FROM BikeStores_Sucursal1.sales.order_items oi
    INNER JOIN BikeStores_Sucursal1.sales.orders_operativos o ON oi.order_id = o.order_id

    UNION ALL

    -- SUCURSAL 2
    SELECT
        oi.order_id,
        oi.item_id,
        oi.product_id,
        oi.quantity,
        oi.list_price,
        oi.discount,
        o.order_date,
        o.store_id AS Sucursal

    FROM BikeStores_Sucursal2.sales.order_items oi
    INNER JOIN BikeStores_Sucursal2.sales.orders_operativos o ON oi.order_id = o.order_id

    UNION ALL

    -- SUCURSAL 3
    SELECT
        oi.order_id,
        oi.item_id,
        oi.product_id,
        oi.quantity,
        oi.list_price,
        oi.discount,
        o.order_date,
        o.store_id AS Sucursal

    FROM BikeStores_Sucursal3.sales.order_items oi
    INNER JOIN BikeStores_Sucursal3.sales.orders_operativos o ON oi.order_id = o.order_id
)

SELECT TOP 30
    d.order_id AS Pedido,
    d.order_date AS Fecha,
    d.Sucursal,
    p.product_name AS Producto,
    b.brand_name AS Marca,
    c.category_name AS Categoria,
    d.quantity AS Cantidad,
    d.list_price AS Precio_Unitario,
    d.discount AS Descuento,
    CAST(
        d.quantity * d.list_price * (1 - d.discount)
        AS DECIMAL(12,2)
    ) AS Total_Linea

    FROM DetallesDistribuidos d
    INNER JOIN BikeStores_Central.production.products p ON d.product_id = p.product_id
    INNER JOIN BikeStores_Central.production.brands b ON p.brand_id = b.brand_id
    INNER JOIN BikeStores_Central.production.categories c ON p.category_id = c.category_id

    ORDER BY d.order_date DESC;
GO



-- =========================================================
-- CONSULTA DISTRIBUIDA: INVENTARIO CONSOLIDADO
-- =========================================================

WITH InventarioDistribuido AS (

    SELECT
        product_id,
        store_id AS Sucursal,
        quantity AS Existencias
        
    FROM BikeStores_Sucursal1.production.stocks

    UNION ALL

    SELECT
        product_id,
        store_id AS Sucursal,
        quantity AS Existencias

    FROM BikeStores_Sucursal2.production.stocks

    UNION ALL

    SELECT
        product_id,
        store_id AS Sucursal,
        quantity AS Existencias

    FROM BikeStores_Sucursal3.production.stocks
)

SELECT
    p.product_name AS Producto,
    b.brand_name AS Marca,
    c.category_name AS Categoria,
    i.Sucursal,
    i.Existencias

    FROM InventarioDistribuido i
    INNER JOIN BikeStores_Central.production.products p ON i.product_id = p.product_id
    INNER JOIN BikeStores_Central.production.brands b ON p.brand_id = b.brand_id
    INNER JOIN BikeStores_Central.production.categories c ON p.category_id = c.category_id

    ORDER BY p.product_name, i.Sucursal;
GO


-- RESUMEN DE INVENTARIO POR SUCURSAL

SELECT
    store_id AS Sucursal,
    COUNT(*) AS Productos_Registrados,
    SUM(quantity) AS Total_Existencias

    FROM BikeStores_Sucursal1.production.stocks
    GROUP BY store_id

UNION ALL

SELECT
    store_id AS Sucursal,
    COUNT(*) AS Productos_Registrados,
    SUM(quantity) AS Total_Existencias
    
    FROM BikeStores_Sucursal2.production.stocks
    GROUP BY store_id

UNION ALL

SELECT
    store_id AS Sucursal,
    COUNT(*) AS Productos_Registrados,
    SUM(quantity) AS Total_Existencias

    FROM BikeStores_Sucursal3.production.stocks
    GROUP BY store_id

    ORDER BY Sucursal;
GO


-- =========================================================
-- CONSULTA: CANTIDAD DE PEDIDOS POR SUCURSAL Y ESTADO
-- =========================================================

WITH Pedidos AS (

    SELECT order_id, order_status, store_id
    FROM BikeStores_Sucursal1.sales.orders_operativos

    UNION ALL

    SELECT order_id, order_status, store_id
    FROM BikeStores_Sucursal2.sales.orders_operativos

    UNION ALL

    SELECT order_id, order_status, store_id
    FROM BikeStores_Sucursal3.sales.orders_operativos
)

SELECT
    s.store_name AS Sucursal,
    p.order_status AS Estado,
    COUNT(*) AS Cantidad_Pedidos

    FROM Pedidos p
    INNER JOIN BikeStores_Central.sales.stores s ON p.store_id = s.store_id

    GROUP BY s.store_name, p.order_status
    ORDER BY s.store_name, p.order_status;
GO


-- =========================================================
-- CONSULTA: PRODUCTOS NO MIGRADOS A LA SEDE CENTRAL
-- =========================================================

SELECT
    p.product_id AS ID_Producto,
    p.product_name AS Producto

    FROM BikeStores.production.products p
    LEFT JOIN BikeStores_Central.production.products pc ON p.product_id = pc.product_id
    
    WHERE pc.product_id IS NULL
    ORDER BY p.product_id;
GO

