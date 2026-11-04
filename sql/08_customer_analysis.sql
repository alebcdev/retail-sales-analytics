-- Análisis de ventas por cliente
USE retail_sales;

SELECT
    CustomerID AS id_cliente,
    COUNT(DISTINCT InvoiceNo) AS numero_facturas,
    ROUND(SUM(LineTotal), 2) AS ingresos_totales,
    SUM(Quantity) AS unidades_compradas,
    ROUND(
        SUM(LineTotal) / COUNT(DISTINCT InvoiceNo),
        2
    ) AS gasto_medio_por_factura
FROM online_retail
WHERE IsCancelled = 0
  AND Quantity > 0
  AND UnitPrice > 0
  AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY ingresos_totales DESC
LIMIT 20;

-- Concentración de ingresos por cliente
USE retail_sales;

WITH ingresos_cliente AS (
    SELECT
        CustomerID,
        SUM(LineTotal) AS ingresos_totales
    FROM online_retail
    WHERE IsCancelled = 0
      AND Quantity > 0
      AND UnitPrice > 0
      AND CustomerID IS NOT NULL
    GROUP BY CustomerID
),
clientes_ordenados AS (
    SELECT
        CustomerID,
        ingresos_totales,
        ROW_NUMBER() OVER (
            ORDER BY ingresos_totales DESC
        ) AS posicion,
        COUNT(*) OVER () AS total_clientes,
        SUM(ingresos_totales) OVER () AS ingresos_globales
    FROM ingresos_cliente
)
SELECT
    COUNT(*) AS total_clientes,
    SUM(
        CASE
            WHEN posicion <= CEIL(total_clientes * 0.10)
            THEN ingresos_totales
            ELSE 0
        END
    ) AS ingresos_top_10_por_ciento,
    ROUND(
        100 * SUM(
            CASE
                WHEN posicion <= CEIL(total_clientes * 0.10)
                THEN ingresos_totales
                ELSE 0
            END
        ) / MAX(ingresos_globales),
        2
    ) AS porcentaje_ingresos_top_10
FROM clientes_ordenados;

