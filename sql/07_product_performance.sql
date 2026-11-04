-- Análisis de rendimiento por producto
USE retail_sales;

SELECT
    StockCode AS codigo_producto,
    MAX(Description) AS descripcion,
    ROUND(SUM(LineTotal), 2) AS ingresos_totales,
    SUM(Quantity) AS unidades_vendidas,
    COUNT(DISTINCT InvoiceNo) AS numero_facturas
FROM online_retail
WHERE IsCancelled = 0
  AND Quantity > 0
  AND UnitPrice > 0
GROUP BY StockCode
ORDER BY ingresos_totales DESC
LIMIT 20;

-- Investigar el producto con volumen extraordinario
SELECT
    InvoiceNo AS numero_factura,
    InvoiceDate AS fecha_factura,
    StockCode AS codigo_producto,
    Description AS descripcion,
    Quantity AS cantidad,
    UnitPrice AS precio_unitario,
    LineTotal AS importe_total,
    Country AS pais
FROM online_retail
WHERE StockCode = '23843'
  AND IsCancelled = 0
  AND Quantity > 0
  AND UnitPrice > 0
ORDER BY InvoiceDate;

-- Identificar las 20 líneas con mayor cantidad vendida
SELECT
    InvoiceNo AS numero_factura,
    InvoiceDate AS fecha_factura,
    StockCode AS codigo_producto,
    Description AS descripcion,
    Quantity AS cantidad,
    UnitPrice AS precio_unitario,
    LineTotal AS importe_total,
    Country AS pais
FROM online_retail
WHERE IsCancelled = 0
  AND Quantity > 0
  AND UnitPrice > 0
ORDER BY Quantity DESC
LIMIT 20;