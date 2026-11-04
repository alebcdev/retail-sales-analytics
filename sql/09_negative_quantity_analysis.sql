-- Análisis de las cantidades negativas
USE retail_sales;

-- Análisis general de operaciones con cantidades negativas
USE retail_sales;

SELECT
    COUNT(*) AS numero_registros,
    COUNT(DISTINCT InvoiceNo) AS numero_facturas,
    SUM(Quantity) AS unidades_netos,
    ROUND(SUM(LineTotal), 2) AS importe_neto,
    COUNT(DISTINCT CustomerID) AS clientes_distintos
FROM online_retail
WHERE IsCancelled = 0
  AND Quantity < 0;

-- Analizar precios de operaciones con cantidades negativas
SELECT
    COUNT(*) AS numero_registros,
    SUM(UnitPrice = 0) AS registros_precio_cero,
    SUM(UnitPrice > 0) AS registros_precio_positivo,
    SUM(UnitPrice < 0) AS registros_precio_negativo,
    ROUND(SUM(LineTotal), 2) AS importe_total
FROM online_retail
WHERE IsCancelled = 0
  AND Quantity < 0;
  
-- Analizar códigos de producto en operaciones con cantidades negativas
SELECT
    StockCode AS codigo_producto,
    MAX(Description) AS descripcion,
    COUNT(*) AS numero_registros,
    SUM(Quantity) AS unidades_negativas,
    SUM(UnitPrice = 0) AS registros_precio_cero
FROM online_retail
WHERE IsCancelled = 0
  AND Quantity < 0
GROUP BY StockCode
ORDER BY numero_registros DESC
LIMIT 20;

-- Clasificar operaciones negativas según su descripción
SELECT
    Description AS descripcion,
    COUNT(*) AS numero_registros,
    SUM(Quantity) AS unidades_negativas
FROM online_retail
WHERE IsCancelled = 0
  AND Quantity < 0
GROUP BY Description
ORDER BY numero_registros DESC
LIMIT 20;
