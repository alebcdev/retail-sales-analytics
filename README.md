# Retail Sales Analytics

Proyecto de análisis de datos de ventas de una tienda online (*Online Retail*) que integra **Python, SQL (MySQL) y Power BI** para transformar datos transaccionales en indicadores comerciales, detectar patrones y formular recomendaciones de negocio.

El análisis cubre el periodo comprendido entre el **1 de diciembre de 2010 y el 9 de diciembre de 2011**. El trabajo se desarrolla en distintas fases: exploración, limpieza y validación, análisis mediante SQL y visualización interactiva en Power BI.

---

## Tabla de contenidos

- [Objetivos](#objetivos)
- [Tecnologías](#tecnologías)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Fuente de datos](#fuente-de-datos)
- [Proceso de trabajo](#proceso-de-trabajo)
  - [1. Análisis exploratorio](#1-análisis-exploratorio-eda)
  - [2. Limpieza y preparación](#2-limpieza-y-preparación-de-los-datos)
  - [3. Análisis con SQL](#3-análisis-comercial-con-sql)
  - [4. Dashboard en Power BI](#4-visualización-en-power-bi)
- [Principales resultados](#principales-resultados)
- [Criterios de cálculo](#criterios-de-cálculo)
- [Conclusiones y recomendaciones](#conclusiones-y-recomendaciones)
- [Cómo ejecutar el proyecto](#cómo-ejecutar-el-proyecto)
- [Limitaciones](#limitaciones)
- [Autoría y licencia de los datos](#autoría-y-licencia-de-los-datos)

---

## Objetivos

El objetivo principal es analizar el comportamiento comercial de una tienda online a partir de sus transacciones. En concreto, se pretende:

- Explorar la estructura y la calidad de los datos antes de realizar transformaciones.
- Identificar valores ausentes, duplicados, cancelaciones, operaciones negativas y valores extremos.
- Preparar un conjunto de datos consistente sin eliminar información relevante de forma arbitraria.
- Analizar la evolución de los ingresos y las ventas por periodo.
- Identificar los países y productos con mayor contribución a los ingresos.
- Estudiar la actividad y la concentración de ingresos por cliente.
- Comunicar los resultados mediante un dashboard interactivo y recomendaciones de negocio.

## Tecnologías

| Tecnología | Uso |
|---|---|
| Python 3.12 | Exploración, limpieza, transformación y preparación de datos |
| pandas | Manipulación y análisis de datos |
| Jupyter Notebook | Desarrollo y documentación del análisis |
| MySQL | Almacenamiento y consultas de análisis comercial |
| mysql-connector-python | Conexión e inserción de datos desde Python |
| SQL | Validación y análisis de ventas, productos, países y clientes |
| Power BI Desktop | Modelado, indicadores y visualización interactiva |

## Estructura del proyecto

```text
retail-sales-analytics/
│
├── data/
│   ├── raw/
│   │   └── Online_Retail.xlsx
│   └── processed/
│       └── online_retail_clean.csv
│
├── notebooks/
│   ├── 01_eda.ipynb
│   ├── 02_data_cleaning.ipynb
│   └── 03_sql_analysis.ipynb
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_table.sql
│   ├── 03_import_validation.sql
│   ├── 04_general_sales_metrics.sql
│   ├── 05_monthly_sales_analysis.sql
│   ├── 06_sales_by_country.sql
│   ├── 07_product_performance.sql
│   ├── 08_customer_analysis.sql
│   └── 09_negative_quantity_analysis.sql
│
├── powerbi/
│   └── retail_sales_dashboard.pbix
│
├── reports/
│   └── business_insights.md
│
└── README.md
```

> **Nota sobre los archivos de datos:** los archivos originales y procesados se generan durante la ejecución del flujo de trabajo y no están incluidos en todos los paquetes del proyecto. El notebook de exploración descarga el dataset original cuando no lo encuentra en `data/raw/`.

## Fuente de datos

El proyecto utiliza el dataset **Online Retail**, publicado por el [UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/352/online+retail).

- **Institución:** UCI Machine Learning Repository.
- **Autor:** Daqing Chen.
- **Periodo:** 01/12/2010 – 09/12/2011.
- **Formato original:** Excel (`Online Retail.xlsx`).
- **Licencia:** Creative Commons Attribution 4.0 International (CC BY 4.0).

El conjunto original contiene **541.909 filas y 8 columnas**. Cada registro representa una línea de una factura e incluye información de factura, producto, cantidad, fecha, precio unitario, cliente y país.

### Variables originales

| Columna | Descripción |
|---|---|
| `InvoiceNo` | Identificador de la factura. Los identificadores que comienzan por `C` corresponden a cancelaciones. |
| `StockCode` | Código del producto. |
| `Description` | Descripción del producto. |
| `Quantity` | Cantidad registrada en la línea de factura. |
| `InvoiceDate` | Fecha y hora de la factura. |
| `UnitPrice` | Precio unitario en libras esterlinas (£). |
| `CustomerID` | Identificador del cliente, cuando está disponible. |
| `Country` | País asociado a la transacción. |

## Proceso de trabajo

### 1. Análisis exploratorio (EDA)

Notebook: [`notebooks/01_eda.ipynb`](notebooks/01_eda.ipynb)

Se realiza una primera inspección del dataset para conocer su estructura y detectar posibles problemas de calidad.

Las comprobaciones incluyen:

- Dimensiones, columnas y tipos de datos.
- Valores ausentes y filas duplicadas.
- Cantidades negativas y precios iguales a cero o negativos.
- Facturas canceladas.
- Valores extremos en cantidades y precios.
- Códigos de producto especiales y conceptos que requieren una interpretación diferenciada.

El análisis exploratorio identifica, entre otros aspectos:

- **5.268 filas duplicadas exactas**.
- **135.080 valores ausentes en `CustomerID` (24,93 %)**.
- **1.454 valores ausentes en `Description` (0,27 %)**.
- **9.288 filas** asociadas a facturas canceladas, correspondientes a **3.836 facturas distintas**.
- **10.624 registros con cantidades negativas**.

Estos hallazgos sirven para definir las reglas de preparación de los datos. No se considera que un valor negativo o extremo sea automáticamente un error.

### 2. Limpieza y preparación de los datos

Notebook: [`notebooks/02_data_cleaning.ipynb`](notebooks/02_data_cleaning.ipynb)

La limpieza parte de una copia del dataset original, que se conserva sin modificaciones.

Se aplican las siguientes reglas:

1. **Duplicados:** se eliminan únicamente las filas completamente duplicadas, conservando la primera aparición.
2. **Valores ausentes:** se mantienen los registros sin `CustomerID` o `Description`. No se imputan identificadores ni descripciones.
3. **Identificador de cliente:** `CustomerID` se convierte al tipo entero nullable `Int64`.
4. **Cancelaciones:** se crea `IsCancelled`, que identifica las facturas cuyo número comienza por `C`.
5. **Cantidades y precios especiales:** se crean los indicadores `IsNegativeQuantity`, `IsZeroPrice` e `IsNegativePrice`.
6. **Importe por línea:** se calcula `LineTotal` como `Quantity * UnitPrice`.
7. **Valores extremos y códigos especiales:** se conservan para poder investigarlos y tratarlos de forma diferenciada cuando sea necesario.

El resultado validado contiene:

| Indicador | Resultado |
|---|---:|
| Filas originales | 541.909 |
| Duplicados exactos eliminados | 5.268 |
| Filas procesadas | 536.641 |
| Columnas procesadas | 13 |
| Duplicados exactos restantes | 0 |

El conjunto procesado se guarda en:

```text
data/processed/online_retail_clean.csv
```

### 3. Análisis comercial con SQL

Notebook: [`notebooks/03_sql_analysis.ipynb`](notebooks/03_sql_analysis.ipynb)

Scripts: [`sql/`](sql/)

Los datos limpios se preparan para MySQL. Los indicadores booleanos se convierten a valores `0/1`, los valores ausentes se insertan como `NULL` y los importes se adaptan a tipos decimales.

La importación se realiza mediante `mysql-connector-python`, utilizando inserciones por lotes de 5.000 registros. El notebook comprueba que la tabla esté vacía antes de insertar para evitar duplicaciones accidentales.

Los scripts SQL cubren los siguientes análisis:

| Script | Análisis |
|---|---|
| `01_create_database.sql` | Creación de la base de datos `retail_sales`. |
| `02_create_table.sql` | Creación de la tabla `online_retail`. |
| `03_import_validation.sql` | Validación de filas, valores nulos y cancelaciones. |
| `04_general_sales_metrics.sql` | Indicadores generales de ventas. |
| `05_monthly_sales_analysis.sql` | Evolución mensual de ingresos y actividad. |
| `06_sales_by_country.sql` | Rendimiento comercial por país. |
| `07_product_performance.sql` | Rendimiento y operaciones destacadas por producto. |
| `08_customer_analysis.sql` | Rendimiento y concentración de ingresos por cliente. |
| `09_negative_quantity_analysis.sql` | Investigación de operaciones con cantidades negativas. |

Los indicadores principales excluyen las facturas canceladas y las líneas con cantidades o precios no positivos. Los análisis específicos de operaciones negativas utilizan criterios distintos para estudiar esos movimientos por separado.

### 4. Visualización en Power BI

Archivo: [`powerbi/retail_sales_dashboard.pbix`](powerbi/retail_sales_dashboard.pbix)

El dashboard organiza los resultados en cuatro páginas temáticas. Incluye indicadores KPI, gráficos de evolución, rankings, comparaciones y filtros de fecha y país para explorar distintos subconjuntos de datos.

#### 01. Resumen ejecutivo

Presenta una visión global del rendimiento comercial:

- Ingresos totales.
- Unidades vendidas.
- Número de facturas.
- Clientes identificados.
- Ticket medio.
- Evolución mensual de ingresos.
- Principales países por ingresos.
- Participación de Reino Unido en la facturación.
- Ingresos medios por cliente y variación mensual.

#### 02. Análisis temporal

Permite estudiar la evolución de las ventas a lo largo del periodo:

- Evolución mensual de ingresos.
- Ingresos según el día de la semana.
- Número de facturas por mes.
- Mes con mayores ingresos.
- Ticket medio e ingresos medios diarios.

#### 03. Análisis de productos

Se centra en la contribución de los productos a los resultados:

- Productos distintos.
- Ingresos y unidades vendidas.
- Ingresos medios por producto.
- Top 10 de productos por ingresos.
- Top 10 de productos por unidades vendidas.
- Concentración de ingresos por producto.

#### 04. Análisis de clientes

Analiza la actividad y la contribución de los clientes identificados:

- Clientes distintos.
- Ingresos de clientes identificados.
- Ingresos medios por cliente.
- Ticket medio.
- Relación entre frecuencia de compra e ingresos por cliente.
- Top 10 de clientes por ingresos.
- Distribución de clientes según su frecuencia de compra.

Las páginas permiten aplicar filtros de fecha y país para profundizar en los resultados y comparar segmentos. Las capturas del dashboard adjuntas al proyecto muestran las cuatro páginas y ejemplos de análisis con filtros aplicados.

## Principales resultados

Los resultados siguientes corresponden a las métricas comerciales calculadas con el criterio de ventas válidas definido en el proyecto.

| Indicador | Resultado |
|---|---:|
| Ingresos totales | **£10.642.110,80** |
| Unidades vendidas | **5.572.416** |
| Facturas | **19.960** |
| Clientes identificados | **4.338** |
| Ticket medio | **£533,17** |
| Participación de Reino Unido en los ingresos | **84,59 %** |

### 1. Concentración geográfica

Reino Unido genera **£9.001.744,09**, equivalente al **84,59 %** de los ingresos totales.

El negocio presenta una elevada dependencia del mercado británico. Los demás países representan oportunidades potenciales de análisis, aunque no es posible determinar su rentabilidad sin información de costes y márgenes.

### 2. Evolución temporal

**Noviembre de 2011** es el mes con mayores ingresos observados, con **£1.503.866,78**.

Diciembre de 2011 registra **£637.790,33**, pero los datos solo llegan hasta el 9 de diciembre. Por tanto, no debe compararse directamente con meses completos ni interpretarse como una caída mensual de la demanda.

### 3. Operación extraordinaria de producto

Se identifica una línea de factura del producto `23843` (*PAPER CRAFT LITTLE BIRDIE*) con:

- Cantidad: **80.995 unidades**.
- Importe de línea: **£168.469,60**.

Es una operación de volumen extraordinario que puede afectar a los rankings de productos. Debe investigarse su contexto antes de utilizarla como referencia de demanda habitual. No se elimina automáticamente porque el valor extremo, por sí solo, no demuestra que sea incorrecto.

### 4. Concentración de ingresos por cliente

El **10 % superior de los clientes identificados concentra el 61,45 % de los ingresos**.

Este resultado refleja una dependencia significativa de un grupo reducido de clientes y justifica profundizar en su frecuencia, recencia y evolución de compra.

### Informe de resultados

El análisis detallado, las evidencias, las recomendaciones y las limitaciones de cada hallazgo están documentados en [`reports/business_insights.md`](reports/business_insights.md).

## Criterios de cálculo

Para mantener una definición consistente de las métricas comerciales principales, se consideran ventas válidas las líneas que cumplen simultáneamente:

```sql
WHERE IsCancelled = 0
  AND Quantity > 0
  AND UnitPrice > 0
```

A partir de ese filtro:

- **Ingresos totales:** suma de `LineTotal`.
- **Unidades vendidas:** suma de `Quantity`.
- **Número de facturas:** recuento de `InvoiceNo` distintos.
- **Clientes identificados:** recuento de `CustomerID` distintos no nulos.
- **Ticket medio:** ingresos totales divididos entre el número de facturas.

Los análisis de clientes excluyen los registros sin `CustomerID`, mientras que los indicadores generales de ventas pueden incluir transacciones sin identificador de cliente.

Las cantidades negativas se conservan en el conjunto procesado, pero no forman parte de las métricas de ventas positivas. No todas las cantidades negativas se interpretan automáticamente como devoluciones convencionales.

## Conclusiones y recomendaciones

El análisis muestra tres características destacadas: concentración geográfica en Reino Unido, concentración de ingresos en clientes de alto valor y presencia de operaciones extraordinarias que requieren contexto antes de orientar decisiones comerciales.

A partir de estos resultados se proponen cuatro líneas de actuación:

1. **Evaluar los mercados internacionales:** estudiar los países que ya generan ingresos y valorar su potencial teniendo en cuenta costes, logística y márgenes.
2. **Profundizar en los clientes de alto valor:** analizar frecuencia, recencia y evolución de compra para orientar posibles acciones de fidelización.
3. **Ampliar el histórico temporal:** incorporar más ejercicios para comprobar si los patrones mensuales y semanales son recurrentes.
4. **Investigar operaciones extraordinarias:** revisar los registros con cantidades o importes excepcionalmente elevados antes de utilizarlos para decisiones de inventario o estimaciones de demanda.

Estas recomendaciones son hipótesis de actuación derivadas de los datos observados; el dataset no permite cuantificar su impacto económico ni demostrar relaciones causales.

## Cómo ejecutar el proyecto

### Requisitos

- Python 3.12 o compatible.
- Jupyter Notebook.
- MySQL Server y MySQL Workbench (recomendado para administrar la base de datos).
- Power BI Desktop para abrir y explorar el dashboard.

### 1. Clonar el repositorio

```bash
git clone <URL_DEL_REPOSITORIO>
cd retail-sales-analytics
```

### 2. Crear un entorno e instalar dependencias

```bash
python -m venv .venv
```

Activar el entorno:

```bash
# Windows
.venv\Scripts\activate

# macOS / Linux
source .venv/bin/activate
```

Instalar las dependencias utilizadas:

```bash
pip install pandas openpyxl jupyter mysql-connector-python
```

### 3. Ejecutar los notebooks en orden

Iniciar Jupyter:

```bash
jupyter notebook
```

Ejecutar los notebooks en este orden:

1. `01_eda.ipynb`: descarga (si es necesario) y explora el dataset original.
2. `02_data_cleaning.ipynb`: limpia y valida los datos, y genera `data/processed/online_retail_clean.csv`.
3. `03_sql_analysis.ipynb`: prepara los datos y realiza la importación y validación en MySQL.

Es importante mantener la estructura de carpetas del proyecto, ya que los notebooks utilizan rutas relativas.

### 4. Preparar MySQL

Ejecutar los scripts en este orden:

1. `sql/01_create_database.sql`
2. `sql/02_create_table.sql`

A continuación, configurar en el notebook `03_sql_analysis.ipynb` los parámetros de conexión de MySQL (`host`, `port`, `user` y contraseña) para el entorno local.

Ejecutar la importación desde el notebook. La tabla `online_retail` debe estar vacía: el notebook detiene la inserción si ya contiene registros para evitar duplicados accidentales.

Después de importar los datos, ejecutar `sql/03_import_validation.sql` y los scripts de análisis que se quieran consultar (`04` a `09`).

### 5. Abrir el dashboard

Abrir `powerbi/retail_sales_dashboard.pbix` con Power BI Desktop. Si se necesita actualizar el modelo con una nueva copia de los datos, comprobar y configurar primero el origen de datos y las credenciales correspondientes en Power BI.

> La conexión concreta del archivo PBIX depende de la configuración con la que se creó el modelo. No se presupone aquí un origen de datos que no pueda verificarse desde los archivos del proyecto.

## Limitaciones

- **Cobertura temporal:** el dataset contiene aproximadamente un año de actividad y diciembre de 2011 está incompleto.
- **Identificación de clientes:** una parte de las transacciones no dispone de `CustomerID`, por lo que no puede atribuirse a clientes concretos.
- **Ausencia de costes:** no hay información de costes de producto, logística, marketing u otros gastos. Los importes analizados representan ingresos, no beneficios ni márgenes.
- **Operaciones especiales:** las cancelaciones, cantidades negativas, precios no positivos y códigos especiales requieren interpretaciones diferenciadas.
- **Valores extremos:** se conservan mientras no exista evidencia suficiente para justificar su corrección o exclusión.
- **Concentración de clientes:** una contribución elevada a los ingresos no demuestra por sí misma riesgo de abandono.
- **Estacionalidad:** un único ejercicio no permite confirmar que los patrones observados se repitan en años posteriores.
- **Alcance del análisis:** los resultados son descriptivos; no permiten establecer causalidad ni cuantificar el efecto de las recomendaciones.

## Autoría y licencia de los datos

Proyecto desarrollado con fines de aprendizaje y portfolio de análisis de datos.

El dataset **Online Retail** pertenece a sus autores y se distribuye a través del UCI Machine Learning Repository bajo licencia **CC BY 4.0**. Consulta la [ficha original del dataset](https://archive.ics.uci.edu/dataset/352/online+retail) para conocer sus condiciones de atribución y uso.

---
