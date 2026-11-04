# Business Insights & Recomendaciones

## 1. Resumen ejecutivo

Este análisis estudia las ventas del dataset **Online Retail** desde
diciembre de 2010 hasta diciembre de 2011. El objetivo es identificar
patrones de ventas, concentración geográfica y de clientes,
comportamiento temporal y posibles anomalías a nivel de producto.

Para calcular los indicadores comerciales se consideran ventas válidas
aquellas líneas que cumplen simultáneamente estas condiciones:

-   La factura no está cancelada (`IsCancelled = 0`).
-   La cantidad es positiva (`Quantity > 0`).
-   El precio unitario es positivo (`UnitPrice > 0`).

Con este criterio, los principales resultados son:

  Indicador                                             Resultado
  ---------------------------------------------- ----------------
  Ingresos totales                                 £10,642,110.80
  Unidades vendidas                                     5,572,416
  Facturas                                                 19,960
  Clientes identificados                                    4,338
  Ticket medio                                            £533.17
  Participación de Reino Unido en los ingresos             84.59%

Los resultados muestran una elevada concentración de ingresos en Reino
Unido y en un grupo reducido de clientes. También se observa un máximo
mensual de ingresos en noviembre de 2011 y una operación de producto con
un volumen extraordinario que merece revisión.

------------------------------------------------------------------------

## 2. Concentración geográfica de ingresos

### Evidencia

-   Ingresos totales: **£10,642,110.80**.
-   Ingresos de Reino Unido: **£9,001,744.09**.
-   Participación de Reino Unido: **84.59%** de los ingresos.

### Insight

La actividad comercial está fuertemente concentrada en el mercado
británico. Por tanto, el rendimiento global del negocio depende en gran
medida de la evolución de este mercado.

### Implicación para el negocio

Esta concentración geográfica puede representar exposición a cambios en
la demanda o en las condiciones comerciales del mercado principal. Los
ingresos de otros países muestran, al mismo tiempo, que existe actividad
comercial internacional.

### Recomendación

Analizar los países que ya generan ingresos para identificar mercados en
los que podría estudiarse un crecimiento adicional. Antes de proponer
una expansión, convendría evaluar rentabilidad, costes logísticos,
recurrencia de compra y potencial de cada mercado.

### Limitaciones

El dataset no contiene costes, márgenes, gastos de envío ni rentabilidad
por país. Por tanto, no permite concluir qué mercados serían más
rentables para una expansión.

**Visual relacionado:** Power BI --- `01. Resumen ejecutivo`, gráfico de
ingresos por país e indicador de participación de Reino Unido.

------------------------------------------------------------------------

## 3. Patrones temporales de ventas

### Evidencia

-   Noviembre de 2011 es el mes con mayores ingresos observados:
    **£1,503,866.78**.
-   Diciembre de 2011 registra **£637,790.33**, pero los datos solo
    llegan hasta el **9 de diciembre**.

### Insight

Noviembre presenta el mayor volumen mensual de ingresos dentro del
periodo analizado. Diciembre es un periodo incompleto y no puede
compararse directamente con meses completos.

### Implicación para el negocio

El análisis temporal puede ayudar a comprender cómo se distribuyen las
ventas y servir como punto de partida para la planificación comercial y
operativa. No obstante, los resultados de un único año no permiten
confirmar que el patrón observado se repita.

### Recomendación

Profundizar en el comportamiento diario y semanal de los meses con
mayores ingresos. Para identificar estacionalidad y mejorar la
planificación, sería conveniente incorporar varios años de información y
comparar los mismos periodos entre ejercicios.

### Limitaciones

El dataset cubre aproximadamente un año y diciembre de 2011 está
incompleto. No se puede afirmar que noviembre sea sistemáticamente el
mejor mes ni atribuir la diferencia de diciembre a una caída de la
demanda.

**Visual relacionado:** Power BI --- `02. Análisis temporal`, evolución
mensual de ingresos y análisis por día de la semana.

------------------------------------------------------------------------

## 4. Anomalías a nivel de producto

### Evidencia

Se ha identificado una línea de factura extraordinaria asociada al
producto:

  Campo                 Valor
  --------------------- ---------------------------
  StockCode             `23843`
  Producto              PAPER CRAFT LITTLE BIRDIE
  Cantidad              80,995 unidades
  Importe de la línea   £168,469.60

### Insight

Esta operación tiene un volumen extraordinario y puede influir de manera
significativa en los rankings de productos por unidades e ingresos.
Merece revisión antes de interpretarla como demanda habitual.

### Implicación para el negocio

Si se utiliza el volumen de esta operación para tomar decisiones de
inventario o estimar demanda recurrente, podría obtenerse una visión
distorsionada del comportamiento normal del producto.

### Recomendación

Revisar la factura y el contexto de la operación para determinar si
corresponde a una compra mayorista, una operación especial o un posible
problema de registro. Mantener el dato en el análisis hasta disponer de
evidencia que justifique cualquier modificación o exclusión.

### Limitaciones

El volumen elevado no demuestra por sí solo que el registro sea erróneo.
No se debe eliminar ni corregir automáticamente sin investigar su
origen.

**Visual relacionado:** Power BI --- `03. Análisis de productos`,
rankings de productos y análisis de concentración.

------------------------------------------------------------------------

## 5. Concentración de los ingresos por cliente

### Evidencia

-   Clientes identificados con ventas válidas: **4,338**.
-   El 10% superior de los clientes concentra el **61.45%** de los
    ingresos.

### Insight

Una proporción relativamente pequeña de clientes genera una parte
importante de los ingresos. Esto indica una concentración significativa
de la facturación en clientes de alto valor.

### Implicación para el negocio

La evolución de los ingresos puede verse afectada de forma relevante por
los cambios en el comportamiento de un grupo reducido de clientes. La
pérdida o reducción de actividad de algunos de ellos podría tener un
impacto considerable en las ventas.

### Recomendación

Analizar a los clientes de mayor contribución, estudiando frecuencia de
compra, evolución temporal y recencia. Esta información podría servir
para diseñar acciones de fidelización y detectar cambios en su
comportamiento.

### Limitaciones

La concentración de ingresos no demuestra que los clientes de alto valor
estén en riesgo de abandonar la empresa. Para evaluar ese riesgo sería
necesario estudiar la evolución de sus compras y disponer de un periodo
de observación más amplio.

**Visual relacionado:** Power BI --- `04. Análisis de clientes`, Top 10
de clientes por ingresos y diagrama de dispersión de frecuencia e
ingresos.

------------------------------------------------------------------------

## 6. Recomendaciones de negocio

A partir de los hallazgos anteriores, se proponen estas líneas de
actuación:

1.  **Evaluar la concentración geográfica.** Analizar los mercados
    internacionales existentes y estudiar su potencial considerando
    también costes y márgenes.
2.  **Profundizar en los clientes de alto valor.** Estudiar frecuencia,
    recencia y evolución de sus compras para orientar posibles acciones
    de fidelización.
3.  **Mejorar el análisis temporal.** Incorporar más años de datos para
    comprobar si los patrones mensuales y semanales son recurrentes.
4.  **Validar operaciones extraordinarias.** Investigar registros con
    cantidades o importes excepcionalmente elevados antes de utilizarlos
    para decisiones de inventario o demanda.

Estas recomendaciones son propuestas derivadas de los patrones
observados. El dataset no contiene información suficiente para
cuantificar su impacto económico ni para demostrar que su aplicación
produciría un resultado determinado.

------------------------------------------------------------------------

## 7. Alcance y limitaciones de los datos

Las conclusiones deben interpretarse teniendo en cuenta estas
limitaciones:

-   **Periodo:** los datos abarcan desde diciembre de 2010 hasta el 9 de
    diciembre de 2011. Diciembre de 2011 está incompleto.
-   **Identificación de clientes:** existen registros sin `CustomerID`.
    Los indicadores de clientes identificados excluyen esos registros.
-   **Criterio de ventas:** los indicadores comerciales principales
    excluyen facturas canceladas, cantidades no positivas y precios
    unitarios no positivos.
-   **Operaciones negativas:** las cantidades negativas se conservan en
    los datos procesados, pero no se consideran ventas positivas en los
    indicadores comerciales. No todas deben interpretarse
    automáticamente como devoluciones convencionales.
-   **Ausencia de costes:** no se dispone de costes de producto,
    logística, marketing ni otros gastos. El análisis mide ingresos, no
    beneficios ni márgenes.
-   **Concentración de clientes:** una contribución elevada no demuestra
    por sí misma riesgo de abandono.
-   **Anomalías:** los valores extremos se mantienen salvo que exista
    una justificación documentada para tratarlos de otra manera.
-   **Alcance descriptivo:** el análisis identifica patrones y
    asociaciones, pero no permite establecer relaciones causales.

------------------------------------------------------------------------

## 8. Conclusion

El análisis muestra que el negocio presenta una elevada concentración de
ingresos tanto geográfica como por cliente. Reino Unido aporta la mayor
parte de la facturación y el 10% superior de los clientes identificados
genera más de la mitad de los ingresos.

En el plano temporal, noviembre de 2011 destaca como el mes de mayores
ingresos observados, aunque el periodo disponible no permite confirmar
patrones estacionales recurrentes. A nivel de producto, se ha
identificado una operación extraordinaria que debe investigarse antes de
utilizarla como referencia de demanda habitual.

En conjunto, el proyecto demuestra un flujo de trabajo de análisis de
datos que integra exploración y limpieza con Python, consultas SQL y
visualización en Power BI. Las conclusiones se han formulado teniendo en
cuenta el alcance y las limitaciones del dataset, diferenciando los
resultados observados de las recomendaciones propuestas.