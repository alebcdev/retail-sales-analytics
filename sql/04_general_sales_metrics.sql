-- Análisis general de ventas
USE retail_sales;

SELECT
    ROUND(SUM(LineTotal), 2) AS ingresos_totales,
    SUM(Quantity) AS unidades_vendidas,
    COUNT(DISTINCT InvoiceNo) AS numero_facturas,
    COUNT(DISTINCT CustomerID) AS clientes_distintos
FROM online_retail
WHERE IsCancelled = 0
  AND Quantity > 0
  AND UnitPrice > 0;