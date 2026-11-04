USE retail_sales;

SELECT COUNT(*) AS total_filas
FROM online_retail;

-- Valores nulos
SELECT
    SUM(CustomerID IS NULL) AS customer_id_nulos,
    SUM(Description IS NULL) AS description_nulos
FROM online_retail;

-- Distribución de facturas canceladas
SELECT
    IsCancelled,
    COUNT(*) AS total_registros
FROM online_retail
GROUP BY IsCancelled;