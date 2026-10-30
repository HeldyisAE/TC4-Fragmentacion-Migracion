
-- =========================================================
-- ANÁLISIS: VENTAS TOTALES POR SUCURSAL
-- =========================================================

WITH DetallesVentas AS (

    -- SUCURSAL 1
    SELECT
        o.order_id AS Pedido,
        o.store_id AS Sucursal,
        oi.quantity AS Cantidad,
        oi.list_price AS Precio_Unitario,
        oi.discount AS Descuento,
        CAST(
            oi.quantity * oi.list_price * (1 - oi.discount)
            AS DECIMAL(18,2)
        ) AS Total_Linea

        FROM BikeStores_Sucursal1.sales.order_items oi
        INNER JOIN BikeStores_Sucursal1.sales.orders_operativos o ON oi.order_id = o.order_id

    UNION ALL

    -- SUCURSAL 2
    SELECT
        o.order_id,
        o.store_id,
        oi.quantity,
        oi.list_price,
        oi.discount,
        CAST(
            oi.quantity * oi.list_price * (1 - oi.discount)
            AS DECIMAL(18,2)
        )

        FROM BikeStores_Sucursal2.sales.order_items oi
        INNER JOIN BikeStores_Sucursal2.sales.orders_operativos o ON oi.order_id = o.order_id

    UNION ALL

    -- SUCURSAL 3
    SELECT
        o.order_id,
        o.store_id,
        oi.quantity,
        oi.list_price,
        oi.discount,
        CAST(
            oi.quantity * oi.list_price * (1 - oi.discount)
            AS DECIMAL(18,2)
        )

        FROM BikeStores_Sucursal3.sales.order_items oi
        INNER JOIN BikeStores_Sucursal3.sales.orders_operativos o ON oi.order_id = o.order_id
)

SELECT
    s.store_name AS Sucursal,
    COUNT(DISTINCT d.Pedido) AS Total_Pedidos,
    COUNT(*) AS Lineas_Vendidas,
    SUM(d.Cantidad) AS Unidades_Vendidas,
    SUM(d.Total_Linea) AS Ventas_Totales

    FROM DetallesVentas d
    INNER JOIN BikeStores_Central.sales.stores s ON d.Sucursal = s.store_id
    
    GROUP BY s.store_name
    ORDER BY Ventas_Totales DESC;
GO
