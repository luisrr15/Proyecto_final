# Análisis Exploratorio de la Ejecución Presupuestal del Perú


## 1. Contexto del conjunto de datos

El presente proyecto desarrolla un Análisis Exploratorio de Datos (EDA) utilizando información oficial del Ministerio de Economía y Finanzas (MEF) del Perú.

El conjunto de datos contiene información relacionada con la ejecución presupuestal del gasto público, permitiendo analizar la distribución del presupuesto asignado, el gasto ejecutado y el nivel de cumplimiento presupuestal.

El objetivo del análisis es identificar patrones, diferencias y posibles problemas relacionados con la capacidad de ejecución del gasto público a nivel territorial y según nivel de gobierno.


## 2. Fuente de datos

**Institución proveedora de datos:**

Ministerio de Economía y Finanzas (MEF) del Perú.


**Temática del conjunto de datos:**

Ejecución presupuestal del gasto público.


**Objetivo de la base de datos:**

La información permite evaluar cómo se distribuyen los recursos públicos y cuál es el porcentaje del presupuesto asignado que efectivamente es ejecutado por las diferentes entidades y departamentos del país.


## 3. Variables analizadas


### Variables categóricas

| Variable | Descripción |
|---|---|
| NIVEL_GOBIERNO_NOMBRE | Clasificación del nivel de gobierno responsable del gasto |
| NIVEL_NOMBRE | Tipo de nivel presupuestal |
| PLIEGO_NOMBRE | Entidad encargada de ejecutar los recursos |
| DEPARTAMENTO_AP4_NOMBRE | Departamento donde se ejecuta el gasto |


### Variables numéricas

| Variable | Descripción |
|---|---|
| PIM | Presupuesto Institucional Modificado |
| EJECUCIÓN | Monto total ejecutado |
| porcentaje_ejecucion | Porcentaje de ejecución del presupuesto asignado |



## 4. Importación de datos

La base de datos fue importada utilizando el lenguaje R mediante la función `read.csv()`.

Durante el proceso se revisó la estructura de los datos, los nombres de variables y los tipos de información disponibles para realizar correctamente el análisis exploratorio.



## 5. Limpieza y preparación de datos

Para preparar la información se realizaron las siguientes transformaciones:

- Revisión de valores y estructura de las variables.
- Eliminación de registros correspondientes al exterior.
- Creación del indicador de ejecución presupuestal:

\[
Porcentaje\ de\ ejecución = \frac{Ejecución}{PIM} \times 100
\]

- Agrupación de información por departamento y nivel de gobierno.
- Preparación de bases resumidas para la elaboración de gráficos.



## 6. Estadísticas descriptivas

Se calcularon indicadores descriptivos para comprender las principales características del gasto público:

- Presupuesto total asignado (PIM).
- Monto ejecutado.
- Porcentaje promedio de ejecución.
- Diferencias en la ejecución presupuestal entre departamentos.


Estas medidas permitieron identificar diferencias en la capacidad de utilización de los recursos públicos.



# 7. Visualización de datos


## Gráfico 3: Porcentaje promedio de ejecución presupuestal

Este gráfico permite comparar el desempeño promedio de ejecución presupuestal entre los diferentes grupos analizados.

La visualización permite identificar diferencias en la capacidad de ejecución de los recursos asignados y observar qué grupos presentan mayores niveles de cumplimiento presupuestal.



## Gráfico 4: Porcentaje de ejecución presupuestal por departamento

Se elaboró un mapa coroplético para representar espacialmente el porcentaje promedio de ejecución presupuestal por departamento.

Los departamentos con valores más altos presentan una mayor intensidad de color, mientras que los departamentos con menores niveles de ejecución presentan tonalidades más claras.

Esta visualización permite identificar diferencias territoriales en la ejecución del gasto público.



# 8. Análisis final


## Pregunta de análisis

**¿Qué departamentos presentan mayores niveles de eficiencia en la ejecución presupuestal?**


Para responder esta pregunta se realizó un análisis adicional agrupando la información por departamento y calculando el porcentaje promedio de ejecución presupuestal.

Posteriormente se elaboró un ranking de departamentos, identificando los 10 departamentos con mayor y menor desempeño relativo en la ejecución de sus recursos.



## Indicador utilizado

El análisis final utiliza como indicador principal:

**Porcentaje promedio de ejecución presupuestal**

Este indicador permite comparar la capacidad de cada departamento para utilizar los recursos presupuestados.



## Visualización final

Se elaboró un gráfico de ranking con los 10 departamentos con mayor porcentaje promedio de ejecución presupuestal, permitiendo identificar los territorios con mejor desempeño relativo en la utilización de sus recursos públicos.

Este gráfico permite identificar los departamentos con mejor desempeño relativo en la utilización de los recursos públicos.



# 9. Principales conclusiones

El análisis exploratorio permitió identificar diferencias importantes en la ejecución presupuestal entre los departamentos del Perú.

Los resultados del análisis final muestran que los departamentos con mayores niveles de ejecución presupuestal promedio fueron Tumbes, Ucayali, la Provincia Constitucional del Callao, Loreto y Tacna, destacando por presentar los mejores niveles relativos de utilización de los recursos asignados.

Por otro lado, los departamentos con menores niveles de ejecución promedio fueron Ica, Huánuco, Apurímac, Cajamarca y La Libertad, evidenciando mayores dificultades en la ejecución del presupuesto disponible.

Estos resultados muestran que una mayor asignación presupuestal no necesariamente implica una mayor eficiencia en la ejecución del gasto público. La capacidad de gestión, planificación y ejecución institucional puede influir significativamente en el aprovechamiento de los recursos públicos.

En conclusión, el análisis evidencia la existencia de diferencias territoriales en la ejecución presupuestal, por lo que resulta importante complementar el seguimiento del presupuesto asignado con indicadores de desempeño que permitan evaluar la eficiencia del gasto público.



