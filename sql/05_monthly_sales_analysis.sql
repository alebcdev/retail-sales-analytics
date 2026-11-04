-- Análisis mensual de ventas
USE retail_sales;

SELECT
    YEAR(InvoiceDate) AS anio,
    MONTH(InvoiceDate) AS mes,
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS periodo,
    ROUND(SUM(LineTotal), 2) AS ingresos_totales,
    SUM(Quantity) AS unidades_vendidas,
    COUNT(DISTINCT InvoiceNo) AS numero_facturas,
    COUNT(DISTINCT CustomerID) AS clientes_distintos
FROM online_retail
WHERE IsCancelled = 0
  AND Quantity > 0
  AND UnitPrice > 0
GROUP BY
    YEAR(InvoiceDate),
    MONTH(InvoiceDate),
    DATE_FORMAT(InvoiceDate, '%Y-%m')
ORDER BY
    anio,
    mes;